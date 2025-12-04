# Contributing to ASD SmartCare

Thank you for your interest in contributing to ASD SmartCare! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Development Workflow](#development-workflow)
- [Setting Up Development Environment](#setting-up-development-environment)
- [Code Style Guidelines](#code-style-guidelines)
- [Commit Message Format](#commit-message-format)
- [Pull Request Process](#pull-request-process)
- [Running Quality Checks](#running-quality-checks)
- [Testing Guidelines](#testing-guidelines)

---

## Development Workflow

1. **Fork** the repository on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/ASD-SmartCare-Graduation-Project.git
   cd ASD-SmartCare-Graduation-Project
   ```
3. **Create a branch** for your feature/fix:
   ```bash
   git checkout -b feat/your-feature-name
   ```
4. **Make changes** following the code style guidelines
5. **Test** your changes (see [Running Quality Checks](#running-quality-checks))
6. **Commit** using Conventional Commits format
7. **Push** to your fork:
   ```bash
   git push origin feat/your-feature-name
   ```
8. **Create Pull Request** against `main` branch

---

## Setting Up Development Environment

### Prerequisites

- Flutter SDK ≥ 3.32.0
- Dart SDK ≥ 3.5.0
- Android SDK (API 21+)
- VS Code or Android Studio

### Setup Steps

```bash
# Install dependencies
flutter pub get

# Copy environment file
cp .env.example .env
# Edit .env with your configuration

# Verify setup
flutter doctor

# Run the app
flutter run
```

---

## Code Style Guidelines

### Dart/Flutter Conventions

- **File naming**: Use `snake_case` for file names (`user_profile_screen.dart`)
- **Class naming**: Use `PascalCase` for classes (`UserProfileScreen`)
- **Variable naming**: Use `camelCase` for variables and functions
- **Private members**: Prefix with underscore (`_privateMethod`)
- **Constants**: Use `camelCase` or `SCREAMING_SNAKE_CASE` for top-level constants

### Project Conventions

- **Feature structure**: Each feature follows `controllers/`, `views/`, `data/` pattern
- **State management**: Use Cubit with sealed classes for states
- **Widgets**: Extract reusable widgets to `lib/core/ui/`
- **Design tokens**: Use values from `lib/core/design_system/` (never hardcode colors/spacing)

### Formatting

```bash
# Format all Dart files
dart format .

# Check formatting without changing files
dart format --set-exit-if-changed .
```

### Linting

The project uses strict lint rules defined in `analysis_options.yaml`:

```bash
# Run static analysis
flutter analyze

# Must pass with zero errors before submitting PR
```

---

## Commit Message Format

We follow **[Conventional Commits](https://www.conventionalcommits.org/)** specification.

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no code change |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `test` | Adding or updating tests |
| `ci` | CI/CD changes |
| `build` | Build system or dependencies |
| `chore` | Other changes (e.g., updating .gitignore) |

### Examples

✅ **Good commit messages:**

```
feat(auth): add biometric login option

fix(booking): resolve payment sheet not appearing on iOS

docs: update README with Docker instructions

test(chatbot): add unit tests for ChatbotCubit

ci: add Firebase App Distribution deployment

refactor(home): extract dashboard widgets to separate files
```

❌ **Bad commit messages:**

```
fixed stuff
update
WIP
changes
```

---

## Pull Request Process

### Before Submitting

1. **All checks must pass:**
   ```bash
   # Run all quality checks
   dart format --set-exit-if-changed .
   flutter analyze
   flutter test
   ```

2. **Update documentation** if needed (README, code comments)

3. **Keep PRs focused** - One feature/fix per PR

4. **Write descriptive PR title** using Conventional Commits format

### PR Template

When creating a PR, include:

```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring
- [ ] Other (describe)

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Manual testing performed

## Checklist
- [ ] Code follows project style guidelines
- [ ] `flutter analyze` passes with no errors
- [ ] `dart format` applied
- [ ] All tests pass
- [ ] Documentation updated if needed
```

### Review Process

1. CI must pass all checks
2. At least one maintainer review required
3. Address all review comments
4. Maintainer will merge when approved

---

## Running Quality Checks

Run all checks before submitting a PR:

```bash
# 1. Format check
dart format --set-exit-if-changed .

# 2. Static analysis
flutter analyze

# 3. Run all tests
flutter test

# 4. Run tests with coverage
flutter test --coverage
```

### Quick Check Script

Create a pre-commit check:

```bash
#!/bin/bash
set -e

echo "🔍 Checking format..."
dart format --set-exit-if-changed .

echo "🔍 Running analysis..."
flutter analyze

echo "🧪 Running tests..."
flutter test

echo "✅ All checks passed!"
```

---

## Testing Guidelines

### Test Structure

Tests mirror the `lib/` structure:

```
test/
├── parent/
│   └── find_doctors/
│       └── booking/
│           ├── booking_cubit_test.dart
│           └── booking_repository_test.dart
├── doctor/
│   └── home/
│       └── doctor_home_screen_test.dart
└── core/
    └── ui/
        └── buttons/
            └── app_button_test.dart
```

### Writing Tests

```dart
// Use descriptive test names
test('should emit SlotsLoaded when fetchAvailableSlots succeeds', () async {
  // Arrange
  when(() => mockRepository.getSlots(any())).thenAnswer(
    (_) async => BookingSuccess([slot1, slot2]),
  );
  
  // Act
  await cubit.fetchAvailableSlots('doctor-123');
  
  // Assert
  expect(cubit.state, isA<SlotsLoaded>());
});
```

### Test Coverage

Aim for meaningful coverage on:
- **Cubits/BLoCs** - All state transitions
- **Repositories** - Success and error paths
- **Widgets** - Key user interactions

---

## Future Development

Areas open for contribution:

- [ ] Internationalization (i18n) support
- [ ] Offline mode with local caching
- [ ] Push notifications
- [ ] Video call integration
- [ ] Advanced analytics dashboard
- [ ] Accessibility improvements

---

## Questions?

If you have questions about contributing, please open a GitHub issue with the `question` label.

Thank you for contributing to ASD SmartCare! 🙏
