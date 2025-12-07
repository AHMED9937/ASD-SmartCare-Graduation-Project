# MVC Conversion Script
# Converts Clean Architecture structure to MVC for a specific feature

param(
    [Parameter(Mandatory=$true)]
    [string]$FeaturePath
)

$ErrorActionPreference = "Stop"

Write-Host "Converting $FeaturePath to MVC architecture..." -ForegroundColor Cyan

# Step 1: Create MVC directories
$mvcDirs = @("models", "controllers", "views")
foreach ($dir in $mvcDirs) {
    $dirPath = Join-Path $FeaturePath $dir
    if (-not (Test-Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
        Write-Host "  Created: $dir/" -ForegroundColor Green
    }
}

# Step 2: Find and move files
$presentationPath = Join-Path $FeaturePath "presentation"
if (Test-Path $presentationPath) {
    
    # Move model files
    $modelFiles = Get-ChildItem -Path $presentationPath -Recurse -Filter "*.dart" | Where-Object {
        $_.DirectoryName -match "\\model\\?" -and $_.Name -notmatch "(cubit|state|screen|widget)" 
    }
    foreach ($file in $modelFiles) {
        $destPath = Join-Path $FeaturePath "models"
        $destFile = Join-Path $destPath $file.Name
        Move-Item -Path $file.FullName -Destination $destFile -Force
        Write-Host "  Moved to models/: $($file.Name)" -ForegroundColor Yellow
    }
    
    # Move cubit/controller files
    $cubitFiles = Get-ChildItem -Path $presentationPath -Recurse -Filter "*.dart" | Where-Object {
        $_.DirectoryName -match "(\\cubit\\?|\\Cubit\\?|Cubits)" -or $_.Name -match "(cubit|state)\.dart$"
    }
    foreach ($file in $cubitFiles) {
        $destPath = Join-Path $FeaturePath "controllers"
        $destFile = Join-Path $destPath $file.Name
        if (-not (Test-Path $destFile)) {
            Move-Item -Path $file.FullName -Destination $destFile -Force
            Write-Host "  Moved to controllers/: $($file.Name)" -ForegroundColor Yellow
        }
    }
    
    # Move view files (screens, widgets, everything else)
    $viewFiles = Get-ChildItem -Path $presentationPath -Recurse -Filter "*.dart"
    foreach ($file in $viewFiles) {
        $destPath = Join-Path $FeaturePath "views"
        $destFile = Join-Path $destPath $file.Name
        if (-not (Test-Path $destFile)) {
            Move-Item -Path $file.FullName -Destination $destFile -Force
            Write-Host "  Moved to views/: $($file.Name)" -ForegroundColor Yellow
        }
    }
    
    # Remove presentation directory and subdirs
    Remove-Item -Path $presentationPath -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  Removed: presentation/" -ForegroundColor Red
}

# Step 3: Update imports in the feature
$featureName = Split-Path $FeaturePath -Leaf
Write-Host "`nUpdating imports for $featureName feature..." -ForegroundColor Cyan

Get-ChildItem -Path $FeaturePath -Recurse -Filter "*.dart" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $originalContent = $content
    
    # Replace presentation subpaths
    $content = $content -replace "features/$featureName/presentation/model/", "features/$featureName/models/"
    $content = $content -replace "features/$featureName/presentation/Model/", "features/$featureName/models/"
    $content = $content -replace "features/$featureName/presentation/cubit/", "features/$featureName/controllers/"
    $content = $content -replace "features/$featureName/presentation/Cubit/", "features/$featureName/controllers/"
    $content = $content -replace "features/$featureName/presentation/LoginCubits/", "features/$featureName/controllers/"
    $content = $content -replace "features/$featureName/presentation/ForgetPassword/cubit/", "features/$featureName/controllers/"
    $content = $content -replace "features/$featureName/presentation/screen/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/Screen/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/screens/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/Screens/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/widgets/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/Widgets/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/login/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/signup/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/onboarding/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/ForgetPassword/Screens/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/booking/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/doctors_list/", "features/$featureName/views/"
    $content = $content -replace "features/$featureName/presentation/controller/", "features/$featureName/controllers/"
    $content = $content -replace "features/$featureName/presentation/Controller/", "features/$featureName/controllers/"
    
    if ($content -ne $originalContent) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "  Updated imports: $($_.Name)" -ForegroundColor Magenta
    }
}

Write-Host "`nMVC conversion complete for $featureName!" -ForegroundColor Green
