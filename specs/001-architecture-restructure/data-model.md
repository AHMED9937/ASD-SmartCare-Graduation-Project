# Data Model: architecture-restructure

## Entities

### DesignTokenSet
- Purpose: Central design tokens consumed by ThemeData and shared UI.
- Fields:
  - colors: primary, secondary, background, surface, error, onPrimary, onBackground, onSurface
  - typography: display/heading/title/body/label styles
  - spacing: xs, sm, md, lg, xl
  - radius: sm, md, lg
  - elevation: none, sm, md

### AppRoute
- Purpose: Centralized route definition for Navigator 1.0.
- Fields:
  - name (String)
  - builder (WidgetBuilder)
  - arguments (optional, typed per screen)
- Relationships: Consumed by route table in `lib/app/router/app_router.dart`.

### AuthSession
- Purpose: Store authentication credentials.
- Fields:
  - accessToken (String)
  - refreshToken (String, optional)
  - expiresAt (DateTime, optional)
- Relationships: Provided to Dio auth interceptor; persisted via cache helper.

### BookingRequest
- Purpose: Payload for booking a doctor.
- Fields:
  - doctorId (String)
  - userId/patientId (String)
  - slotId/time (String/DateTime)
  - notes (String, optional)
- Relationships: Sent via booking repository/service; error mapping to UI states.

### Common UI Component Configs (non-domain)
- Purpose: Parameter objects for shared UI components.
- Examples:
  - AppButtonConfig: label, style (primary/secondary), onPressed, isLoading, icon
  - AppTextFieldConfig: controller, hint, validator, obscured, prefix/suffix
  - StateViewConfig: message, action label/callback (for error/empty), progress flag

## Relationships
- ThemeData consumes DesignTokenSet; shared UI components consume ThemeData.
- Route table aggregates AppRoute definitions; screens use route names only.
- AuthSession injected into Dio via interceptor; cache helper persists session.
- BookingRequest created in booking flow and passed to repository/service.
