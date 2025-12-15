# PR #1: Security & Environment Configuration

## Overview
This PR establishes secure environment variable management using `flutter_dotenv`, removing hardcoded sensitive values from source code and enabling environment-specific configurations.

## Changes

### Added
- **`flutter_dotenv` dependency** (v5.2.1) for environment variable management
- **`lib/config/env_config.dart`**: Centralized environment configuration class with:
  - API base URL getter
  - Stripe payment keys
  - Log level control (debug, info, warn, error)
  - Feature flags (voice input, payments, chatbot)
  - Async `load()` method with validation
- **`.env.example`**: Template for environment variables with documentation

### Modified
- **`lib/main.dart`**: Initialize `EnvConfig.load()` before app startup with error handling
- **`lib/networking/api_constants.dart`**: Replace hardcoded API URL with `EnvConfig.apiBaseUrl`
- **`.gitignore`**: Exclude `.env.local`, `.env.*.local`, `.env.prod`, `.env.staging`

### Removed
- Hardcoded API URL (`https://asd-final-project-soat.vercel.app/`) from `api_constants.dart`
- `dart:ffi` import from `TestResult.dart` (web compatibility fix)

## Benefits
✅ **Security**: No sensitive values in version control  
✅ **Flexibility**: Environment-specific configs (dev, staging, prod)  
✅ **Type Safety**: Centralized getters with clear defaults  
✅ **Documentation**: `.env.example` guides new developers  

## Testing Checklist
- [x] `flutter pub get` succeeds
- [x] `flutter analyze lib/config/env_config.dart` passes (no errors)
- [x] `.env.local` can be created from `.env.example`
- [ ] App builds and runs with environment config (`flutter run -d chrome`)
- [ ] API calls use configured base URL

## Migration Guide
For developers setting up this project:

1. Copy `.env.example` to `.env.local`:
   ```powershell
   Copy-Item .env.example .env.local
   ```

2. Update `.env.local` with your values:
   ```env
   API_BASE_URL=https://asd-final-project-soat.vercel.app/
   STRIPE_PUBLISHABLE_KEY=pk_test_your_key_here
   LOG_LEVEL=debug
   ENABLE_DEBUG=true
   ENABLE_VOICE_INPUT=true
   ENABLE_PAYMENTS=false
   ENABLE_CHATBOT=true
   ```

3. Run the app:
   ```bash
   flutter pub get
   flutter run -d chrome
   ```

## Commit Structure (6 commits)
1. `chore(deps): add flutter_dotenv dependency`
2. `feat(config): create env_config.dart with environment variables`
3. `docs: add .env.example template`
4. `chore(git): add .env* to .gitignore`
5. `refactor(main): initialize EnvConfig before app startup`
6. `refactor(networking): use EnvConfig for API base URL`

## Related Issues
- Part of MLH Fellowship refactor plan
- Addresses security concerns: hardcoded secrets in source code
- Enables PR #2 (Architecture Restructure) by establishing config layer

## Reviewer Notes
- All commits follow Conventional Commits format
- Each commit is atomic and independently testable
- No breaking changes to existing functionality
- `.env.local` must be created locally (not tracked in git)

---

**Total Files Changed:** 9  
**Lines Added:** ~155  
**Lines Deleted:** ~10  
**Effort:** 2 hours  
