#!/usr/bin/env bash
set -euo pipefail

DOMAIN="${1:-}"
APP_ROOT="/var/www/ege-russian-app"

if [[ -z "$DOMAIN" ]]; then
  echo "Usage: sudo bash deploy/scripts/bootstrap_server.sh example.com"
  exit 1
fi

apt-get update
apt-get install -y nginx unzip curl tar

mkdir -p "$APP_ROOT/releases"
mkdir -p "$APP_ROOT/shared"

cp deploy/nginx/ege_russian_app.conf /etc/nginx/sites-available/ege_russian_app.conf
sed -i "s/your-domain.ru/${DOMAIN}/g" /etc/nginx/sites-available/ege_russian_app.conf

ln -sf /etc/nginx/sites-available/ege_russian_app.conf /etc/nginx/sites-enabled/ege_russian_app.conf
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl enable nginx
systemctl restart nginx

echo "Server bootstrap complete."
echo "App root: $APP_ROOT"
echo "Domain: $DOMAIN"
echo "Next step: point DNS to this VM, then run certbot."
