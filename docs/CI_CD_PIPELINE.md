# CI/CD Pipeline Documentation

This document describes the Continuous Integration and Continuous Deployment (CI/CD) pipeline for the ASD SmartCare Flutter application.

---

## Table of Contents

- [Overview](#overview)
- [Pipeline Architecture](#pipeline-architecture)
- [Workflow Triggers](#workflow-triggers)
- [Jobs Explained](#jobs-explained)
- [Build Artifacts](#build-artifacts)
- [Deployment Targets](#deployment-targets)
- [Manual Deployments](#manual-deployments)
- [Reading Workflow Logs](#reading-workflow-logs)
- [Troubleshooting](#troubleshooting)
- [Secrets Configuration](#secrets-configuration)

---

## Overview

The CI/CD pipeline automatically validates, tests, builds, and deploys the application on every code change. It ensures code quality and enables continuous delivery of new features.

### Key Features

| Feature | Description |
|---------|-------------|
| **Automated Testing** | 69+ tests run on every push |
| **Code Quality** | Format check + static analysis |
| **Multi-Platform Builds** | Android APK, AAB, and Web |
| **Dual Deployment** | Firebase App Distribution + GitHub Releases |
| **Auto-Releases** | Automatic releases on main branch |
| **Caching** | Fast builds via Flutter SDK caching |

---

## Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           TRIGGERS                                       │
│  Push to main/develop • Pull Requests • Version Tags • Manual Dispatch  │
└─────────────────────┬───────────────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        CODE QUALITY (Parallel)                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────────────┐  │
│  │   Format    │  │   Analyze   │  │   Test + Coverage                │  │
│  │   Check     │  │   (Linting) │  │   (69+ tests + Codecov)         │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────────────┘  │
└─────────────────────┬───────────────────────────────────────────────────┘
                      │ All must pass
                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                           BUILD (Conditional)                            │
│  ┌─────────────────┐  ┌───────────────────┐  ┌────────────────────────┐ │
│  │  Debug APK      │  │  Release APK+AAB  │  │  Web Build             │ │
│  │  (PRs only)     │  │  (main + tags)    │  │  (Always)              │ │
│  └─────────────────┘  └───────────────────┘  └────────────────────────┘ │
└─────────────────────┬───────────────────────────────────────────────────┘
                      │ If release build
                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                          DEPLOY (Conditional)                            │
│  ┌─────────────────────────┐  ┌──────────────────────────────────────┐  │
│  │  Firebase App           │  │  GitHub Releases                      │  │
│  │  Distribution           │  │  (Auto on main / Tagged versions)    │  │
│  └─────────────────────────┘  └──────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Workflow Triggers

### Main CI/CD Workflow (`flutter-ci-cd.yml`)

| Trigger | Condition | Jobs Run |
|---------|-----------|----------|
| **Push to main** | Merge to main branch | All jobs including release builds & deployment |
| **Push to develop** | Development branch | Quality + Testing + Web build |
| **Push to feature/** | Feature branches | Quality + Testing + Web build |
| **Pull Request** | PR to main/develop | Quality + Testing + Debug build |
| **Version Tag** | Push tag `v*.*.*` | Full pipeline + GitHub Release |
| **Manual** | workflow_dispatch | Optional Firebase deployment |

### PR Validation Workflow (`pr-validation.yml`)

| Trigger | Purpose |
|---------|---------|
| PR opened/updated | Fast feedback (~2 min) on format, lint, tests |

---

## Jobs Explained

### 1. Format Check (`format`)
```bash
dart format --set-exit-if-changed .
```
- **Purpose**: Ensure consistent code formatting
- **Timeout**: 10 minutes
- **Fix locally**: `dart format .`

### 2. Static Analysis (`analyze`)
```bash
flutter analyze --no-fatal-infos
```
- **Purpose**: Catch bugs, enforce lint rules
- **Timeout**: 15 minutes
- **Config**: `analysis_options.yaml`

### 3. Tests (`test`)
```bash
flutter test --coverage --reporter=expanded
```
- **Purpose**: Run 69+ unit/widget tests
- **Timeout**: 20 minutes
- **Coverage**: Uploaded to Codecov
- **Artifacts**: `coverage-report` (30 days)

### 4. Build Android Debug (`build-android-debug`)
- **Trigger**: Pull requests only
- **Purpose**: Verify app builds correctly
- **Timeout**: 30 minutes

### 5. Build Android Release (`build-android-release`)
- **Trigger**: main branch + version tags
- **Purpose**: Create signed release builds
- **Outputs**: 
  - `app-release.apk` (direct install)
  - `app-release.aab` (Play Store)
- **Artifacts**: 30 days retention

### 6. Build Web (`build-web`)
- **Trigger**: All pushes after quality gates
- **Purpose**: Verify web build works

### 7. Deploy Firebase (`deploy-firebase`)
- **Trigger**: main push, tags, or manual
- **Purpose**: Distribute to testers
- **Requires**: `FIREBASE_APP_ID`, `FIREBASE_SERVICE_ACCOUNT_JSON`

### 8. GitHub Release Tagged (`deploy-github-release`)
- **Trigger**: Version tags (`v1.0.0`)
- **Purpose**: Create formal release
- **Outputs**: APK + AAB attached to release

### 9. Auto Release (`deploy-auto-release`)
- **Trigger**: Push to main (not PRs)
- **Purpose**: Continuous delivery
- **Naming**: `build-YYYYMMDD-HHMMSS-<sha>`
- **Type**: Pre-release (for testing)

### 10. CI Success (`ci-success`)
- **Purpose**: Summary job for status checks
- **Deps**: format, analyze, test, build-web

---

## Build Artifacts

| Artifact | Contents | Retention | Download From |
|----------|----------|-----------|---------------|
| `coverage-report` | `lcov.info`, HTML report | 30 days | Actions → Run → Artifacts |
| `release-apk` | `app-release.apk` | 30 days | Actions → Run → Artifacts |
| `release-aab` | `app-release.aab` | 30 days | Actions → Run → Artifacts |

### How to Download Artifacts

1. Go to **Actions** tab in GitHub
2. Click on the workflow run
3. Scroll down to **Artifacts** section
4. Click the artifact name to download

---

## Deployment Targets

### Firebase App Distribution

**Who receives builds:**
- Tester group: `testers`

**Release notes include:**
- Build number
- Branch name
- Commit SHA

### GitHub Releases

| Release Type | Trigger | Tag Format | Pre-release |
|--------------|---------|------------|-------------|
| Tagged Release | `v*.*.*` tag | User-defined | No |
| Auto Release | main push | `build-YYYYMMDD-HHMMSS-<sha>` | Yes |

---

## Manual Deployments

### Deploy to Firebase Manually

1. Go to **Actions** → **Flutter CI/CD**
2. Click **Run workflow** dropdown
3. Check **Deploy to Firebase App Distribution**
4. Click **Run workflow**

### Create a Tagged Release

```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0

# This triggers:
# 1. Full CI pipeline
# 2. Release APK + AAB build
# 3. GitHub Release creation
# 4. Firebase deployment
```

---

## Reading Workflow Logs

### Finding Logs

1. Navigate to **Actions** tab
2. Click on the workflow run
3. Click on a job (e.g., "Tests")
4. Expand steps to see detailed logs

### Understanding Status Icons

| Icon | Meaning |
|------|---------|
| ✅ | Job passed |
| ❌ | Job failed |
| ⏳ | Job running |
| ⏸️ | Job skipped (condition not met) |
| ⚪ | Job waiting for dependencies |

### Common Log Sections

```
▶ Checkout code           # Cloning repository
▶ Setup Flutter           # Installing Flutter SDK
▶ Get dependencies        # Running flutter pub get
▶ Run tests with coverage # Test execution output
▶ Upload coverage         # Codecov upload status
```

---

## Troubleshooting

### Format Check Fails

```bash
# Fix locally
dart format .

# Check specific files
dart format --set-exit-if-changed lib/
```

### Analysis Fails

```bash
# Run locally
flutter analyze

# Auto-fix issues
dart fix --apply
```

### Tests Fail

```bash
# Run all tests
flutter test

# Run specific test with verbose output
flutter test test/path/to/test.dart --reporter=expanded

# Run with coverage
flutter test --coverage
```

### Build Fails

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build apk --debug
```

### Firebase Deployment Fails

1. Check `FIREBASE_APP_ID` secret is correct
2. Verify `FIREBASE_SERVICE_ACCOUNT_JSON` contains valid JSON
3. Ensure App Distribution is enabled in Firebase Console

---

## Secrets Configuration

See [GITHUB_SECRETS.md](GITHUB_SECRETS.md) for detailed setup instructions.

### Quick Reference

| Secret | Purpose |
|--------|---------|
| `KEYSTORE_BASE64` | Signed release builds |
| `KEYSTORE_PASSWORD` | Signed release builds |
| `KEY_ALIAS` | Signed release builds |
| `KEY_PASSWORD` | Signed release builds |
| `FIREBASE_APP_ID` | Firebase deployment |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Firebase deployment |
| `API_BASE_URL` | Runtime configuration |
| `STRIPE_PUBLISHABLE_KEY` | Payment integration |
| `CODECOV_TOKEN` | Coverage reporting |

---

## Build Badges

Add these to your README:

```markdown
[![CI/CD](https://github.com/AHMED9937/ASD-SmartCare-Graduation-Project/actions/workflows/flutter-ci-cd.yml/badge.svg)](https://github.com/AHMED9937/ASD-SmartCare-Graduation-Project/actions/workflows/flutter-ci-cd.yml)

[![codecov](https://codecov.io/gh/AHMED9937/ASD-SmartCare-Graduation-Project/branch/main/graph/badge.svg)](https://codecov.io/gh/AHMED9937/ASD-SmartCare-Graduation-Project)

[![GitHub release](https://img.shields.io/github/v/release/AHMED9937/ASD-SmartCare-Graduation-Project?include_prereleases&label=latest%20build)](https://github.com/AHMED9937/ASD-SmartCare-Graduation-Project/releases)
```

---

## Estimated Times

| Operation | Typical Duration |
|-----------|------------------|
| PR Validation | ~2 minutes |
| Full CI (no build) | ~5 minutes |
| Debug Build | ~10 minutes |
| Release Build | ~15 minutes |
| Full Pipeline | ~20 minutes |

---

## Related Documentation

- [GITHUB_SECRETS.md](GITHUB_SECRETS.md) - Secrets setup guide
- [DEPLOYMENT.md](../DEPLOYMENT.md) - Manual deployment instructions
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Development workflow
