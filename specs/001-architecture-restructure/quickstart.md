# Quickstart: architecture-restructure

## Prerequisites
- Flutter SDK (matching project constraints), Dart 3.5.x
- Android/iOS tooling (emulator/simulator or device)
- No Web support (out of scope)

## Environment
- Copy `.env.example` to `.env` (or set `--dart-define` values) for API base URLs and keys.
- Ensure assets use snake_case filenames and references are updated.

## Install
```bash
flutter pub get
```

## Run (Android)
```bash
flutter run -d emulator-5554
```

## Run (iOS)
```bash
flutter run -d "iPhone 15"
```

## Tests
```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

## Notes
- Main entry should remain minimal (bootstrap + router + theme).
- Centralized routing via Navigator 1.0 route table under `lib/app/router/`.
- Design tokens & shared UI under `lib/core/design_system/` and `lib/core/ui/`.
