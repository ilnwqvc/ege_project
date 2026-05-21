#!/usr/bin/env python3
import base64
import hashlib
import hmac
import json
import os
import secrets
import sqlite3
import time
import uuid
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path


DB_PATH = Path(os.environ.get("EGE_API_DB", "/var/lib/ege-russian-app/api.sqlite3"))
SECRET_VALUE = os.environ.get("EGE_API_SECRET")
if not SECRET_VALUE:
    raise RuntimeError("EGE_API_SECRET is required")

SECRET = SECRET_VALUE.encode("utf-8")
TOKEN_TTL_SECONDS = 60 * 60 * 24 * 30


def connect():
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn


def migrate():
    with connect() as db:
        db.execute(
            """
            create table if not exists users (
              id text primary key,
              email text not null unique,
              display_name text not null,
              password_hash text not null,
              password_salt text not null,
              created_at integer not null,
              last_login_at integer
            )
            """
        )
        db.execute(
            """
            create table if not exists attempts (
              id integer primary key autoincrement,
              user_id text not null references users(id),
              practice_item_id text not null,
              task_number integer not null,
              selected_index integer not null,
              is_correct integer not null,
              rule_summary text,
              answered_at integer not null
            )
            """
        )
        columns = {
            row["name"]
            for row in db.execute("pragma table_info(attempts)").fetchall()
        }
        if "rule_summary" not in columns:
            db.execute("alter table attempts add column rule_summary text")


def hash_password(password, salt):
    digest = hashlib.pbkdf2_hmac(
        "sha256",
        password.encode("utf-8"),
        salt.encode("utf-8"),
        160_000,
    )
    return base64.urlsafe_b64encode(digest).decode("ascii")


def make_token(user_id):
    expires_at = int(time.time()) + TOKEN_TTL_SECONDS
    payload = f"{user_id}:{expires_at}"
    signature = hmac.new(SECRET, payload.encode("utf-8"), hashlib.sha256).digest()
    raw = payload.encode("utf-8") + b"." + base64.urlsafe_b64encode(signature)
    return base64.urlsafe_b64encode(raw).decode("ascii")


def read_token(token):
    try:
        raw = base64.urlsafe_b64decode(token.encode("ascii"))
        payload, signature = raw.rsplit(b".", 1)
        expected = base64.urlsafe_b64encode(
            hmac.new(SECRET, payload, hashlib.sha256).digest()
        )
        if not hmac.compare_digest(signature, expected):
            return None
        user_id, expires_at_text = payload.decode("utf-8").split(":", 1)
        if int(expires_at_text) < int(time.time()):
            return None
        return user_id
    except Exception:
        return None


def public_user(row):
    return {
        "id": row["id"],
        "email": row["email"],
        "displayName": row["display_name"],
    }


