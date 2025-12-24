# Deployment Guide

This guide covers deploying ASD SmartCare to production, including Firebase App Distribution for Android and the CI/CD pipeline configuration.

---

## Table of Contents

- [Overview](#overview)
- [Firebase App Distribution Setup](#firebase-app-distribution-setup)
- [Android Signing Configuration](#android-signing-configuration)
- [GitHub Secrets Configuration](#github-secrets-configuration)
- [Deployment Triggers](#deployment-triggers)
- [Manual Deployment](#manual-deployment)
- [iOS Deployment (Requirements)](#ios-deployment-requirements)
- [Troubleshooting](#troubleshooting)

---

## Overview

The deployment pipeline supports:

| Target | Method | Trigger |
|--------|--------|---------|
| Android APK | Firebase App Distribution | Push to `main`, manual, or tags |
| Android APK/AAB | GitHub Releases | Git tags (`v*.*.*`) |
| Play Store | Manual upload | Download AAB from artifacts |

---

## Firebase App Distribution Setup

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: `ASD SmartCare`
4. Disable Google Analytics (optional for app distribution)
5. Click **"Create project"**

### Step 2: Add Android App

1. In Firebase Console, click the Android icon to add an app
2. Enter package name: `com.example.asdsmartcare` (check `android/app/build.gradle`)
3. Enter app nickname: `ASD SmartCare Android`
4. Download `google-services.json` (optional for distribution-only)
5. Click **"Register app"**

### Step 3: Enable App Distribution

1. In Firebase Console sidebar, go to **Release & Monitor > App Distribution**
2. Click **"Get started"**
3. Accept terms of service

### Step 4: Create Tester Group

1. In App Distribution, click **"Testers & Groups"**
2. Click **"Add group"**
3. Name the group: `testers`
4. Add tester email addresses
5. Testers will receive invitation emails

### Step 5: Create Service Account

For CI/CD to upload builds automatically:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project
3. Navigate to **IAM & Admin > Service Accounts**
4. Click **"Create Service Account"**
5. Name: `firebase-app-distribution`
6. Role: **Firebase App Distribution Admin**
7. Click **"Create"**
8. Click on the service account, go to **Keys** tab
9. Click **"Add Key" > "Create new key"**
10. Choose **JSON** format
11. Save the downloaded file securely

### Step 6: Get Firebase App ID

1. In Firebase Console, go to **Project Settings** (gear icon)
2. Under **Your apps**, find your Android app
3. Copy the **App ID** (format: `1:123456789:android:abcdef123456`)

---

## Android Signing Configuration

Release builds require signing with a keystore. The project's `android/app/build.gradle` is already configured to support release signing.

### Step 1: Generate Keystore (First Time)

Navigate to the `android/` directory and run:

```bash
# Windows (PowerShell)
cd android
keytool -genkey -v -keystore upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Linux/macOS
cd android
keytool -genkey -v \
  -keystore upload-keystore.jks \
  -storetype JKS \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload
```

You will be prompted for:
- **Keystore password**: Use a strong password (save it securely!)
- **Key password**: Can be the same as keystore password
- **Certificate info**: Your name, organization, location

> ⚠️ **IMPORTANT**: Save your passwords securely - you cannot recover them! If lost, you cannot update your app on the Play Store.

### Step 2: Configure Local Signing

Copy the example file and fill in your credentials:

```bash
# Copy template
cp android/key.properties.example android/key.properties

# Edit with your values
```

Your `android/key.properties` should look like:

```properties
storePassword=your_keystore_password
keyPassword=your_key_password
keyAlias=upload
storeFile=../upload-keystore.jks
```

> **Note**: The `storeFile` path is relative to `android/app/`. Use `../upload-keystore.jks` if your keystore is in the `android/` directory.

### Step 3: Verify Local Build

```bash
# Build release APK
flutter build apk --release

# The APK should be signed with your release key
```

### Step 4: Encode Keystore for CI/CD

Use the provided helper script to encode your keystore for GitHub Secrets:

**Windows (PowerShell):**
```powershell
.\scripts\encode-keystore.ps1 -KeystorePath "android\upload-keystore.jks"
```

**Linux/macOS:**
```bash
./scripts/encode-keystore.sh android/upload-keystore.jks
```

The script will:
1. Encode your keystore to Base64
2. Copy it to your clipboard (if available)
3. Save it to `keystore-base64.txt` as backup
4. Display instructions for adding to GitHub Secrets

> ⚠️ **Delete `keystore-base64.txt` after copying to GitHub!** Do NOT commit this file.

---

## GitHub Secrets Configuration

Add these secrets to your repository:

### Required Secrets

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `FIREBASE_APP_ID` | Firebase Android App ID | Firebase Console > Project Settings |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Service account JSON content | Download from GCP Console |
| `KEYSTORE_BASE64` | Base64-encoded keystore | See [Encode Keystore](#encode-keystore-for-ci) |
| `KEYSTORE_PASSWORD` | Keystore password | Set during keystore creation |
| `KEY_ALIAS` | Key alias | Usually `upload` |
| `KEY_PASSWORD` | Key password | Set during keystore creation |

### Optional Secrets

| Secret Name | Description |
|-------------|-------------|
| `API_BASE_URL` | Production API URL |
| `STRIPE_PUBLISHABLE_KEY` | Stripe public key |
| `STRIPE_SECRET_KEY` | Stripe secret key |

### Adding Secrets in GitHub

1. Go to your repository on GitHub
2. Click **Settings** > **Secrets and variables** > **Actions**
3. Click **"New repository secret"**
4. Enter the secret name and value
5. Click **"Add secret"**

For multiline secrets (like JSON):
- Paste the entire JSON content as the value
- GitHub handles multiline values correctly

---

## Deployment Triggers

### Automatic Deployments

| Trigger | Action |
|---------|--------|
| Push to `main` | Deploy to Firebase App Distribution |
| Push tag `v*.*.*` | Deploy to Firebase + Create GitHub Release |

### Manual Deployment

1. Go to **Actions** tab in GitHub
2. Select **"Flutter CI/CD"** workflow
3. Click **"Run workflow"**
4. Enable **"Deploy to Firebase App Distribution"**
5. Click **"Run workflow"**

### Creating a Release

```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0

# This triggers:
# 1. Full CI pipeline
# 2. Release build
# 3. Firebase App Distribution upload
# 4. GitHub Release with APK/AAB attachments
```

---

## Manual Deployment

### Build Release APK Locally

```bash
# Ensure you have android/key.properties configured
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Build Release App Bundle

```bash
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### Upload to Firebase Manually

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Upload APK
firebase appdistribution:distribute build/app/outputs/flutter-apk/app-release.apk \
  --app YOUR_FIREBASE_APP_ID \
  --groups testers \
  --release-notes "Manual upload - v1.0.0"
```

### Upload to Play Store

1. Go to [Google Play Console](https://play.google.com/console/)
2. Select your app (or create new)
3. Go to **Release > Production** (or testing track)
4. Click **"Create new release"**
5. Upload the `.aab` file
6. Write release notes
7. Review and roll out

---

## iOS Deployment (Requirements)

> ⚠️ iOS deployment is not yet implemented in CI/CD.

### Prerequisites

| Requirement | Details |
|-------------|---------|
| macOS Runner | GitHub Actions macOS runners (`macos-latest`) |
| Apple Developer Account | $99/year - [developer.apple.com](https://developer.apple.com) |
| App Store Connect API Key | For automated uploads |
| Signing Certificate | Distribution certificate (`.p12`) |
| Provisioning Profile | App Store or Ad Hoc profile |

### Workflow Design (Future)

```yaml
build-ios:
  runs-on: macos-latest
  steps:
    - uses: actions/checkout@v4
    - uses: subosito/flutter-action@v2
    - name: Install certificates
      uses: apple-actions/import-codesign-certs@v2
    - name: Install provisioning profile
      uses: apple-actions/download-provisioning-profiles@v1
    - run: flutter build ipa --release
    - name: Upload to App Store Connect
      uses: apple-actions/upload-testflight-build@v1
```

### Cost Consideration

- macOS runners are ~10x more expensive than Linux runners
- Consider using self-hosted macOS runner for frequent builds

---

## Troubleshooting

### Firebase Upload Fails

**Error**: `Permission denied`

**Solution**: Ensure service account has "Firebase App Distribution Admin" role

```bash
# Verify service account permissions in GCP Console
# IAM & Admin > IAM > Find firebase-app-distribution account
```

### Keystore Decode Fails

**Error**: `Malformed base64`

**Solution**: Re-encode without line breaks

```bash
base64 -i upload-keystore.jks | tr -d '\n\r'
```

### Build Fails with Signing Error

**Error**: `Keystore was tampered with`

**Solution**: Passwords may contain special characters; use quotes

```properties
storePassword="p@ssw0rd!special"
```

### Testers Not Receiving Builds

**Check**:
1. Testers accepted invitation email
2. Correct tester group name in workflow (`testers`)
3. App Distribution is enabled in Firebase Console

### GitHub Actions Timeout

**Solution**: Increase timeout in workflow

```yaml
timeout-minutes: 60  # Increase from default 30
```

---

## Summary Checklist

- [ ] Firebase project created
- [ ] Android app added to Firebase
- [ ] App Distribution enabled
- [ ] Tester group created with emails
- [ ] Service account created with correct permissions
- [ ] Android keystore generated
- [ ] `key.properties` configured locally
- [ ] `build.gradle` updated for signing
- [ ] All GitHub secrets added
- [ ] Test manual deployment
- [ ] Test automatic deployment via push to main
