# Release Checklist

Use this checklist before every release to ensure a smooth deployment.

---

## Pre-Release Verification

### 1. Code Quality ✅

- [ ] All CI/CD checks pass (format, analyze, test)
- [ ] No critical lint warnings
- [ ] Code review completed and approved
- [ ] All related PRs merged to main branch

### 2. Version Update 📦

- [ ] Update version in `pubspec.yaml`
  ```yaml
  version: X.Y.Z+BuildNumber
  ```
- [ ] Update `CHANGELOG.md` with release notes
  - [ ] Move "Unreleased" items to new version section
  - [ ] Add release date
  - [ ] Categorize changes (Added, Changed, Fixed, Removed)

### 3. Signing Configuration 🔐

- [ ] `android/key.properties` exists locally (for local builds)
- [ ] Keystore file exists at path specified in key.properties
- [ ] GitHub Secrets configured:
  - [ ] `KEYSTORE_BASE64`
  - [ ] `KEYSTORE_PASSWORD`
  - [ ] `KEY_ALIAS`
  - [ ] `KEY_PASSWORD`
- [ ] Firebase secrets configured (if using Firebase App Distribution):
  - [ ] `FIREBASE_APP_ID`
  - [ ] `FIREBASE_SERVICE_ACCOUNT_JSON`

### 4. Environment Configuration 🌐

- [ ] Production API URL configured (`API_BASE_URL` secret)
- [ ] Stripe keys configured (if applicable)
- [ ] All `.env` variables have production values

---

## Build Verification

### 5. Local Build Test 🔨

Run these commands to verify the build works locally:

```bash
# Clean previous builds
flutter clean
flutter pub get

# Build release APK
flutter build apk --release

# Verify APK was created
ls -la build/app/outputs/flutter-apk/app-release.apk
```

- [ ] Release APK builds successfully
- [ ] APK size is reasonable (< 50MB typically)
- [ ] No ProGuard/R8 errors

### 6. Installation Test 📱

- [ ] Install APK on physical device
  ```bash
  adb install build/app/outputs/flutter-apk/app-release.apk
  ```
- [ ] App launches without crashes
- [ ] Critical user flows work:
  - [ ] Login/Sign up
  - [ ] Main features functional
  - [ ] API calls successful
  - [ ] No debug banners or console logs visible

### 7. Signing Verification 🔏

```bash
# Verify APK is signed (requires jarsigner from JDK)
jarsigner -verify -verbose -certs build/app/outputs/flutter-apk/app-release.apk
```

- [ ] APK is signed (not just debug-signed)
- [ ] Certificate is correct (matches your upload key)

---

## Deployment Execution

### 8. Create Release Tag 🏷️

```bash
# Create annotated tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push tag to trigger deployment
git push origin v1.0.0
```

- [ ] Tag follows semantic versioning (v1.0.0)
- [ ] Tag message describes the release

### 9. Monitor CI/CD Pipeline 👀

- [ ] Go to GitHub Actions and monitor the workflow
- [ ] All jobs pass:
  - [ ] format
  - [ ] analyze
  - [ ] test
  - [ ] build-android-release
  - [ ] deploy-firebase (if configured)
  - [ ] deploy-github-release

### 10. Verify Deployment Artifacts 📦

- [ ] GitHub Release created with correct tag
- [ ] APK attached to release
- [ ] AAB attached to release
- [ ] Release notes generated

---

## Post-Deployment Verification

### 11. Download and Test 📲

- [ ] Download APK from GitHub Release
- [ ] Install and verify it matches local build
- [ ] Critical flows still work

### 12. Firebase App Distribution (if applicable) 🔥

- [ ] Build appears in Firebase Console
- [ ] Testers received notification email
- [ ] At least one tester confirms installation works

### 13. Play Store Upload (if applicable) 🏪

- [ ] Download AAB from GitHub Release
- [ ] Upload to Play Console
- [ ] Pass Play Store pre-checks
- [ ] Submit for review (or internal testing)

---

## Rollback Procedures 🔄

If issues are discovered after release:

### Option 1: Hot Fix
1. Create fix on main branch
2. Increment patch version (1.0.0 → 1.0.1)
3. Create new release tag
4. Follow deployment process again

### Option 2: Rollback
1. Identify last known good version
2. Communicate to users (if public release)
3. For Play Store: Halt rollout and revert
4. For Firebase: Upload previous APK version

---

## Release Notes Template

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- New feature description

### Changed
- Changed behavior description

### Fixed
- Bug fix description

### Security
- Security improvement description

### Known Issues
- Any known issues in this release
```

---

## Emergency Contacts

| Role | Contact | When to Contact |
|------|---------|-----------------|
| Lead Developer | @AHMED9937 | Build failures, critical bugs |
| Repository Owner | @AHMED9937 | Secret issues, access problems |

---

## Useful Commands Quick Reference

```bash
# Build commands
flutter build apk --release
flutter build appbundle --release

# Version info
grep "version:" pubspec.yaml

# Create and push tag
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0

# Delete tag (if needed)
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0

# Verify APK signing
jarsigner -verify -verbose build/app/outputs/flutter-apk/app-release.apk

# Install APK
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

---

**Last Updated:** 2025-12-24
