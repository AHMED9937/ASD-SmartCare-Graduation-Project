# Feature Specification: UI Component System Consolidation

**Feature Branch**: `002-ui-consolidation`  
**Created**: 2025-12-16  
**Status**: Draft  
**Input**: "Consolidate and reorganize UI component system by moving legacy widgets from lib/core/widgets/layouts to lib/core/ui and removing deprecated code"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Unified, organized UI component system (Priority: P1)

Developer can find all reusable UI components in a single, well-organized location (`lib/core/ui/`) with clear categorization by component type, making it easy to discover and reuse existing components.

**Why this priority**: Reduces confusion from split component systems; improves developer efficiency; prerequisite for successful screen refactoring in 003-screen-audit.

**Independent Test**: Inspect `lib/core/ui/` directory structure; verify all reusable components (buttons, text fields, cards, states, etc.) are present and organized by type; zero components in deprecated `lib/core/widgets/layouts/`.

**Acceptance Scenarios**:

1. **Given** a developer looking for a button component, **When** they navigate to `lib/core/ui/buttons/`, **Then** they find all button variants (primary, secondary, icon, etc.) organized and documented.
2. **Given** a developer looking for form input components, **When** they navigate to `lib/core/ui/text_fields/`, **Then** they find all text field variants with clear usage examples.
3. **Given** a developer browsing `lib/core/ui/` structure, **When** looking for any common UI pattern, **Then** it exists in one predictable location (no split across multiple directories).

---

### User Story 2 - All legacy widgets migrated and deprecated code removed (Priority: P1)

Developer can reference codebase without encountering imports from deprecated `lib/core/widgets/layouts/` directory; all legacy components have been either migrated or removed if no longer needed.

**Why this priority**: Eliminates confusion about which component system to use; prevents accidental use of old components in new code.

**Independent Test**: Search entire codebase for imports from `lib/core/widgets/layouts/`; verify zero results in screen files (only in migration/cleanup files if necessary); `lib/core/widgets/layouts/` directory is empty or removed.

**Acceptance Scenarios**:

1. **Given** any screen file, **When** searching for `import 'package:asdsmartcare/core/widgets/layouts/`, **Then** zero results found.
2. **Given** the old `lib/core/widgets/layouts/` directory, **When** inspecting its contents, **Then** it is either empty or removed entirely.
3. **Given** a developer starting to write a new screen, **When** they need a UI component, **Then** they import from `lib/core/ui/` only (no legacy system to confuse).

---

### User Story 3 - Component library documentation is clear and complete (Priority: P2)

Developer can open any component file or the central UI export file and see clear documentation about what each component does, how to use it, and what props it accepts.

**Why this priority**: Enables self-service component discovery; reduces questions and speeds up feature development.

**Independent Test**: Review `lib/core/ui/ui.dart` (main export file); verify each exported component has doc comments; open 5 random component files and verify they have usage examples or clear documentation.

**Acceptance Scenarios**:

1. **Given** the central `lib/core/ui/ui.dart` file, **When** viewing it, **Then** each exported component has a doc comment explaining its purpose.
2. **Given** any component file (e.g., `buttons/app_button.dart`), **When** viewing the code, **Then** it has clear doc comments and/or usage examples.
3. **Given** a developer reading component documentation, **When** they want to use a component, **Then** they understand what it does, what parameters it accepts, and how to customize it.

---

### User Story 4 - No breaking changes to existing screens using old components (Priority: P2)

Existing screens that use legacy components from `lib/core/widgets/` continue to work during transition; breaking changes are minimized during migration.

**Why this priority**: Enables gradual migration without stopping other work; reduces risk of regressions.

**Independent Test**: Keep screen using old components; verify it still compiles and runs (maybe with deprecation warnings); after migration is complete, same screen uses new components without functional changes.

**Acceptance Scenarios**:

1. **Given** a screen using legacy `lib/core/widgets/layouts/AppButton`, **When** the app runs, **Then** it still functions (either using old component or deprecated wrapper).
2. **Given** existing tests for screens using old components, **When** tests run, **Then** they still pass (no breakage during transition).
3. **Given** migration is complete, **When** reviewing the same screen code, **Then** it now uses new `lib/core/ui/buttons/` without functional changes.

---

### User Story 5 - Core application state management (Cubit, BLoC) is separate from UI components (Priority: P3)

Application state management classes (`AppCubit`, `AsdCubit`, etc.) are clearly separated from reusable UI components; no confusion between state management and UI rendering logic.

**Why this priority**: Maintains clean separation of concerns; prevents mixing business logic with UI components.