class ApiHandler(BaseHTTPRequestHandler):
    server_version = "EgeRussianApi/1.0"

    def do_GET(self):
        if self.path == "/api/health":
            self.send_json({"ok": True})
            return
        if self.path == "/api/progress/attempts":
            self.list_attempts()
            return
        self.send_json({"error": "Not found"}, status=404)

    def do_POST(self):
        if self.path == "/api/auth/register":
            self.register()
            return
        if self.path == "/api/auth/login":
            self.login()
            return
        if self.path == "/api/progress/attempts":
            self.record_attempt()
            return
        self.send_json({"error": "Not found"}, status=404)

    def register(self):
        data = self.read_json()
        email = str(data.get("email", "")).strip().lower()
        display_name = str(data.get("displayName", "")).strip()
        password = str(data.get("password", ""))
        if "@" not in email or "." not in email:
            self.send_json({"error": "Введите нормальную почту."}, status=400)
            return
        if len(display_name) < 2:
            self.send_json({"error": "Имя профиля должно быть чуть длиннее."}, status=400)
            return
        if len(password) < 6:
            self.send_json({"error": "Пароль должен быть минимум 6 символов."}, status=400)
            return

        now = int(time.time())
        user_id = str(uuid.uuid4())
        salt = secrets.token_urlsafe(24)
        password_hash = hash_password(password, salt)
        try:
            with connect() as db:
                db.execute(
                    """
                    insert into users (id, email, display_name, password_hash, password_salt, created_at, last_login_at)
                    values (?, ?, ?, ?, ?, ?, ?)
                    """,
                    (user_id, email, display_name, password_hash, salt, now, now),
                )
                user = db.execute("select * from users where id = ?", (user_id,)).fetchone()
        except sqlite3.IntegrityError:
            self.send_json({"error": "Профиль с такой почтой уже есть."}, status=409)
            return

        self.send_json({"token": make_token(user_id), "user": public_user(user)})

    def login(self):
        data = self.read_json()
        email = str(data.get("email", "")).strip().lower()
        password = str(data.get("password", ""))
        with connect() as db:
            user = db.execute("select * from users where email = ?", (email,)).fetchone()
            if user is None:
                self.send_json({"error": "Профиль не найден."}, status=404)
                return
            if user["password_hash"] != hash_password(password, user["password_salt"]):
                self.send_json({"error": "Пароль не подошёл."}, status=401)
                return
            db.execute(
                "update users set last_login_at = ? where id = ?",
                (int(time.time()), user["id"]),
            )

        self.send_json({"token": make_token(user["id"]), "user": public_user(user)})

    def record_attempt(self):
        user_id = self.require_user()
        if user_id is None:
            return
        data = self.read_json()
        with connect() as db:
            db.execute(
                """
                insert into attempts (user_id, practice_item_id, task_number, selected_index, is_correct, rule_summary, answered_at)
                values (?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    user_id,
                    str(data.get("practiceItemId", "")),
                    int(data.get("taskNumber", 0)),
                    int(data.get("selectedIndex", -1)),
                    1 if bool(data.get("isCorrect", False)) else 0,
                    str(data.get("ruleSummary", "")),
                    int(time.time()),
                ),
            )
        self.send_json({"ok": True})

    def list_attempts(self):
        user_id = self.require_user()
        if user_id is None:
            return

        with connect() as db:
            rows = db.execute(
                """
                select id, practice_item_id, task_number, selected_index, is_correct, rule_summary, answered_at
                from attempts
                where user_id = ?
                order by answered_at asc, id asc
                """,
                (user_id,),
            ).fetchall()

        self.send_json(
            {
                "attempts": [
                    {
                        "id": row["id"],
                        "practiceItemId": row["practice_item_id"],
                        "taskNumber": row["task_number"],
                        "selectedIndex": row["selected_index"],
                        "isCorrect": bool(row["is_correct"]),
                        "ruleSummary": row["rule_summary"] or "",
                        "answeredAt": row["answered_at"],
                    }
                    for row in rows
                ]
            }
        )

    def require_user(self):
        header = self.headers.get("Authorization", "")
        if not header.startswith("Bearer "):
            self.send_json({"error": "Нужна авторизация."}, status=401)
            return None
        user_id = read_token(header.removeprefix("Bearer ").strip())
        if user_id is None:
            self.send_json({"error": "Сессия устарела, войдите заново."}, status=401)
            return None
        return user_id

    def read_json(self):
        length = int(self.headers.get("Content-Length", "0"))
        if length <= 0:
            return {}
        raw = self.rfile.read(length)
        try:
            return json.loads(raw.decode("utf-8"))
        except json.JSONDecodeError:
            return {}

    def send_json(self, data, status=200):
        raw = json.dumps(data, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers()
        self.wfile.write(raw)

    def log_message(self, fmt, *args):
        print(f"{self.address_string()} - {fmt % args}")


def main():
    migrate()
    port = int(os.environ.get("PORT", "8088"))
    server = ThreadingHTTPServer(("127.0.0.1", port), ApiHandler)
    print(f"API listening on 127.0.0.1:{port}, db={DB_PATH}")
    server.serve_forever()


if __name__ == "__main__":
    main()
