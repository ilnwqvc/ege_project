param(
    [Parameter(Mandatory = $true)]
    [string]$HostName,

    [Parameter(Mandatory = $true)]
    [string]$User,

    [Parameter(Mandatory = $true)]
    [string]$Domain,

    [Parameter(Mandatory = $true)]
    [string]$DeployPath,

    [Parameter(Mandatory = $true)]
    [string]$SshKeyPath,

    [int]$Port = 22,
    [switch]$SkipBuild,
    [switch]$SkipCertbot
)

$ErrorActionPreference = "Stop"

function Require-Command {
    param([string]$Name)
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Command not found: $Name"
    }
}

function Invoke-Native {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,

        [Parameter()]
        [string[]]$Arguments = @()
    )

    & $FilePath @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code ${LASTEXITCODE}: $FilePath $($Arguments -join ' ')"
    }
}

Require-Command ssh
Require-Command scp
Require-Command ssh-keygen
Require-Command tar

if (-not (Test-Path $SshKeyPath)) {
    throw "SSH key not found: $SshKeyPath"
}

$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$secretsDir = Join-Path $root "deploy\.secrets"
$githubKeyPath = $SshKeyPath
$githubPubKeyPath = "$SshKeyPath.pub"
$releaseId = Get-Date -Format "yyyyMMddHHmmss"
$archivePath = Join-Path $root "ege-russian-app-web-$releaseId.tar.gz"
$remoteArchivePath = "/tmp/ege-russian-app-web-$releaseId.tar.gz"
$nginxLocalPath = Join-Path $root "deploy\nginx\ege_russian_app.conf"
$apiLocalPath = Join-Path $root "server\auth_api.py"
$apiServiceLocalPath = Join-Path $root "deploy\systemd\ege-russian-api.service"
$nginxRemoteTmpPath = "/tmp/ege_russian_app.conf"
$apiRemoteTmpPath = "/tmp/ege_auth_api.py"
$apiServiceRemoteTmpPath = "/tmp/ege-russian-api.service"
$remotePubKeyPath = "/tmp/github_actions_ed25519.pub"

New-Item -ItemType Directory -Force -Path $secretsDir | Out-Null

if (-not (Test-Path $githubPubKeyPath)) {
    throw "Public key not found next to SSH key: $githubPubKeyPath"
}

Push-Location $root
try {
    if (-not $SkipBuild) {
        Invoke-Native -FilePath "C:\flutter\bin\flutter.bat" -Arguments @("pub", "get")
        Invoke-Native -FilePath "C:\flutter\bin\flutter.bat" -Arguments @("build", "web", "--release")
    }

    Invoke-Native -FilePath "tar" -Arguments @("-czf", $archivePath, "-C", "build/web", ".")

    Invoke-Native -FilePath "scp" -Arguments @("-i", $SshKeyPath, "-P", "$Port", $nginxLocalPath, "${User}@${HostName}:${nginxRemoteTmpPath}")
    Invoke-Native -FilePath "scp" -Arguments @("-i", $SshKeyPath, "-P", "$Port", $apiLocalPath, "${User}@${HostName}:${apiRemoteTmpPath}")
    Invoke-Native -FilePath "scp" -Arguments @("-i", $SshKeyPath, "-P", "$Port", $apiServiceLocalPath, "${User}@${HostName}:${apiServiceRemoteTmpPath}")
    Invoke-Native -FilePath "scp" -Arguments @("-i", $SshKeyPath, "-P", "$Port", $archivePath, "${User}@${HostName}:${remoteArchivePath}")
    Invoke-Native -FilePath "scp" -Arguments @("-i", $SshKeyPath, "-P", "$Port", $githubPubKeyPath, "${User}@${HostName}:${remotePubKeyPath}")

    $remoteScript = @'
set -euo pipefail

DOMAIN="__DOMAIN__"
APP_ROOT="__DEPLOY_PATH__"
RELEASE_NAME="__RELEASE_ID__"
ARCHIVE_PATH="__REMOTE_ARCHIVE__"
REMOTE_PUBKEY_PATH="__REMOTE_PUBKEY__"
RELEASE_DIR="$APP_ROOT/releases/$RELEASE_NAME"
CURRENT_LINK="$APP_ROOT/current"

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
PUBKEY_CONTENT="$(tr -d '\r' < "$REMOTE_PUBKEY_PATH")"
printf '%s\n' "$PUBKEY_CONTENT" >> ~/.ssh/authorized_keys
sort -u ~/.ssh/authorized_keys -o ~/.ssh/authorized_keys
rm -f "$REMOTE_PUBKEY_PATH"

sudo apt-get update
sudo apt-get install -y nginx certbot python3-certbot-nginx unzip curl tar
sudo install -d -o www-data -g www-data /var/lib/ege-russian-app
sudo install -d /opt/ege-russian-app-api
sudo install -m 0755 /tmp/ege_auth_api.py /opt/ege-russian-app-api/auth_api.py
sudo install -m 0644 /tmp/ege-russian-api.service /etc/systemd/system/ege-russian-api.service
sudo install -d /etc/ege-russian-app
if [ ! -f /etc/ege-russian-app/api.env ]; then
  SECRET="$(python3 - <<'PY'
import secrets
print(secrets.token_urlsafe(48))
PY
)"
  printf 'EGE_API_SECRET=%s\n' "$SECRET" | sudo tee /etc/ege-russian-app/api.env >/dev/null
  sudo chmod 600 /etc/ege-russian-app/api.env
