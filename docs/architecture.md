# Architecture Overview

## Scope

MLH code sample refactor for ASD SmartCare Flutter app. This document describes the architectural decisions and patterns used in the codebase.

## Layered Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│         (Screens, Widgets, Cubits/BLoCs)               │
├─────────────────────────────────────────────────────────┤
│                    Domain Layer                          │
│           (Use Cases, Business Logic)                   │
├─────────────────────────────────────────────────────────┤
│                    Data Layer                            │
│    (Repositories, Data Sources, API Clients)           │
└─────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

**Presentation Layer (UI → Cubit)**
- `lib/**/views/` - Screen widgets that render UI
- `lib/**/controllers/` - Cubit/BLoC classes managing state
- Uses design tokens from `lib/core/design_system/`
- Uses shared UI components from `lib/core/ui/`

**Data Layer (Repository → Datasource)**
- `lib/**/data/` - Repository implementations
- `lib/core/network/` - Dio client, interceptors, error handling
- Sealed result types for type-safe error handling

## State Management

We use **Cubit** (from flutter_bloc) with **sealed classes** for type-safe state handling:

```dart
// Sealed state hierarchy
sealed class BookingState {}
final class SlotsLoading extends BookingState {}
final class SlotsLoaded extends BookingState { ... }
final class BookingError extends BookingState { ... }
```

Benefits:
- Exhaustive switch statements
- Compile-time safety
- Clear state transitions

## Navigation

**Navigator 1.0** with centralized route table in `lib/app/router/app_router.dart`:

```dart
// Route constants
abstract final class AppRoutes {
  static const String login = '/login';
  static const String parentHome = '/parent/home';
  // ...
}

// Route generator
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Maps route names to screen widgets
  }
}
```

**Route Arguments**: Type-safe argument classes for passing data between routes.

## Design System

Centralized tokens in `lib/core/design_system/`:

| File | Purpose |
|------|---------|
| `tokens/colors.dart` | Color palette (primary, surface, error, etc.) |
| `tokens/typography.dart` | Text styles (display, title, body, etc.) |
| `tokens/spacing.dart` | Spacing values (xs, sm, md, lg, xl) |
| `tokens/radius.dart` | Border radius values |
| `theme.dart` | ThemeData consuming all tokens |

## Shared UI Components

Reusable components in `lib/core/ui/`:

```
lib/core/ui/
├── buttons/app_button.dart      # Primary/secondary buttons
├── text_fields/app_text_field.dart  # Text input with validation
├── search/app_search_field.dart # Search input variant
├── cards/app_card.dart          # Card containers
├── app_bar/app_header.dart      # App header/nav bar
└── states/
    ├── loading_view.dart        # Loading indicator
    ├── error_view.dart          # Error with retry
    └── empty_view.dart          # Empty state with action
```

## Feature Organization

```
lib/
├── app/router/          # Centralized routing
├── core/
│   ├── design_system/   # Tokens, theme
│   ├── network/         # Dio, API handling
│   ├── ui/              # Shared UI components
│   └── utils/           # Utilities
├── doctor/              # Doctor-specific features
├── parent/              # Parent-specific features
└── shared/
    ├── auth/            # Authentication (login, signup)
    ├── donations/       # Charity/donations
    └── medicines/       # Medicine guide
```

## Repository Pattern

Repositories abstract API calls with proper error mapping:

```dart
sealed class BookingResult<T> {
  const BookingResult();
}

final class BookingSuccess<T> extends BookingResult<T> {
  final T data;
  const BookingSuccess(this.data);
}

final class BookingFailure<T> extends BookingResult<T> {
  final String message;
  final BookingErrorType type;
  const BookingFailure({required this.message, required this.type});
}
```

## Error Handling

- **Network errors**: Mapped to typed error enums
- **API errors**: Parsed from response bodies
- **UI feedback**: Error states with retry actions

## Testing Strategy

| Layer | Test Type | Tools |
|-------|-----------|-------|
| UI | Widget tests | flutter_test, mocktail |
| Logic | Unit tests (Cubit) | bloc_test, mocktail |
| Data | Repository tests | flutter_test, mocktail |

## Platforms

- **Supported**: Android, iOS
- **Out of scope**: Web, Desktop

## Dependencies

Key packages:
- `flutter_bloc` - State management
- `dio` - HTTP client
- `mocktail` - Test mocking
- `bloc_test` - Cubit/BLoC testing
