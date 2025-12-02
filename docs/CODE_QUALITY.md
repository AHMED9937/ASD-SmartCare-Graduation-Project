# Code Quality Standards

## Overview

This document defines the coding standards and quality guidelines for the ASD-SmartCare Flutter project. Following these conventions ensures consistency, maintainability, and readability across the codebase.

---

## Naming Conventions

### Files

| Type | Convention | Example |
|------|------------|---------|
| Dart files | `snake_case.dart` | `login_screen.dart` |
| Test files | `*_test.dart` | `login_cubit_test.dart` |
| Generated files | `*.g.dart`, `*.freezed.dart` | `user_model.g.dart` |

### Classes and Types

| Type | Convention | Example |
|------|------------|---------|
| Classes | `UpperCamelCase` | `LoginScreen`, `UserModel` |
| Enums | `UpperCamelCase` | `AuthStatus`, `UserRole` |
| Enum values | `lowerCamelCase` | `AuthStatus.authenticated` |
| Type parameters | Single uppercase letter | `List<T>`, `Map<K, V>` |
| Extensions | `UpperCamelCase` + `Extension` | `StringExtension` |
| Mixins | `UpperCamelCase` + `Mixin` | `ValidationMixin` |

### Variables and Functions

| Type | Convention | Example |
|------|------------|---------|
| Variables | `lowerCamelCase` | `userName`, `isLoading` |
| Functions/Methods | `lowerCamelCase` | `fetchUsers()`, `validateEmail()` |
| Constants | `lowerCamelCase` | `maxRetries`, `defaultTimeout` |
| Private members | `_lowerCamelCase` | `_internalState`, `_controller` |
| Parameters | `lowerCamelCase` | `void login({required String email})` |

### ❌ Avoid These Patterns

```dart
// ❌ WRONG: SCREAMING_SNAKE_CASE for constants
static const String API_BASE_URL = '...';

// ✅ CORRECT: lowerCamelCase for constants
static const String apiBaseUrl = '...';

// ❌ WRONG: PascalCase for variables
String VerficationCode = '';
TextEditingController NewPasswordController = TextEditingController();

// ✅ CORRECT: lowerCamelCase for variables
String verificationCode = '';
TextEditingController newPasswordController = TextEditingController();

// ❌ WRONG: snake_case for variables
String user_name = '';

// ✅ CORRECT: lowerCamelCase
String userName = '';
```

---

## Project Structure

```
lib/
├── app/                    # App-level configuration
│   └── router/             # Navigation/routing
├── core/                   # Shared infrastructure
│   ├── cache/              # Local storage helpers
│   ├── design_system/      # Theme, colors, typography
│   ├── di/                 # Dependency injection
│   ├── network/            # API configuration, Dio setup
│   ├── state/              # App-wide state management
│   ├── ui/                 # Reusable UI components
│   └── utils/              # Helper utilities
├── doctor/                 # Doctor user feature module
│   ├── [feature]/
│   │   ├── controllers/    # Cubits/BLoCs
│   │   ├── models/         # Data models
│   │   └── views/          # Screens and widgets
├── parent/                 # Parent user feature module
│   └── [feature]/          # Same structure as doctor
├── shared/                 # Shared feature modules
│   └── auth/               # Authentication (used by both roles)
└── main.dart               # App entry point
```

### Feature Module Structure

Each feature should follow this pattern:

```
feature_name/
├── controllers/            # State management (Cubits)
│   ├── feature_cubit.dart
│   └── feature_state.dart
├── models/                 # Data models
│   └── feature_model.dart
├── views/                  # UI
│   ├── feature_screen.dart
│   └── widgets/            # Feature-specific widgets
│       └── feature_widget.dart
└── data/                   # Optional: repositories, data sources
    └── feature_repository.dart
```

---

## Code Style

### Imports

Order imports in this sequence:
1. Dart SDK imports
2. Flutter imports
3. Package imports
4. Project imports

```dart
// 1. Dart SDK
import 'dart:async';
import 'dart:io';

// 2. Flutter
import 'package:flutter/material.dart';

// 3. Packages (alphabetical)
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

// 4. Project imports (alphabetical)
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/shared/auth/login/controllers/login_cubit.dart';
```

### Const Constructors

Always use `const` when possible:

```dart
// ✅ CORRECT
const SizedBox(height: 16);
const Text('Hello');
const EdgeInsets.all(16);

// ❌ WRONG (when const is possible)
SizedBox(height: 16);
Text('Hello');
EdgeInsets.all(16);
```

### Prefer Final

Use `final` for variables that won't be reassigned:

```dart
// ✅ CORRECT
final userName = response.data['name'];
final controller = TextEditingController();

// ❌ WRONG (if never reassigned)
var userName = response.data['name'];
String userName = response.data['name'];
```

