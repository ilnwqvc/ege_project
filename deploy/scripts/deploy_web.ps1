param(
    [Parameter(Mandatory = $true)]
    [string]$HostName,

    [Parameter(Mandatory = $true)]
    [string]$User,

    [Parameter(Mandatory = $true)]
    [string]$DeployPath,

    [Parameter(Mandatory = $true)]
    [string]$SshKeyPath,

    [int]$Port = 22
)

$ErrorActionPreference = "Stop"

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

if (-not (Test-Path $SshKeyPath)) {
    throw "SSH key not found: $SshKeyPath"
}

$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$releaseId = Get-Date -Format "yyyyMMddHHmmss"
$archivePath = Join-Path $root "ege-russian-app-web-$releaseId.tar.gz"

Push-Location $root
try {
    Invoke-Native -FilePath "C:\flutter\bin\flutter.bat" -Arguments @("pub", "get")
    Invoke-Native -FilePath "C:\flutter\bin\flutter.bat" -Arguments @("build", "web", "--release")

    Invoke-Native -FilePath "tar" -Arguments @("-czf", $archivePath, "-C", "build/web", ".")

    Invoke-Native -FilePath "scp" -Arguments @("-i", $SshKeyPath, "-P", "$Port", $archivePath, "${User}@${HostName}:/tmp/ege-russian-app-web-$releaseId.tar.gz")

    Invoke-Native -FilePath "ssh" -Arguments @("-i", $SshKeyPath, "-p", "$Port", "${User}@${HostName}", @"
set -euo pipefail
APP_ROOT="$DeployPath"
RELEASE_NAME="$releaseId"
ARCHIVE_PATH="/tmp/ege-russian-app-web-$releaseId.tar.gz"
RELEASE_DIR="`$APP_ROOT/releases/`$RELEASE_NAME"
CURRENT_LINK="`$APP_ROOT/current"

mkdir -p "`$APP_ROOT/releases"
mkdir -p "`$RELEASE_DIR"
tar -xzf "`$ARCHIVE_PATH" -C "`$RELEASE_DIR"
ln -sfn "`$RELEASE_DIR" "`$CURRENT_LINK"
find "`$APP_ROOT/releases" -mindepth 1 -maxdepth 1 -type d | sort | head -n -5 | xargs -r rm -rf
rm -f "`$ARCHIVE_PATH"
echo "Release deployed: `$RELEASE_NAME"
"@)
}
finally {
    Pop-Location
    if (Test-Path $archivePath) {
        Remove-Item $archivePath -Force
    }
}
