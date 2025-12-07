# =============================================================================
# ASD SmartCare - Keystore Encoding Script (PowerShell)
# =============================================================================
#
# This script encodes your Android keystore file to Base64 for use with
# GitHub Secrets in CI/CD workflows.
#
# Usage:
#   .\scripts\encode-keystore.ps1 -KeystorePath "android\upload-keystore.jks"
#
# The output can be copied directly to GitHub Secrets as KEYSTORE_BASE64.
#
# =============================================================================

param(
    [Parameter(Mandatory=$false)]
    [string]$KeystorePath = "android\upload-keystore.jks"
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Blue
Write-Host "  ASD SmartCare - Keystore Encoder for GitHub Secrets" -ForegroundColor Blue
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Blue
Write-Host ""

# Resolve path relative to script location or absolute
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

# Try different path resolutions
$ResolvedPath = $null
$PathsToTry = @(
    $KeystorePath,
    (Join-Path $ProjectRoot $KeystorePath),
    (Join-Path $PWD $KeystorePath)
)

foreach ($Path in $PathsToTry) {
    if (Test-Path $Path) {
        $ResolvedPath = Resolve-Path $Path
        break
    }
}

if (-not $ResolvedPath) {
    Write-Host "✗ Keystore file not found: $KeystorePath" -ForegroundColor Red
    Write-Host ""
    Write-Host "Searched locations:" -ForegroundColor Yellow
    foreach ($Path in $PathsToTry) {
        Write-Host "  - $Path" -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Cyan
    Write-Host "  .\scripts\encode-keystore.ps1 -KeystorePath 'path\to\keystore.jks'" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Example:" -ForegroundColor Cyan
    Write-Host "  .\scripts\encode-keystore.ps1 -KeystorePath 'android\upload-keystore.jks'" -ForegroundColor Cyan
    exit 1
}

Write-Host "✓ Found keystore: $ResolvedPath" -ForegroundColor Green

# Get file info
$FileInfo = Get-Item $ResolvedPath
$FileSizeKB = [math]::Round($FileInfo.Length / 1KB, 2)

Write-Host "  Size: $FileSizeKB KB" -ForegroundColor Gray
Write-Host "  Modified: $($FileInfo.LastWriteTime)" -ForegroundColor Gray
Write-Host ""

# Encode to Base64
Write-Host "Encoding to Base64..." -ForegroundColor Cyan
$Bytes = [System.IO.File]::ReadAllBytes($ResolvedPath)
$Base64 = [System.Convert]::ToBase64String($Bytes)
$Base64Length = $Base64.Length

Write-Host "✓ Encoded successfully!" -ForegroundColor Green
Write-Host "  Base64 length: $Base64Length characters" -ForegroundColor Gray
Write-Host ""

# Output options
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Blue
Write-Host "  GitHub Secrets Setup Instructions" -ForegroundColor Blue
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Blue
Write-Host ""
Write-Host "1. Go to your GitHub repository" -ForegroundColor White
Write-Host "2. Navigate to: Settings → Secrets and variables → Actions" -ForegroundColor White
Write-Host "3. Click 'New repository secret'" -ForegroundColor White
Write-Host "4. Add these secrets:" -ForegroundColor White
Write-Host ""
Write-Host "   Secret Name: KEYSTORE_BASE64" -ForegroundColor Yellow
Write-Host "   Value: (see below or copied to clipboard)" -ForegroundColor Yellow
Write-Host ""
Write-Host "   Secret Name: KEYSTORE_PASSWORD" -ForegroundColor Yellow
Write-Host "   Value: (your keystore password)" -ForegroundColor Yellow
Write-Host ""
Write-Host "   Secret Name: KEY_ALIAS" -ForegroundColor Yellow
Write-Host "   Value: upload (or your key alias)" -ForegroundColor Yellow
Write-Host ""
Write-Host "   Secret Name: KEY_PASSWORD" -ForegroundColor Yellow
Write-Host "   Value: (your key password)" -ForegroundColor Yellow
Write-Host ""

# Copy to clipboard if possible
try {
    $Base64 | Set-Clipboard
    Write-Host "✓ Base64 string copied to clipboard!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Paste it directly as the KEYSTORE_BASE64 secret value." -ForegroundColor Cyan
} catch {
    Write-Host "Could not copy to clipboard. Base64 string saved to file." -ForegroundColor Yellow
}

# Save to file as backup
$OutputFile = Join-Path $ProjectRoot "keystore-base64.txt"
$Base64 | Out-File -FilePath $OutputFile -NoNewline -Encoding ASCII
Write-Host ""
Write-Host "Base64 also saved to: $OutputFile" -ForegroundColor Gray
Write-Host ""
Write-Host "⚠ SECURITY WARNING:" -ForegroundColor Red
Write-Host "  Delete the keystore-base64.txt file after copying to GitHub!" -ForegroundColor Red
Write-Host "  Do NOT commit this file to version control!" -ForegroundColor Red
Write-Host ""

# Optionally display the base64 string
Write-Host "Would you like to display the Base64 string? (y/n): " -NoNewline -ForegroundColor Cyan
$Response = Read-Host

if ($Response -eq 'y' -or $Response -eq 'Y') {
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Blue
    Write-Host "  KEYSTORE_BASE64 Value (copy this entire string)" -ForegroundColor Blue
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Blue
    Write-Host ""
    Write-Host $Base64
    Write-Host ""
}

Write-Host "Done!" -ForegroundColor Green