fi
sudo systemctl daemon-reload
sudo systemctl enable ege-russian-api
sudo systemctl restart ege-russian-api

sudo mkdir -p "$APP_ROOT/releases"
sudo mkdir -p "$APP_ROOT/shared"
sudo chown -R "$USER:$USER" "$APP_ROOT"

if [ ! -f /etc/nginx/sites-available/ege_russian_app.conf ]; then
  sudo mv /tmp/ege_russian_app.conf /etc/nginx/sites-available/ege_russian_app.conf
else
  rm -f /tmp/ege_russian_app.conf
fi
sudo ln -sf /etc/nginx/sites-available/ege_russian_app.conf /etc/nginx/sites-enabled/ege_russian_app.conf
sudo rm -f /etc/nginx/sites-enabled/default

mkdir -p "$RELEASE_DIR"
tar -xzf "$ARCHIVE_PATH" -C "$RELEASE_DIR"
ln -sfn "$RELEASE_DIR" "$CURRENT_LINK"
find "$APP_ROOT/releases" -mindepth 1 -maxdepth 1 -type d | sort | head -n -5 | xargs -r rm -rf
rm -f "$ARCHIVE_PATH"

sudo nginx -t
sudo systemctl enable nginx
sudo systemctl restart nginx
'@

    $remoteScript = $remoteScript.Replace('__DOMAIN__', $Domain)
    $remoteScript = $remoteScript.Replace('__DEPLOY_PATH__', $DeployPath)
    $remoteScript = $remoteScript.Replace('__RELEASE_ID__', $releaseId)
    $remoteScript = $remoteScript.Replace('__REMOTE_ARCHIVE__', $remoteArchivePath)
    $remoteScript = $remoteScript.Replace('__REMOTE_PUBKEY__', $remotePubKeyPath)

    Invoke-Native -FilePath "ssh" -Arguments @("-i", $SshKeyPath, "-p", "$Port", "${User}@${HostName}", $remoteScript)

    if (-not $SkipCertbot) {
        $dnsOk = $false
        try {
            $resolved = Resolve-DnsName -Name $Domain -Type A -ErrorAction Stop
            $dnsOk = $resolved.IPAddress -contains $HostName
        }
        catch {
            $dnsOk = $false
        }

        if ($dnsOk) {
            Invoke-Native -FilePath "ssh" -Arguments @(
                "-i", $SshKeyPath,
                "-p", "$Port",
                "${User}@${HostName}",
                "sudo certbot --nginx -d $Domain -d www.$Domain --non-interactive --agree-tos -m admin@$Domain --redirect"
            )
        }
        else {
            Write-Host "DNS for $Domain does not point to $HostName yet. Skipping certbot for now."
        }
    }

    Write-Host ""
    Write-Host "Server provisioned and release deployed."
    Write-Host "Site root: $DeployPath/current"
    Write-Host "Domain: $Domain"
    Write-Host ""
    Write-Host "GitHub Secrets to set:"
    Write-Host "DEPLOY_HOST = $HostName"
    Write-Host "DEPLOY_USER = $User"
    Write-Host "DEPLOY_PORT = $Port"
    Write-Host "DEPLOY_PATH = $DeployPath"
    Write-Host "DEPLOY_SSH_KEY = content of $githubKeyPath"
}
finally {
    Pop-Location
    if (Test-Path $archivePath) {
        Remove-Item $archivePath -Force
    }
}
