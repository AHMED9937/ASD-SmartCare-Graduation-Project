# PR #2: Architecture Restructure - Implementation Plan

## Goal
Transform monolithic `lib/presentation` structure into clean architecture with feature-based organization.

## Current Structure Issues
❌ All features mixed in `lib/presentation/`  
❌ Models in presentation layer (should be in domain/data)  
❌ No repository pattern (Cubits call Dio directly)  
❌ No use cases (business logic in UI layer)  
❌ Naming inconsistencies (cahcheHelper, SharedComponents)  

## Target Structure
```
lib/
├── config/          ✅ (exists - env_config.dart)
├── core/            🆕 Shared utilities, constants, errors
│   ├── di/          Dependency injection
│   ├── network/     Networking (move from networking/)
│   ├── cache/       Cache helper (rename from cahcheHelper)
│   └── widgets/     Shared components (rename from SharedComponents)
├── features/        🆕 Feature-based modules
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── screens/
│   │       ├── widgets/
│   │       └── cubit/
│   ├── doctors/     (DoctorsList, DoctorBooking)
│   ├── autism_test/ (autsiumTest)
│   ├── chatbot/     (chatBotLayout)
│   ├── education/   (Education)
│   ├── medicine/    (AvailableMedicine)
│   ├── donations/   (CharityAndDonations)
│   └── profile/     (profileLayout)
└── main.dart
```

## 12 Atomic Commits

### Commit #1: Create core folder structure
**Type:** `chore(arch)`  
**Files:** Create empty folders + barrel exports  
**Changes:**
- `lib/core/di/.gitkeep`
- `lib/core/network/.gitkeep`
- `lib/core/cache/.gitkeep`
- `lib/core/widgets/.gitkeep`
- `lib/core/constants/.gitkeep`
- `lib/core/errors/.gitkeep`

### Commit #2: Move networking to core/network
**Type:** `refactor(arch)`  
**Files:** Move `lib/networking/*` → `lib/core/network/*`  
**Changes:**
- Rename folder
- Update imports in all files

### Commit #3: Move and rename cache helper
**Type:** `refactor(arch)`  
**Files:** `lib/appShared/cacheHelper/cahcheHelper.dart` → `lib/core/cache/cache_helper.dart`  
**Changes:**
- Rename file (fix typo: cahche → cache)
- Move to core
- Update imports in main.dart and all usages

### Commit #4: Move shared components to core/widgets
**Type:** `refactor(arch)`  
**Files:** `lib/appShared/Components/*` → `lib/core/widgets/*`  
**Changes:**
- Rename SharedComponents.dart → shared_components.dart
- Move myblockob.dart → bloc_observer.dart
- Update imports

### Commit #5: Create features folder structure
**Type:** `chore(arch)`  
**Files:** Create feature folders  
**Changes:**
- `lib/features/auth/data/models/.gitkeep`
- `lib/features/auth/data/repositories/.gitkeep`
- `lib/features/auth/data/datasources/.gitkeep`
- `lib/features/auth/domain/entities/.gitkeep`
- `lib/features/auth/domain/repositories/.gitkeep`
- `lib/features/auth/domain/usecases/.gitkeep`
- `lib/features/auth/presentation/screens/.gitkeep`
- `lib/features/auth/presentation/widgets/.gitkeep`
- `lib/features/auth/presentation/cubit/.gitkeep`
- Repeat for doctors, autism_test, chatbot, education, medicine, donations, profile

### Commit #6: Move auth feature (login/signup)
**Type:** `refactor(auth)`  
**Files:** Move `lib/presentation/login/*` and `lib/presentation/SignUp/*` → `lib/features/auth/presentation/`  
**Changes:**
- Move screens
- Move widgets
- Update imports

### Commit #7: Move doctors feature
**Type:** `refactor(doctors)`  
**Files:** Move `lib/presentation/ParentLayout/DoctorLayout/*` → `lib/features/doctors/presentation/`  
**Changes:**
- Move DoctorsList → doctors/presentation/doctors_list/
- Move DoctorBooking → doctors/presentation/booking/
- Update imports

### Commit #8: Move autism test feature
**Type:** `refactor(autism-test)`  
**Files:** Move `lib/presentation/ParentLayout/apphome/autsiumTest/*` → `lib/features/autism_test/presentation/`  
**Changes:**
- Move screens and models
- Update imports

### Commit #9: Move education, medicine, chatbot features
**Type:** `refactor(features)`  
**Files:** Move remaining features  
**Changes:**
- Education → features/education/
- AvailableMedicine → features/medicine/
- chatBotLayout → features/chatbot/
- Update imports

### Commit #10: Create auth data layer (models + datasource)
**Type:** `feat(auth)`  
**Files:** Extract models from presentation  
**Changes:**
- Create auth data models (from SignUp/login models)
- Create AuthRemoteDataSource interface
- Implement with Dio
- ~80 lines

### Commit #11: Create auth repository layer
**Type:** `feat(auth)`  
**Files:** Add repository pattern  
**Changes:**
- Create IAuthRepository interface in domain/repositories
- Implement AuthRepositoryImpl in data/repositories
- Connect to datasource
- ~60 lines

### Commit #12: Create auth use cases
**Type:** `feat(auth)`  
**Files:** Add business logic layer  
**Changes:**
- LoginUseCase
- SignUpParentUseCase
- SignUpDoctorUseCase
- Update Cubits to use use cases instead of Dio
- ~100 lines

---

## Verification Steps (after each commit)
1. `flutter analyze lib/` - no new errors
2. `git diff --stat` - verify only intended files changed
3. Run app: `flutter run -d chrome` - ensure no runtime errors

## Estimated Effort
- **Time:** 8 hours
- **Lines changed:** ~2,000 (mostly file moves)
- **Breaking changes:** None (internal refactor only)

## Dependencies
- Requires PR #1 merged (EnvConfig established)
- Blocks PR #3+ (all future work depends on this structure)
