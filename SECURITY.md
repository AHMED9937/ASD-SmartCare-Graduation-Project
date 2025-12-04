# Security Guidelines

## Overview

This document outlines security practices for the ASD-SmartCare Flutter application. All contributors must follow these guidelines to protect user data and maintain application integrity.

---

## Secret Management

### ✅ DO: Use Environment Variables

All sensitive configuration must use `String.fromEnvironment()` or `.env` files:

```dart
// ✅ CORRECT - Loaded at compile time
static const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://default-api.com/',
);

// ✅ CORRECT - Loaded from .env file
final apiKey = dotenv.env['API_KEY'] ?? '';
```

### ❌ DON'T: Hardcode Secrets

Never commit secrets to version control:

```dart
// ❌ NEVER DO THIS
static const String apiKey = 'sk_live_abc123...';
static const String password = 'admin123';
```

### Environment Files

| File | Purpose | Git Status |
|------|---------|------------|
| `.env.example` | Template with placeholders | ✅ Tracked |
| `.env` | Local secrets | ❌ **Never commit** |
| `.env.local` | Local overrides | ❌ **Never commit** |
| `.env.production` | Production secrets | ❌ **Never commit** |

---

## What Should NEVER Be Committed

- API keys (Stripe, Firebase, etc.)
- OAuth client secrets
- Database passwords or connection strings
- JWT secret keys
- Private keys or certificates
- User data exports
- `.env` files (except `.env.example`)

---

## Build-Time Configuration

Use `--dart-define` for CI/CD:

```bash
flutter build apk \
  --dart-define=API_BASE_URL=https://api.production.com/ \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx
```

---

## Logging Security

### Safe Logging

```dart
// ✅ OK - No sensitive data
debugPrint('Login successful for user');
debugPrint('API request failed: ${error.message}');

// ❌ NEVER LOG THESE
debugPrint('Token: $token');
debugPrint('Password: ${controller.text}');
debugPrint('User email: ${user.email}');
```

---

## Data Storage

### SharedPreferences

Only store non-sensitive data:

```dart
// ✅ OK
CacheHelper.saveData(key: 'theme', value: 'dark');
CacheHelper.saveData(key: 'onboardingComplete', value: true);

// ⚠️ CAUTION - Token storage
// Tokens expire and should be refreshed
CacheHelper.saveData(key: 'token', value: token);

// ❌ NEVER STORE
// Passwords, credit card numbers, SSN
```

---

## Reporting Security Issues

If you discover a security vulnerability:

1. **DO NOT** open a public issue
2. Email the maintainers directly
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

---

## Security Checklist for PRs

Before submitting code:

- [ ] No hardcoded secrets
- [ ] No `print()` statements (use `debugPrint()`)
- [ ] No sensitive data in logs
- [ ] Environment variables used for config
- [ ] API keys use `String.fromEnvironment()`
- [ ] `.gitignore` excludes sensitive files

---

## API Security

- All API calls use HTTPS (enforced by base URL)
- Authentication tokens sent via headers
- Token refresh handled automatically
- Expired tokens cleared on logout

---

## Dependencies

Regularly audit dependencies:

```bash
flutter pub outdated
flutter pub upgrade --major-versions
```

Check for known vulnerabilities in packages before adding them.
