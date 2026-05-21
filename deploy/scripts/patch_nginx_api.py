from pathlib import Path


path = Path("/etc/nginx/sites-available/ege_russian_app.conf")
content = path.read_text(encoding="utf-8")
if "location /api/" in content:
    raise SystemExit(0)

block = """
    location /api/ {
        proxy_pass http://127.0.0.1:8088/api/;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
"""

marker = "    location ~*"
if marker in content:
    content = content.replace(marker, block + "\n" + marker, 1)
else:
    content = content.replace("\n}", block + "\n}", 1)

path.write_text(content, encoding="utf-8")