### Widget Key Usage

Always use keys for widgets in lists and for stateful widgets that may be reordered:

```dart
// ✅ CORRECT
ListView.builder(
  itemBuilder: (context, index) => ListTile(
    key: ValueKey(items[index].id),
    title: Text(items[index].name),
  ),
);
```

---

## Documentation

### Public API Documentation

Document all public classes and methods:

```dart
/// A cubit that manages the login flow.
/// 
/// Handles email/password authentication and token storage.
/// 
/// Example:
/// ```dart
/// BlocProvider(
///   create: (_) => LoginCubit(),
///   child: LoginScreen(),
/// )
/// ```
class LoginCubit extends Cubit<LoginState> {
  /// Creates a new [LoginCubit] with initial [LoginInitial] state.
  LoginCubit() : super(LoginInitial());
  
  /// Attempts to log in with the given [email] and [password].
  /// 
  /// Emits [LoginLoading] while processing, then either
  /// [LoginSuccess] or [LoginError] based on the result.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // ...
  }
}
```

### TODO Comments

Use TODO comments for planned work:

```dart
// TODO: Implement pagination for large lists
// TODO(username): Add error handling for edge case
// FIXME: This calculation is incorrect for negative values
```

---

## Logging

### Development Logging

Use `debugPrint` for development logging (automatically stripped in release):

```dart
// ✅ OK for development
debugPrint('Loaded ${users.length} users');

// ❌ AVOID: print() appears in release logs
print('Loaded ${users.length} users');
```

### Production Logging

For production, consider using a proper logging package:

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message', error, stackTrace);
```

### Never Log Sensitive Data

```dart
// ❌ NEVER DO THIS
debugPrint('Token: $token');
debugPrint('Password: ${controller.text}');

// ✅ DO THIS
debugPrint('Login successful for user');
debugPrint('API request failed: ${error.message}');
```

---

## Error Handling

### Try-Catch Pattern

```dart
Future<void> fetchData() async {
  emit(LoadingState());
  try {
    final response = await api.getData();
    emit(SuccessState(data: response));
  } on DioException catch (e) {
    emit(ErrorState(message: _handleDioError(e)));
  } catch (e, stackTrace) {
    // Log for debugging, show user-friendly message
    debugPrint('Unexpected error: $e\n$stackTrace');
    emit(ErrorState(message: 'Something went wrong. Please try again.'));
  }
}
```

### User-Friendly Error Messages

Never expose technical errors to users:

```dart
// ❌ WRONG
emit(ErrorState(message: e.toString()));
emit(ErrorState(message: 'DioException [bad response]: 401'));

// ✅ CORRECT
emit(ErrorState(message: 'Invalid email or password'));
emit(ErrorState(message: 'Unable to connect. Please check your internet.'));
```

---

## Testing

### Test File Naming

```
test/
├── unit/
│   └── login_cubit_test.dart
├── widget/
│   └── login_screen_test.dart
└── integration/
    └── login_flow_test.dart
```

### Test Structure

```dart
void main() {
  group('LoginCubit', () {
    late LoginCubit cubit;
    
    setUp(() {
      cubit = LoginCubit();
    });
    
    tearDown(() {
      cubit.close();
    });
    
    test('initial state is LoginInitial', () {
      expect(cubit.state, isA<LoginInitial>());
    });
    
    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Success] when login succeeds',
      build: () => cubit,
      act: (cubit) => cubit.login(email: 'test@test.com', password: '123456'),
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );
  });
}
```

---

## Linting

### Running Analysis

```bash
# Check for issues
flutter analyze

# Auto-fix issues
dart fix --apply

# Format code
dart format .

# Check formatting without changing
dart format --set-exit-if-changed .
```

### Pre-commit Checklist

Before committing:

- [ ] `flutter analyze` passes with no errors
- [ ] `dart format .` applied
- [ ] Tests pass: `flutter test`
- [ ] No `print()` statements (use `debugPrint` if needed)
- [ ] No hardcoded strings (use constants)
- [ ] Public APIs documented

---

## Common Patterns

### BLoC/Cubit State Naming

```dart
// State base class
abstract class LoginState {}

// Specific states
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess({required this.user});
}
class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}
```

### Repository Pattern

```dart
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<List<User>> getAllUsers();
  Future<void> updateUser(User user);
}

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;
  
  UserRepositoryImpl(this._dio);
  
  @override
  Future<User> getUser(String id) async {
    final response = await _dio.get('/users/$id');
    return User.fromJson(response.data);
  }
  // ...
}
```

---

## Resources

- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- [Dart Linter Rules](https://dart.dev/tools/linter-rules)
