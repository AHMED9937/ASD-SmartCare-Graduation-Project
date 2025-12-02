# Troubleshooting & FAQ

This guide helps resolve common issues encountered during setup, development, and usage of the ASD SmartCare app.

---

## 🛠 Installation & Build Issues

### 1. Flutter Version Conflicts
**Issue**: App fails to build due to incompatible `pubspec.yaml` dependencies.
**Solution**: Ensure you are using Flutter `3.5.4` or higher.
```bash
flutter --version
flutter upgrade
```

### 2. CocoaPods Errors (iOS Only)
**Issue**: `pod install` fails with architecture or version errors.
**Solution**:
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod deintegrate
pod install --repo-update
cd ..
```

### 3. Missing API Keys
**Issue**: Features like Payments or Screening fail with "Network Error" or "Unauthorized".
**Solution**: Ensure you have configured the `.env` file correctly (see [Configuration Section](#configuration-secrets)).

---

## 🔑 Configuration & Secrets

The app relies on several environment variables for security and flexible deployment.

### Required Secrets
| Secret | Purpose | Where to get |
|--------|---------|--------------|
| `API_BASE_URL` | Backend URL | Found in `.env.example` (or your private backend) |
| `STRIPE_PUBLISHABLE_KEY` | Payment UI | [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys) |
| `STRIPE_SECRET_KEY` | Backend logic | [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys) |

### Common Secret Failures
- **Symptom**: "Stripe Key not found" in console.
- **Fix**: Check if you ran the app using `--dart-define`.
```bash
flutter run --dart-define=STRIPE_PUBLISHABLE_KEY=pk_test_xxxxxxx
```

---

## 🌐 Networking Troubleshooting

### "Connection Refused" (Emulator)
**Issue**: Android emulator cannot reach a locally hosted API.
**Solution**: Use `10.0.2.2` instead of `localhost` for your API base URL if running the backend locally.

### API Response Format
**Issue**: `TypeError` when parsing JSON response.
**Solution**: Use the `pretty_dio_logger` provided in the project to see the raw JSON. Check `lib/core/network/dio_helper.dart`.

---

## ❓ Frequently Asked Questions (FAQ)

### Q: Why does the AI screening take several seconds?
A: Our AI models (Autism Detector and severity level analyzer) perform complex processing on the server. Expect 2-5 seconds for a response depending on your connectivity.

### Q: Can I run this on the Web?
A: While Flutter supports Web, this project is optimized for **Android and iOS**. Some mobile-specific plugins (like `permission_handler`) may cause issues on browsers.

### Q: Where is my data stored?
A: User profiles and appointments are stored in our Vercel-hosted database. Authentication tokens and local settings are stored using `SharedPreferences`.

---

## Still having issues?
1. Check the existing [Issues](https://github.com/AHMED9937/ASD-SmartCare-Graduation-Project/issues) on GitHub.
2. Run `flutter doctor` and ensure everything is green.
3. Open a new issue with your device logs (`flutter run -v`).
