# ==============================================================================
# Keystore Base64 Encoder for GitHub Secrets
# ==============================================================================
# This script encodes an Android keystore file to Base64 for use in GitHub Actions
#
# Usage:
#   .\encode-keystore.ps1 -KeystorePath "path\to\upload-keystore.jks"
#
# Output:
#   - Prints Base64 string to console
#   - Saves to keystore_base64.txt
#   - Copies to clipboard (Windows)
# ==============================================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$KeystorePath
)

# Verify file exists
if (-not (Test-Path $KeystorePath)) {
    Write-Error "Keystore file not found: $KeystorePath"
    exit 1
}

# Get file info
$fileInfo = Get-Item $KeystorePath
Write-Host "📁 Encoding keystore: $($fileInfo.Name)" -ForegroundColor Cyan
Write-Host "   Size: $($fileInfo.Length) bytes"

# Read and encode
$bytes = [IO.File]::ReadAllBytes($KeystorePath)
$base64 = [Convert]::ToBase64String($bytes)

# Save to file
$outputFile = "keystore_base64.txt"
$base64 | Out-File $outputFile -Encoding ASCII -NoNewline

Write-Host ""
Write-Host "✅ Keystore encoded successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Output saved to: $outputFile"
Write-Host "Base64 length: $($base64.Length) characters"

# Copy to clipboard (Windows)
try {
    $base64 | Set-Clipboard
    Write-Host ""
    Write-Host "📋 Copied to clipboard!" -ForegroundColor Yellow
} catch {
    Write-Host ""
    Write-Host "⚠️  Could not copy to clipboard. Copy from $outputFile manually." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Go to GitHub → Repository → Settings → Secrets → Actions"
Write-Host "2. Add new secret: KEYSTORE_BASE64"
Write-Host "3. Paste the Base64 content from clipboard or $outputFile"
Write-Host ""
Write-Host "⚠️  SECURITY: Delete $outputFile after copying to GitHub Secrets!" -ForegroundColor Red
