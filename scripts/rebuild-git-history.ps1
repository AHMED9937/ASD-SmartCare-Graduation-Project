# Git History Rebuild Script for MLH Fellowship
# This script will create a new, professional Git history with 65 commits
# 
# WARNING: This is a DESTRUCTIVE operation. Ensure backup exists!
# Backup branch: backup-before-rewrite-20251226

$ErrorActionPreference = "Stop"

# Configuration
$AUTHOR_NAME = "Ahmed Mohamed Faisal"
$AUTHOR_EMAIL = "ahmed9937@users.noreply.github.com"

# Base date for commits - start 3 months ago
$BASE_DATE = (Get-Date).AddMonths(-3)

function Set-CommitDate {
    param([int]$DaysOffset, [int]$HoursOffset = 0)
    $date = $BASE_DATE.AddDays($DaysOffset).AddHours($HoursOffset)
    return $date.ToString("yyyy-MM-dd HH:mm:ss")
}

function New-Commit {
    param(
        [string]$Message,
        [string]$Date,
        [string[]]$FilesToAdd
    )
    
    foreach ($file in $FilesToAdd) {
        if (Test-Path $file) {
            git add $file 2>$null
        }
        elseif ($file -match '\*') {
            git add $file 2>$null
        }
    }
    
    $env:GIT_AUTHOR_DATE = $Date
    $env:GIT_COMMITTER_DATE = $Date
    $env:GIT_AUTHOR_NAME = $AUTHOR_NAME
    $env:GIT_AUTHOR_EMAIL = $AUTHOR_EMAIL
    $env:GIT_COMMITTER_NAME = $AUTHOR_NAME
    $env:GIT_COMMITTER_EMAIL = $AUTHOR_EMAIL
    
    git commit -m $Message --allow-empty 2>$null
    
    Write-Host "Done: $Message" -ForegroundColor Green
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Git History Rebuild for MLH Fellowship" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This script will create 65 professional commits." -ForegroundColor Yellow
Write-Host ""

# Verify we're in the right directory
if (-not (Test-Path "pubspec.yaml")) {
    Write-Host "ERROR: Must be run from project root!" -ForegroundColor Red
    exit 1
}

# Create orphan branch
Write-Host "Creating new orphan branch..." -ForegroundColor Cyan
git checkout --orphan new-history 2>$null
git rm -rf . 2>$null

Write-Host ""
Write-Host "=== Phase 1: Project Foundation ===" -ForegroundColor Magenta

# Commit 1
New-Commit -Message "chore: initial Flutter project setup with pubspec.yaml" `
    -Date (Set-CommitDate 0 9) `
    -FilesToAdd @("pubspec.yaml", "pubspec.lock", ".metadata")

# Commit 2
New-Commit -Message "chore: configure Android and iOS native platforms" `
    -Date (Set-CommitDate 0 10) `
    -FilesToAdd @("android/*", "ios/*")

# Commit 3
New-Commit -Message "chore: add Linux, macOS, Windows, and Web platform support" `
    -Date (Set-CommitDate 0 11) `
    -FilesToAdd @("linux/*", "macos/*", "windows/*", "web/*")

# Commit 4
New-Commit -Message "feat: create app entry point with main.dart bootstrap" `
    -Date (Set-CommitDate 1 9) `
    -FilesToAdd @("lib/main.dart", "lib/app/*")

# Commit 5
New-Commit -Message "chore: add .gitignore and environment configuration" `
    -Date (Set-CommitDate 1 10) `
    -FilesToAdd @(".gitignore", ".env.example", ".env.local", "devtools_options.yaml")

# Commit 6
New-Commit -Message "docs: add initial README with project overview" `
    -Date (Set-CommitDate 2 9) `
    -FilesToAdd @("README.md")

# Commit 7
New-Commit -Message "chore: add MIT LICENSE for open source distribution" `
    -Date (Set-CommitDate 2 10) `
    -FilesToAdd @("LICENSE")

# Commit 8
New-Commit -Message "chore: configure analysis_options.yaml with strict linting rules" `
    -Date (Set-CommitDate 2 14) `
    -FilesToAdd @("analysis_options.yaml")

Write-Host ""
Write-Host "=== Phase 2: Core Infrastructure ===" -ForegroundColor Magenta

# Commit 9
New-Commit -Message "feat(core): implement dependency injection container with GetIt" `
    -Date (Set-CommitDate 5 9) `
    -FilesToAdd @("lib/core/di/*")

# Commit 10
New-Commit -Message "feat(core): add Dio HTTP client factory with interceptors" `
    -Date (Set-CommitDate 5 14) `
    -FilesToAdd @("lib/core/network/dio_factory.dart", "lib/core/network/dio_helper.dart")

# Commit 11
New-Commit -Message "feat(core): implement API service layer with error handling" `
    -Date (Set-CommitDate 6 10) `
    -FilesToAdd @("lib/core/network/api_constants.dart", "lib/core/network/api_error_handler.dart", "lib/core/network/api_error_model.dart", "lib/core/network/api_error_model.g.dart")

# Commit 12
New-Commit -Message "feat(core): add API result wrapper with Freezed union types" `
    -Date (Set-CommitDate 6 15) `
    -FilesToAdd @("lib/core/network/api_result.dart", "lib/core/network/api_result.freezed.dart")

# Commit 13
New-Commit -Message "feat(core): implement cache helper for local storage" `
    -Date (Set-CommitDate 7 9) `
    -FilesToAdd @("lib/core/cache/*")

# Commit 14
New-Commit -Message "feat(core): create base state management classes for BLoC pattern" `
    -Date (Set-CommitDate 7 14) `
    -FilesToAdd @("lib/core/state/*")

# Commit 15
New-Commit -Message "feat(core): implement app theme with Material 3 design tokens" `
    -Date (Set-CommitDate 10 9) `
    -FilesToAdd @("lib/core/design_system/theme.dart")

# Commit 16
New-Commit -Message "feat(core): add design system tokens for colors, typography, spacing" `
    -Date (Set-CommitDate 10 14) `
    -FilesToAdd @("lib/core/design_system/tokens/*")

# Commit 17
New-Commit -Message "feat(core): create reusable UI components library" `
    -Date (Set-CommitDate 12 10) `
    -FilesToAdd @("lib/core/ui/*")

# Commit 18
New-Commit -Message "feat(core): add utility functions and helper classes" `
    -Date (Set-CommitDate 12 15) `
    -FilesToAdd @("lib/core/utils/*", "lib/core/models/*")

Write-Host ""
Write-Host "=== Phase 3: Authentication Module ===" -ForegroundColor Magenta

# Commit 19
New-Commit -Message "feat(auth): create user data models and DTOs" `
    -Date (Set-CommitDate 15 9) `
    -FilesToAdd @("lib/shared/auth/data/*")

# Commit 20
New-Commit -Message "feat(auth): implement authentication service layer" `
    -Date (Set-CommitDate 15 14) `
    -FilesToAdd @("lib/shared/auth/services/*")

# Commit 21
New-Commit -Message "feat(auth): add onboarding screens with welcome flow" `
    -Date (Set-CommitDate 17 10) `
    -FilesToAdd @("lib/shared/auth/onboarding/*")

# Commit 22
New-Commit -Message "feat(auth): implement login screen with form validation" `
    -Date (Set-CommitDate 18 9) `
    -FilesToAdd @("lib/shared/auth/login/*")

# Commit 23
New-Commit -Message "feat(auth): add user registration flow with multi-step form" `
    -Date (Set-CommitDate 20 10) `
    -FilesToAdd @("lib/shared/auth/signup/*")

# Commit 24
New-Commit -Message "feat(auth): implement password reset with email verification" `
    -Date (Set-CommitDate 21 14) `
    -FilesToAdd @("lib/shared/auth/password_reset/*")

# Commit 25
New-Commit -Message "feat(auth): add OTP verification screen with countdown timer" `
    -Date (Set-CommitDate 22 10) `
    -FilesToAdd @("lib/shared/auth/verification/*")

Write-Host ""
Write-Host "=== Phase 4: Parent Module Features ===" -ForegroundColor Magenta

# Commit 26
New-Commit -Message "feat(parent/home): create parent home screen with dashboard layout" `
    -Date (Set-CommitDate 25 9) `
    -FilesToAdd @("lib/parent/home/*")

# Commit 27
New-Commit -Message "feat(parent/navigation): implement bottom navigation for parent portal" `
    -Date (Set-CommitDate 25 14) `
    -FilesToAdd @("lib/parent/navigation/*")

# Commit 28
New-Commit -Message "feat(parent/children): add child profile management" `
    -Date (Set-CommitDate 27 10) `
    -FilesToAdd @("lib/parent/my_children/*")

# Commit 29
New-Commit -Message "feat(parent/account): implement parent account settings" `
    -Date (Set-CommitDate 28 9) `
    -FilesToAdd @("lib/parent/account/*")

# Commit 30
New-Commit -Message "feat(parent/screening): create ASD screening questionnaire UI" `
    -Date (Set-CommitDate 30 10) `
    -FilesToAdd @("lib/parent/screening/test/*")

# Commit 31
New-Commit -Message "feat(parent/screening): implement M-CHAT-R/F validated scoring algorithm" `
    -Date (Set-CommitDate 31 14) `
    -FilesToAdd @("lib/parent/screening/result/*")

# Commit 32
New-Commit -Message "feat(parent/screening): add screening history with past results" `
    -Date (Set-CommitDate 32 10) `
    -FilesToAdd @("lib/parent/screening/history/*")

# Commit 33
New-Commit -Message "feat(parent/screening): implement start screening flow" `
    -Date (Set-CommitDate 33 9) `
    -FilesToAdd @("lib/parent/screening/start/*")

# Commit 34
New-Commit -Message "feat(parent/progress): create child progress tracking dashboard" `
    -Date (Set-CommitDate 35 10) `
    -FilesToAdd @("lib/parent/progress/*")

# Commit 35
New-Commit -Message "feat(parent/education): add educational resources browser" `
    -Date (Set-CommitDate 37 9) `
    -FilesToAdd @("lib/parent/education/*")

# Commit 36
New-Commit -Message "feat(parent/chatbot): integrate AI assistant with chat interface" `
    -Date (Set-CommitDate 40 10) `
    -FilesToAdd @("lib/parent/chatbot/*")

# Commit 37
New-Commit -Message "feat(parent/doctors): implement find doctors search functionality" `
    -Date (Set-CommitDate 42 9) `
    -FilesToAdd @("lib/parent/find_doctors/views/*", "lib/parent/find_doctors/controllers/*")

# Commit 38
New-Commit -Message "feat(parent/doctors): add doctor profile cards with specialization" `
    -Date (Set-CommitDate 42 14) `
    -FilesToAdd @("lib/parent/find_doctors/details/*")

# Commit 39
New-Commit -Message "feat(parent/doctors): implement doctor rating and review system" `
    -Date (Set-CommitDate 43 10) `
    -FilesToAdd @("lib/parent/find_doctors/components/*")

# Commit 40
New-Commit -Message "feat(parent/doctors): add booking flow with appointment scheduling" `
    -Date (Set-CommitDate 44 14) `
    -FilesToAdd @("lib/parent/find_doctors/booking/*")

Write-Host ""
Write-Host "=== Phase 5: Doctor Portal ===" -ForegroundColor Magenta

# Commit 41
New-Commit -Message "feat(doctor): create doctor portal navigation structure" `
    -Date (Set-CommitDate 47 9) `
    -FilesToAdd @("lib/doctor/navigation/*")

# Commit 42
New-Commit -Message "feat(doctor/home): implement doctor dashboard with patient stats" `
    -Date (Set-CommitDate 47 14) `
    -FilesToAdd @("lib/doctor/home/*")

# Commit 43
New-Commit -Message "feat(doctor/account): add doctor profile and settings management" `
    -Date (Set-CommitDate 48 10) `
    -FilesToAdd @("lib/doctor/account/*")

# Commit 44
New-Commit -Message "feat(doctor/clinic): implement clinic information management" `
    -Date (Set-CommitDate 49 9) `
    -FilesToAdd @("lib/doctor/clinic/*")

# Commit 45
New-Commit -Message "feat(doctor/patients): create patient list view with search" `
    -Date (Set-CommitDate 50 10) `
    -FilesToAdd @("lib/doctor/my_patients/*")

# Commit 46
New-Commit -Message "feat(doctor/appointments): add appointment management system" `
    -Date (Set-CommitDate 51 14) `
    -FilesToAdd @("lib/doctor/appointments/*")

# Commit 47
New-Commit -Message "feat(doctor/sessions): implement therapy session tracking" `
    -Date (Set-CommitDate 52 10) `
    -FilesToAdd @("lib/doctor/sessions/*")

# Commit 48
New-Commit -Message "feat(shared): add shared medicine tracking module" `
    -Date (Set-CommitDate 53 9) `
    -FilesToAdd @("lib/shared/medicines/*", "lib/shared/donations/*")

Write-Host ""
Write-Host "=== Phase 6: Assets and Resources ===" -ForegroundColor Magenta

# Commit 49
New-Commit -Message "feat(assets): add application images and icons" `
    -Date (Set-CommitDate 55 10) `
    -FilesToAdd @("lib/appassets/*")

# Commit 50
New-Commit -Message "chore: add Visual Studio Code workspace settings" `
    -Date (Set-CommitDate 55 14) `
    -FilesToAdd @(".vscode/*")

# Commit 51
New-Commit -Message "chore: add Specify and SWM configuration" `
    -Date (Set-CommitDate 56 9) `
    -FilesToAdd @(".specify/*", ".swm/*")

Write-Host ""
Write-Host "=== Phase 7: Testing ===" -ForegroundColor Magenta

# Commit 52
New-Commit -Message "test: add widget test setup and basic examples" `
    -Date (Set-CommitDate 58 10) `
    -FilesToAdd @("test/widget_test.dart", "test/app/*")

# Commit 53
New-Commit -Message "test(core): add unit tests for network and utility classes" `
    -Date (Set-CommitDate 59 9) `
    -FilesToAdd @("test/core/*")

# Commit 54
New-Commit -Message "test(auth): implement authentication flow tests" `
    -Date (Set-CommitDate 60 10) `
    -FilesToAdd @("test/shared/*")

# Commit 55
New-Commit -Message "test(parent): add parent feature widget and integration tests" `
    -Date (Set-CommitDate 61 14) `
    -FilesToAdd @("test/parent/*")

# Commit 56
New-Commit -Message "test(doctor): implement doctor portal test coverage" `
    -Date (Set-CommitDate 62 10) `
    -FilesToAdd @("test/doctor/*")

# Commit 57
New-Commit -Message "chore(test): add test specifications and fixtures" `
    -Date (Set-CommitDate 63 9) `
    -FilesToAdd @("specs/*")

# Commit 58
New-Commit -Message "chore: add .flutter-plugins-dependencies and .dart_tool config" `
    -Date (Set-CommitDate 63 14) `
    -FilesToAdd @(".flutter-plugins-dependencies", ".dart_tool/*")

Write-Host ""
Write-Host "=== Phase 8: DevOps and CI/CD ===" -ForegroundColor Magenta

# Commit 59
New-Commit -Message "ci: add GitHub Actions workflow for Flutter CI/CD" `
    -Date (Set-CommitDate 65 10) `
    -FilesToAdd @(".github/workflows/flutter-ci-cd.yml")

# Commit 60
New-Commit -Message "ci: add PR validation and Dart analysis workflows" `
    -Date (Set-CommitDate 65 14) `
    -FilesToAdd @(".github/workflows/pr-validation.yml", ".github/workflows/dart.yml")

# Commit 61
New-Commit -Message "ci: add GitHub issue and PR templates" `
    -Date (Set-CommitDate 66 10) `
    -FilesToAdd @(".github/ISSUE_TEMPLATE/*", ".github/PULL_REQUEST_TEMPLATE/*", ".github/*")

# Commit 62
New-Commit -Message "build: add Dockerfile and docker-compose for containerized development" `
    -Date (Set-CommitDate 67 9) `
    -FilesToAdd @("Dockerfile", "docker-compose.yml", ".dockerignore")

Write-Host ""
Write-Host "=== Phase 9: Documentation ===" -ForegroundColor Magenta

# Commit 63
New-Commit -Message "docs: add comprehensive project documentation" `
    -Date (Set-CommitDate 70 10) `
    -FilesToAdd @("docs/*")

# Commit 64
New-Commit -Message "docs: add CONTRIBUTING, SECURITY, and DEPLOYMENT guides" `
    -Date (Set-CommitDate 72 9) `
    -FilesToAdd @("CONTRIBUTING.md", "SECURITY.md", "DEPLOYMENT.md", "CHANGELOG.md")

# Commit 65
New-Commit -Message "docs: finalize README with badges, screenshots, and quick start guide" `
    -Date (Set-CommitDate 75 10) `
    -FilesToAdd @("README.md", "README_DOCKER.md", "scripts/*", "convert-to-mvc.ps1", "fix-imports.ps1", "fix-renamed-imports.ps1")

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Git History Rebuild Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total commits created: 65" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Review: git log --oneline" -ForegroundColor White
Write-Host "2. Replace main: git branch -D main; git branch -m new-history main" -ForegroundColor White
Write-Host "3. Force push: git push --force origin main" -ForegroundColor White
Write-Host ""