**Independent Test**: Verify `lib/core/ui/` contains only UI components (no state classes); verify state management files are in `lib/core/` root level or appropriate feature folders.

**Acceptance Scenarios**:

1. **Given** the `lib/core/ui/` directory, **When** inspecting all files, **Then** zero state management classes are present (only UI components).
2. **Given** application state classes like `AppCubit`, **When** looking for them, **Then** they are located in appropriate locations (not mixed with UI components).
3. **Given** a developer implementing a new state management class, **When** they place it, **Then** they naturally separate it from `lib/core/ui/` to avoid confusion.

---

### Edge Cases

- What if some legacy components are used in multiple places - how to migrate without breaking everything?
- What if old and new component APIs are slightly different - how to handle the transition?
- What if a legacy component is used in a third-party plugin or dependency?
- How to handle deprecated components that are still referenced in old tests?
- What if screenshots or UI in documentation reference old component paths?
- How to ensure all imports are updated consistently across the codebase?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: ALL reusable UI components (buttons, text fields, cards, states, etc.) MUST be located in `lib/core/ui/` organized by component type in subdirectories.
- **FR-002**: `lib/core/ui/ui.dart` MUST serve as the central export file re-exporting all public components and providing a single import path for consumers.
- **FR-003**: ALL legacy components in `lib/core/widgets/layouts/` MUST be migrated to `lib/core/ui/` with consolidated design and improved UI/UX.
- **FR-003a**: Legacy components MUST be redesigned to: (1) use design tokens (`AppColors.*`, `AppSpacing.*`, `AppTypography.*`) instead of hardcoded values, (2) support responsive layouts with breakpoints (mobile: 320-599dp, tablet: 600-1023dp, desktop: 1024dp+), (3) implement proper component variants (sizes: small/medium/large, states: default/hover/pressed/disabled, error/success), (4) align with new `lib/core/ui/` component patterns and API consistency.
- **FR-004**: ALL screen files MUST NOT import from `lib/core/widgets/layouts/`; all imports MUST be from `lib/core/ui/` or state-specific files.
- **FR-005**: ALL component files MUST include doc comments explaining purpose, usage, and key parameters.
- **FR-006**: `lib/core/widgets/` files (app_cubit, app_state, bloc_observer) MUST be moved to new `lib/core/state/` directory to separate state management from UI components.
- **FR-007**: Feature-specific components like `ReviewSpacificDoctor/` MUST be moved to appropriate feature folders (e.g., `lib/parent/find_doctors/components/`), not kept in core.
- **FR-008**: ANY deprecated components MUST either have a clear migration path (deprecation warning with @Deprecated annotation, documented alternative component in doc comment, migration example code provided) or be fully removed with all references updated.
- **FR-009**: Component imports in screens MUST use the centralized `lib/core/ui/ui.dart` export when possible, or specific component imports for clarity.
- **FR-010**: ZERO hardcoded component duplicates MUST exist (each component implemented once, reused everywhere).

### Component Inventory to Consolidate

**Components to Migrate & Redesign from `lib/core/widgets/layouts/`**:
- `app_buttons.dart` → Consolidate into `lib/core/ui/buttons/` with improved design (variants, design tokens, responsive, proper states)
- `app_form_text_field.dart` → Consolidate into `lib/core/ui/text_fields/` with improved design (error states, design tokens, accessibility, responsive)
- `stateless_app_text_form_field.dart` → Consolidate/merge variant into `lib/core/ui/text_fields/` (combine or clarify purpose with tokens and improvements)
- `fixed_widgets.dart` → Consolidate reusable utilities into `lib/core/ui/containers/` (spacers, layout helpers with design tokens, responsive)
- `ReviewSpacificDoctor/` → Move to feature-specific location `lib/parent/find_doctors/components/` (not a core reusable component)

**Already in `lib/core/ui/` (keep)**:
- `app_bar/` - App header/navigation bar components
- `buttons/` - Button variants (primary, secondary, etc.)
- `cards/` - Card/container components
- `search/` - Search input components
- `states/` - State indicators (LoadingView, ErrorView, EmptyView)
- `text_fields/` - Text input components

**Application State (Move from `lib/core/widgets/` to `lib/core/state/`)**:
- `app_cubit.dart` - Application-level Cubit
- `app_state.dart` - Application state class
- `bloc_observer.dart` - BLoC event observer

### Architecture After Consolidation

