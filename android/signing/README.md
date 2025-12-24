# Android App Signing Setup

This directory contains scripts and templates for configuring Android app signing.

## Files

| File | Purpose |
|------|---------|
| `key.properties.example` | Template for local signing configuration |
| `encode-keystore.ps1` | PowerShell script to encode keystore to Base64 |
| `encode-keystore.sh` | Bash script to encode keystore to Base64 |

## Quick Setup

### 1. Generate a Keystore (if you don't have one)

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

### 2. Create key.properties

```bash
cp key.properties.example key.properties
# Edit key.properties with your values
```

### 3. Encode Keystore for GitHub Secrets

**Windows (PowerShell):**
```powershell
.\encode-keystore.ps1 -KeystorePath "path/to/upload-keystore.jks"
```

**Linux/macOS:**
```bash
./encode-keystore.sh path/to/upload-keystore.jks
```

### 4. Add to GitHub Secrets

1. Go to Repository → Settings → Secrets → Actions
2. Add these secrets:
   - `KEYSTORE_BASE64`: Paste the encoded output
   - `KEYSTORE_PASSWORD`: Your keystore password
   - `KEY_ALIAS`: Your key alias (e.g., "upload")
   - `KEY_PASSWORD`: Your key password

## Security Notes

> ⚠️ **NEVER commit these files to version control:**
> - `key.properties`
> - Any `.jks` or `.keystore` files
> - Base64 encoded keystore content

These files are already in `.gitignore`.
