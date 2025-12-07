# Pre-commit Secret Scanner for ASD-SmartCare
# Run this script before committing to check for accidentally staged secrets
#
# Usage:
#   .\scripts\check_secrets.ps1
#
# To set up as a Git hook:
#   Copy this to .git/hooks/pre-commit (without .ps1 extension)
#   Or configure in your Git client

param(
    [switch]$Verbose
)

$ErrorActionPreference = "Stop"

# Define patterns that indicate potential secrets
$secretPatterns = @(
    @{ Name = "Stripe Secret Key"; Pattern = "sk_(test|live)_[A-Za-z0-9]{20,}" },
    @{ Name = "Stripe Publishable Key"; Pattern = "pk_(test|live)_[A-Za-z0-9]{20,}" },
    @{ Name = "Generic API Key"; Pattern = "api[_-]?key\s*[:=]\s*['\"][A-Za-z0-9_\-]{20,}['\"]" },
    @{ Name = "Generic Secret"; Pattern = "secret\s*[:=]\s*['\"][A-Za-z0-9_\-]{20,}['\"]" },
    @{ Name = "Password Assignment"; Pattern = "password\s*[:=]\s*['\"][^'\"]+['\"]" },
    @{ Name = "Bearer Token"; Pattern = "Bearer\s+[A-Za-z0-9_\-\.]{20,}" },
    @{ Name = "Firebase Config"; Pattern = "apiKey:\s*['\"][A-Za-z0-9_\-]{30,}['\"]" },
    @{ Name = "Private Key Header"; Pattern = "-----BEGIN\s+(RSA\s+)?PRIVATE\s+KEY-----" },
    @{ Name = "AWS Access Key"; Pattern = "AKIA[0-9A-Z]{16}" },
    @{ Name = "Google OAuth"; Pattern = "[0-9]+-[a-z0-9_]{32}\.apps\.googleusercontent\.com" }
)

# File extensions to scan
$includeExtensions = @(".dart", ".yaml", ".yml", ".json", ".properties", ".xml", ".gradle")

# Files/directories to exclude
$excludePatterns = @(
    "*.g.dart",
    "*.freezed.dart",
    "*.mocks.dart",
    ".env.example",
    "pubspec.lock",
    "*.md"
)

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Test-ShouldExclude {
    param([string]$FilePath)
    
    foreach ($pattern in $excludePatterns) {
        if ($FilePath -like $pattern) {
            return $true
        }
    }
    return $false
}

function Test-ShouldInclude {
    param([string]$FilePath)
    
    $extension = [System.IO.Path]::GetExtension($FilePath)
    return $includeExtensions -contains $extension
}

# Main execution
Write-ColorOutput "`n🔍 Scanning for potential secrets..." "Cyan"
Write-ColorOutput "=" * 50 "Gray"

$foundSecrets = @()
$scannedFiles = 0

# Get files to scan - either staged files or all lib files
try {
    $stagedFiles = git diff --cached --name-only --diff-filter=ACM 2>$null
    if ($stagedFiles) {
        $filesToScan = $stagedFiles
        Write-ColorOutput "Scanning staged files..." "Gray"
    } else {
        # If no staged files, scan lib directory
        $filesToScan = Get-ChildItem -Path "lib" -Recurse -File | ForEach-Object { $_.FullName }
        Write-ColorOutput "No staged files. Scanning lib directory..." "Gray"
    }
} catch {
    # Not in a git repo or git not available
    $filesToScan = Get-ChildItem -Path "lib" -Recurse -File | ForEach-Object { $_.FullName }
    Write-ColorOutput "Scanning lib directory..." "Gray"
}

foreach ($file in $filesToScan) {
    # Skip if file doesn't exist (might be deleted)
    if (-not (Test-Path $file)) {
        continue
    }
    
    # Check if file should be included
    if (-not (Test-ShouldInclude $file)) {
        continue
    }
    
    # Check if file should be excluded
    if (Test-ShouldExclude $file) {
        continue
    }
    
    $scannedFiles++
    
    if ($Verbose) {
        Write-ColorOutput "  Scanning: $file" "Gray"
    }
    
    try {
        $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
        if (-not $content) { continue }
        
        $lineNumber = 0
        foreach ($line in (Get-Content $file)) {
            $lineNumber++
            
            foreach ($pattern in $secretPatterns) {
                if ($line -match $pattern.Pattern) {
                    # Check if it's a placeholder or example
                    $isPlaceholder = $line -match "(PLACEHOLDER|example|your_|xxx|___)"
                    $isEnvVar = $line -match "String\.fromEnvironment|process\.env|dotenv"
                    
                    if (-not $isPlaceholder -and -not $isEnvVar) {
                        $foundSecrets += @{
                            File = $file
                            Line = $lineNumber
                            Type = $pattern.Name
                            Content = $line.Trim().Substring(0, [Math]::Min(80, $line.Trim().Length))
                        }
                    }
                }
            }
        }
    } catch {
        Write-ColorOutput "  ⚠️ Could not read: $file" "Yellow"
    }
}

Write-ColorOutput "`nScanned $scannedFiles files" "Gray"

if ($foundSecrets.Count -gt 0) {
    Write-ColorOutput "`n❌ POTENTIAL SECRETS FOUND!" "Red"
    Write-ColorOutput "=" * 50 "Red"
    
    foreach ($secret in $foundSecrets) {
        Write-ColorOutput "`n📁 File: $($secret.File)" "Yellow"
        Write-ColorOutput "   Line: $($secret.Line)" "White"
        Write-ColorOutput "   Type: $($secret.Type)" "Magenta"
        Write-ColorOutput "   Content: $($secret.Content)..." "Gray"
    }
    
    Write-ColorOutput "`n⛔ Commit blocked! Please remove secrets before committing." "Red"
    Write-ColorOutput "   Consider using environment variables or .env files." "Yellow"
    Write-ColorOutput "   See SECURITY.md for guidance.`n" "Yellow"
    
    exit 1
} else {
    Write-ColorOutput "`n✅ No secrets detected!" "Green"
    Write-ColorOutput "   Scanned $scannedFiles files across $($secretPatterns.Count) secret patterns.`n" "Gray"
    exit 0
}
