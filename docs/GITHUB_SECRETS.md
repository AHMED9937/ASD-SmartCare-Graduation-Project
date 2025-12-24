# GitHub Secrets Configuration

This document explains all the GitHub Secrets required for the CI/CD pipeline to function correctly.

---

## Table of Contents

- [Required Secrets](#required-secrets)
- [Optional Secrets](#optional-secrets)
- [How to Add Secrets](#how-to-add-secrets)
- [Android App Signing](#android-app-signing)
- [Firebase Setup](#firebase-setup)
- [Codecov Setup](#codecov-setup)

---

## Required Secrets

> [!IMPORTANT]
> These secrets are required for full CI/CD functionality. Without them, some jobs will be skipped.

### Android Signing Secrets

| Secret Name | Description | Required For |
|-------------|-------------|--------------|
| `KEYSTORE_BASE64` | Base64-encoded Android keystore file (`.jks` or `.keystore`) | Release builds |
| `KEYSTORE_PASSWORD` | Password to unlock the keystore | Release builds |
| `KEY_ALIAS` | Alias of the key within the keystore | Release builds |
| `KEY_PASSWORD` | Password for the specific key | Release builds |

### Firebase Secrets

| Secret Name | Description | Required For |
|-------------|-------------|--------------|
| `FIREBASE_APP_ID` | Firebase App ID (found in Firebase Console → Project Settings → Your apps) | Firebase App Distribution |
| `FIREBASE_SERVICE_ACCOUNT_JSON` | Full JSON content of a Firebase service account key | Firebase App Distribution |

---

## Optional Secrets

> [!TIP]
> These secrets are optional and enhance the build but aren't required.

| Secret Name | Description | Default Behavior |
|-------------|-------------|------------------|
| `API_BASE_URL` | Backend API base URL | Uses default from code |
| `STRIPE_PUBLISHABLE_KEY` | Stripe public key for payments | Uses default from code |
| `STRIPE_SECRET_KEY` | Stripe secret key | Uses default from code |
| `CODECOV_TOKEN` | Token for Codecov coverage uploads | Coverage uploads may work without token for public repos |

---

## How to Add Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Enter the **Name** and **Value**
5. Click **Add secret**

![GitHub Secrets Location](https://docs.github.com/assets/images/help/repository/repo-actions-settings.png)

---

## Android App Signing

### Step 1: Generate a Keystore (if you don't have one)

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

You'll be prompted for:
- Keystore password (save this as `KEYSTORE_PASSWORD`)
- Key password (save this as `KEY_PASSWORD`)
- Alias name (save this as `KEY_ALIAS`)

### Step 2: Encode the Keystore to Base64

**Linux/macOS:**
```bash
base64 -i upload-keystore.jks | tr -d '\n' > keystore_base64.txt
```

**Windows (PowerShell):**
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks")) | Out-File keystore_base64.txt -Encoding ASCII
```

### Step 3: Copy the Content

Copy the entire content of `keystore_base64.txt` and paste it as the `KEYSTORE_BASE64` secret.

### Step 4: Create key.properties (Local Development)

For local release builds, create `android/key.properties`:

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=upload
storeFile=../upload-keystore.jks
```

> [!WARNING]
> Never commit `key.properties` or your keystore file to version control! They are already in `.gitignore`.

---

## Firebase Setup

### Step 1: Create a Service Account

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to **Project Settings** → **Service accounts**
4. Click **Generate new private key**
5. Download the JSON file

### Step 2: Get Firebase App ID

1. Go to **Project Settings** → **Your apps**
2. Select your Android app
3. Copy the **App ID** (format: `1:123456789:android:abc123def456`)

### Step 3: Add to GitHub Secrets

- **FIREBASE_APP_ID**: Paste the App ID
- **FIREBASE_SERVICE_ACCOUNT_JSON**: Paste the **entire content** of the downloaded JSON file

### Step 4: Enable Firebase App Distribution

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Navigate to **Release & Monitor** → **App Distribution**
3. Follow the setup wizard if this is your first time

---

## Codecov Setup

### Step 1: Sign Up

1. Go to [Codecov.io](https://codecov.io/)
2. Sign in with GitHub
3. Add your repository

### Step 2: Get Upload Token

1. Go to your repository settings on Codecov
2. Copy the **Repository Upload Token**

### Step 3: Add to GitHub Secrets

Add `CODECOV_TOKEN` with the token value.

> [!NOTE]
> For public repositories, Codecov may work without a token, but using one is recommended for reliability.

---

## Secrets Summary Checklist

```
✅ GitHub Secrets I need to configure:

For Release Builds:
[ ] KEYSTORE_BASE64
[ ] KEYSTORE_PASSWORD  
[ ] KEY_ALIAS
[ ] KEY_PASSWORD

For Firebase Deployment:
[ ] FIREBASE_APP_ID
[ ] FIREBASE_SERVICE_ACCOUNT_JSON

Optional (for enhanced features):
[ ] API_BASE_URL
[ ] STRIPE_PUBLISHABLE_KEY
[ ] CODECOV_TOKEN
```

---

## Troubleshooting

### "Keystore file not found"

Ensure `KEYSTORE_BASE64` is properly encoded. The base64 string should have no line breaks.

### "Invalid keystore format"

The keystore might be corrupted. Re-encode it using:
```bash
base64 -i upload-keystore.jks | tr -d '\n'
```

### "Firebase authentication failed"

Ensure the service account JSON is complete (including all fields like `private_key`, `client_email`, etc.)

### "Coverage upload failed"

This is non-blocking. Check:
1. Repository is public or `CODECOV_TOKEN` is set
2. `lcov.info` file is generated correctly
