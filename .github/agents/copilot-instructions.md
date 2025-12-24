# ASD-SmartCare-Graduation-Project Development Guidelines

Auto-generated from all feature plans. Last updated: 2025-12-16

## Active Technologies
- Dart 3.5.x; Flutter 3.x (mobile) + flutter_bloc (Cubit), dio, flutter_dotenv, get_it (if needed for manual locator), mocktail (tests) (001-architecture-restructure)
- Local cache via cache_helper (shared_prefs-style) (001-architecture-restructure)
- Dart 3.5.x with Flutter 3.x framework + flutter_bloc (Cubit pattern with sealed classes), flutter, dart:async (003-ui-consolidation)
- Local files (no database; state via Cubit/BLoC) (003-ui-consolidation)

- [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION] + [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION] (001-architecture-restructure)

## Project Structure

```text
backend/
frontend/
tests/
```

## Commands

cd src; pytest; ruff check .

## Code Style

[e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]: Follow standard conventions

## Recent Changes
- 003-ui-consolidation: Added Dart 3.5.x with Flutter 3.x framework + flutter_bloc (Cubit pattern with sealed classes), flutter, dart:async
- 001-architecture-restructure: Added Dart 3.5.x; Flutter 3.x (mobile) + flutter_bloc (Cubit), dio, flutter_dotenv, get_it (if needed for manual locator), mocktail (tests)

- 001-architecture-restructure: Added [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION] + [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]

<!-- MANUAL ADDITIONS START -->
<!-- MANUAL ADDITIONS END -->