```
lib/core/
├── ui/                          # Reusable UI Components
│   ├── app_bar/                 # App header components
│   ├── buttons/                 # Button components
│   ├── cards/                   # Card/container components
│   ├── search/                  # Search field components
│   ├── states/                  # State indicator components
│   ├── text_fields/             # Text input components
│   ├── containers/              # [NEW IF NEEDED] Layout containers
│   └── ui.dart                  # Central export file
├── widgets/                     # [LEGACY - to be removed or repurposed]
│   ├── app_cubit.dart           # Application Cubit [KEEP]
│   ├── app_state.dart           # Application state [KEEP]
│   └── bloc_observer.dart       # BLoC observer [KEEP]
├── design_system/               # Design tokens
├── network/                     # Network/API
├── cache/                       # Caching
└── ...
```

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of legacy components in `lib/core/widgets/layouts/` either migrated to `lib/core/ui/` or removed with decision documented.
- **SC-002**: Zero imports from `lib/core/widgets/layouts/` found in any screen or feature files (except legacy cleanup code).
- **SC-003**: All components in `lib/core/ui/` include clear doc comments and are properly exported via `lib/core/ui/ui.dart`.
- **SC-004**: Zero component duplicates exist (verified by code review and search).
- **SC-005**: All screen files successfully use `lib/core/ui/` components without compilation errors.
- **SC-006**: Flutter analyze shows zero new errors after consolidation.
- **SC-007**: All existing tests (90+) continue to pass after consolidation.
- **SC-008**: Clear documentation exists distinguishing between `lib/core/ui/` (UI components) and `lib/core/widgets/` (app state management).

### Quality Metrics

- **QM-001**: `lib/core/ui/` directory contains 8-12 well-organized subdirectories (organized by component type).
- **QM-002**: Average lines of code per component file: 50-150 lines (focused, single-responsibility components).
- **QM-003**: `lib/core/ui/ui.dart` re-exports all public components (existing 15+ in lib/core/ui/ plus 5 migrated from lib/core/widgets/layouts/) for single-import convenience.
- **QM-004**: Zero compiler warnings related to unused imports or deprecated components.

## Dependencies & Assumptions *(mandatory)*

### Dependencies

- Must be completed before or as part of `003-screen-audit` (screen refactoring).
- Requires access to codebase search tools to identify all component imports.
- Depends on having clear documentation of which components are reusable vs feature-specific.

### Assumptions

- Existing components in `lib/core/ui/` are well-designed and can serve as the target for consolidated components.
- Legacy components in `lib/core/widgets/layouts/` are not part of public API (only internal use).
- No external packages depend on the old component paths.
- Team is available to review and test the consolidated component library.
- Breaking changes to component APIs are acceptable (with proper migration path).

## Out of Scope

- Adding new component types beyond consolidation (only consolidating and improving existing ones)
- Performance optimization of components beyond responsive layout support
- Adding animations or advanced visual effects
- Creating design documentation or design system (already exists in docs/design_system.md)
- Adding new accessibility features beyond what already exists
- Creating Storybook or component gallery tools

## Clarifications

### Session 2025-12-16

The following clarifications were recorded during specification refinement:

- **Q1: Migration Strategy** → **Answer: Consolidate** - Legacy components will be merged into `lib/core/ui/` (not kept as separate variants)
- **Q2: UI Redesign Scope** → **Answer: Include** - UI/UX improvements are IN SCOPE: replace hardcoded colors with design tokens, add responsive layouts, implement proper variants, align with new component patterns
- **Q3: fixed_widgets.dart Classification** → **Answer: Reusable** - Will be consolidated into `lib/core/ui/containers/` as reusable layout components
- **Q4: ReviewSpacificDoctor/ Classification** → **Answer: Feature-specific** - Will be moved to `lib/parent/find_doctors/components/` (not core component)
- **Q5: lib/core/widgets/ Reorganization** → **Answer: Reorganize to lib/core/state/** - State management files will move from `lib/core/widgets/` to new `lib/core/state/` directory

## Notes

- This spec consolidates UI components INTO `lib/core/ui/` WITH UI/UX improvements (design tokens, responsive, variants, consistency).
- App state management (`AppCubit`, etc.) is reorganized into separate `lib/core/state/` directory to maintain clean separation of concerns.
- Feature-specific components (e.g., doctor reviews) are moved to feature folders, not mixed with core components.
- Consider creating a migration checklist file to track which legacy components have been processed.
- After consolidation, update `docs/design_system.md` to reference only `lib/core/ui/` location and new `lib/core/state/` for state management.
- This work should be completed before widespread use of `lib/core/ui/` in screen refactoring (003-screen-audit) to avoid rework.
