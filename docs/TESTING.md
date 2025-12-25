# Testing Guide

Comprehensive testing documentation for the ASD SmartCare Flutter application.

---

## Table of Contents

- [Overview](#overview)
- [Test Architecture](#test-architecture)
- [Running Tests](#running-tests)
- [Writing Tests](#writing-tests)
- [Mocking Patterns](#mocking-patterns)
- [Coverage Reports](#coverage-reports)
- [CI/CD Integration](#cicd-integration)

---

## Overview

The project uses Flutter's built-in testing framework with:
- **mocktail** for mocking dependencies
- **bloc_test** for testing Cubits/BLoCs
- **69+ tests** covering core functionality

### Test Types

| Type | Purpose | Location |
|------|---------|----------|
| Unit Tests | Test business logic (Cubits, repositories) | `test/**/` |
| Widget Tests | Test UI components | `test/**/` |
| Integration Tests | End-to-end flows | `integration_test/` (future) |

---

## Test Architecture

Tests mirror the `lib/` folder structure:

```
test/
├── app/                    # Router tests
│   └── router/
├── core/                   # Design system, network tests
│   ├── design_system/
│   ├── network/
│   └── ui/
├── doctor/                 # Doctor feature tests
│   ├── account/
│   ├── appointments/
│   ├── home/
│   ├── my_patients/
│   └── sessions/
├── parent/                 # Parent feature tests
│   ├── account/
│   ├── chatbot/
│   ├── education/
│   ├── find_doctors/
│   ├── home/
│   ├── my_children/
│   ├── progress/
│   └── screening/
├── shared/                 # Shared feature tests
│   ├── auth/
│   └── donations/
└── widget_test.dart        # Basic app test
```

---

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test File

```bash
flutter test test/parent/screening/test/controllers/autism_checker_cubit_test.dart
```

### Run Tests in a Directory

```bash
# All parent tests
flutter test test/parent/

# All doctor tests
flutter test test/doctor/

# All core tests
flutter test test/core/
```

### Run with Verbose Output

```bash
flutter test --reporter=expanded
```

### Run a Single Test by Name

```bash
flutter test --name "should emit success state"
```

---

## Writing Tests

### Cubit/BLoC Test Pattern

Use `bloc_test` for testing state management:

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

// 1. Create mock
class MockRepository extends Mock implements ExampleRepository {}

void main() {
  late ExampleCubit cubit;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    cubit = ExampleCubit(repository: mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('ExampleCubit', () {
    test('initial state is ExampleInitial', () {
      expect(cubit.state, isA<ExampleInitial>());
    });

    blocTest<ExampleCubit, ExampleState>(
      'emits [Loading, Success] when fetch succeeds',
      build: () {
        when(() => mockRepository.getData())
            .thenAnswer((_) async => ['item1', 'item2']);
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        isA<ExampleLoading>(),
        isA<ExampleSuccess>(),
      ],
    );

    blocTest<ExampleCubit, ExampleState>(
      'emits [Loading, Error] when fetch fails',
      build: () {
        when(() => mockRepository.getData())
            .thenThrow(Exception('Network error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchData(),
      expect: () => [
        isA<ExampleLoading>(),
        isA<ExampleError>(),
      ],
    );
  });
}
```

### Widget Test Pattern

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  testWidgets('displays loading indicator when loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ExampleCubit>(
          create: (_) => ExampleCubit()..emit(ExampleLoading()),
          child: const ExampleScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays data when loaded', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ExampleCubit>(
          create: (_) => ExampleCubit()..emit(ExampleSuccess(['Item 1'])),
          child: const ExampleScreen(),
        ),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
  });
}
```

---

## Mocking Patterns

### Creating Mocks with Mocktail

```dart
import 'package:mocktail/mocktail.dart';

// Mock a class
class MockDio extends Mock implements Dio {}

// Mock with generic types
class MockRepository extends Mock implements Repository<User> {}

// Register fallback values for custom types
setUpAll(() {
  registerFallbackValue(UserModel(id: '', name: ''));
});
```

### Stubbing Methods

```dart
// Return a value
when(() => mockRepo.getUser('123')).thenAnswer((_) async => user);

// Throw an exception
when(() => mockRepo.getUser('invalid')).thenThrow(NotFoundException());

// Capture arguments
final captured = verify(() => mockRepo.save(captureAny())).captured;
```

---

## Coverage Reports

### Generate Coverage

```bash
flutter test --coverage
```

This creates `coverage/lcov.info`.

### View Coverage Report (HTML)

```bash
# Install lcov (if not installed)
# macOS: brew install lcov
# Ubuntu: sudo apt-get install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html  # macOS
start coverage/html/index.html # Windows
```

### Coverage Goals

| Component | Target |
|-----------|--------|
| Cubits/BLoCs | 80%+ |
| Repositories | 70%+ |
| Utilities | 90%+ |
| Widgets | 50%+ |

---

## CI/CD Integration

Tests run automatically on:
- Every push to `main`, `develop`, and `feature/*` branches
- Every pull request

### CI Test Configuration

From `.github/workflows/flutter-ci-cd.yml`:

```yaml
test:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.32.0'
        cache: true
    - run: flutter pub get
    - run: flutter test --coverage --reporter=expanded
    - uses: codecov/codecov-action@v4
      with:
        files: coverage/lcov.info
```

### Viewing CI Results

1. Go to **Actions** tab on GitHub
2. Click on the workflow run
3. Expand the **Tests** job
4. View test output and coverage upload

---

## Troubleshooting

### Tests Fail with "Could not find widget"

Ensure you wrap your widget in `MaterialApp`:

```dart
await tester.pumpWidget(
  MaterialApp(home: YourWidget()),  // ✅ Correct
);
```

### Async Tests Timeout

Increase timeout or use `pumpAndSettle`:

```dart
await tester.pumpAndSettle(const Duration(seconds: 5));
```

### Mock Not Working

Ensure you've registered fallback values for custom types:

```dart
setUpAll(() {
  registerFallbackValue(MyCustomType());
});
```

---

## Related Documentation

- [CONTRIBUTING.md](../CONTRIBUTING.md) - Development workflow
- [CODE_QUALITY.md](../CODE_QUALITY.md) - Code standards
- [CI_CD_PIPELINE.md](CI_CD_PIPELINE.md) - CI/CD details
