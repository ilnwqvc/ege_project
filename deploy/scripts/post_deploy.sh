#!/usr/bin/env bash
set -euo pipefail

APP_ROOT="${1:?APP_ROOT is required}"
RELEASE_NAME="${2:?RELEASE_NAME is required}"
ARCHIVE_PATH="${3:?ARCHIVE_PATH is required}"

RELEASE_DIR="$APP_ROOT/releases/$RELEASE_NAME"
CURRENT_LINK="$APP_ROOT/current"

mkdir -p "$RELEASE_DIR"
tar -xzf "$ARCHIVE_PATH" -C "$RELEASE_DIR"

ln -sfn "$RELEASE_DIR" "$CURRENT_LINK"

find "$APP_ROOT/releases" -mindepth 1 -maxdepth 1 -type d | sort | head -n -5 | xargs -r rm -rf

echo "Release deployed: $RELEASE_DIR"
echo "Current symlink -> $CURRENT_LINK"
