/// Core UI components barrel export.
///
/// This library provides a unified interface to all reusable UI components
/// in the ASD SmartCare app. All components follow the design system tokens
/// defined in `package:asdsmartcare/core/design_system/tokens/`.
///
/// ## Usage
/// ```dart
/// import 'package:asdsmartcare/core/ui/ui.dart';
/// ```
///
/// ## Component Categories
///
/// ### Containers
/// Layout utilities and structural components:
/// - [AppSpacer] - Vertical/horizontal spacing using design tokens
/// - [AppDivider] - Divider lines with consistent styling
/// - [ResponsiveContainer] - Width-constrained container for responsive layouts
/// - [SectionHeader] - Reusable section header with optional action button
/// - [PageHeader] - Modern large title header for page bodies
///
/// ### Buttons
/// Interactive button components:
/// - [AppButton] - Primary, secondary, and text button variants
/// - [AppIconButton] - Icon-only buttons with consistent sizing
///
/// ### Text Fields
/// Form input components:
/// - [AppTextField] - Text input with validation support
/// - [AppDropdownField] - Dropdown selection field
///
/// ### Search
/// Search functionality:
/// - [AppSearchField] - Search input with debounce support
///
/// ### Cards
/// Content containers:
/// - [AppCard] - Card with elevation and padding options
///
/// ### App Bar
/// Navigation components:
/// - [AppHeader] - Consistent app bar styling
/// - [SliverAppHeader] - Modern scrolling app bar
///
/// ### State Views
/// Loading, error, and empty state displays:
/// - [LoadingView] - Centered loading indicator
/// - [ErrorView] - Error message with retry action
/// - [EmptyView] - Empty state with optional action
///
/// ## Migration from Legacy
/// If importing from `core/widgets/layouts/`, update to use this barrel:
/// ```dart
/// // Before (deprecated)
/// import 'package:asdsmartcare/core/widgets/layouts/app_buttons.dart';
///
/// // After
/// import 'package:asdsmartcare/core/ui/ui.dart';
/// ```
library;

// ─────────────────────────────────────────────────────────────────────────────
// DESIGN SYSTEM TOKENS
// ─────────────────────────────────────────────────────────────────────────────

export 'package:asdsmartcare/core/design_system/tokens/colors.dart';
export 'package:asdsmartcare/core/design_system/tokens/typography.dart';
export 'package:asdsmartcare/core/design_system/tokens/spacing.dart';
export 'package:asdsmartcare/core/design_system/tokens/radius.dart';
export 'package:asdsmartcare/core/design_system/tokens/shadows.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CONTAINERS
// Layout utilities and structural components
// ─────────────────────────────────────────────────────────────────────────────

/// Vertical/horizontal spacing widget using [AppSpacing] tokens.
export 'containers/app_spacer.dart';

/// Divider widget using [AppColors] and [AppSpacing] tokens.
export 'containers/app_divider.dart';

/// Width-constrained container for responsive layouts.
export 'containers/responsive_container.dart';

/// Reusable section header with optional action button.
export 'containers/section_header.dart';
export 'containers/page_header.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BUTTONS
// Interactive button components
// ─────────────────────────────────────────────────────────────────────────────

/// Primary, secondary, and text button variants with design tokens.
export 'buttons/app_button.dart';

/// Icon-only buttons with consistent sizing.
export 'buttons/app_icon_button.dart';
export 'buttons/app_back_button.dart';
export 'buttons/filter_pill.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TEXT FIELDS
// Form input components
// ─────────────────────────────────────────────────────────────────────────────

/// Text input with validation, keyboard types, and design tokens.
export 'text_fields/app_text_field.dart';

/// Dropdown selection field with consistent styling.
export 'text_fields/app_dropdown_field.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SEARCH
// Search functionality
// ─────────────────────────────────────────────────────────────────────────────

/// Search input with debounce support.
export 'search/app_search_field.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CARDS
// Content containers
// ─────────────────────────────────────────────────────────────────────────────

/// Card with elevation and padding options.
export 'cards/app_card.dart';

/// Immersive card with image background and gradient overlay.
export 'cards/immersive_card.dart';

/// Action suggestion card with priority indicators.
export 'cards/action_suggestion_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROGRESS
// Progress indicators
// ─────────────────────────────────────────────────────────────────────────────

/// Circular progress ring with animation.
export 'progress/progress_ring.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BADGES
// Status and result indicators
// ─────────────────────────────────────────────────────────────────────────────

/// Result badge for test results.
export 'badges/result_badge.dart';

// ─────────────────────────────────────────────────────────────────────────────
// APP BAR
// Navigation components
// ─────────────────────────────────────────────────────────────────────────────

/// Consistent app bar styling.
export 'app_bar/app_header.dart';
export 'app_bar/sliver_app_header.dart';

/// Mesh gradient background widget.
export 'backgrounds/mesh_gradient_background.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE VIEWS
// Loading, error, and empty state displays
// ─────────────────────────────────────────────────────────────────────────────

/// Centered loading indicator.
export 'states/loading_view.dart';

/// Error message with retry action.
export 'states/error_view.dart';

/// Empty state with optional action.
export 'states/empty_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROFILE
// Profile-specific widgets
// ─────────────────────────────────────────────────────────────────────────────

/// Premium profile avatar with a dual-ring border.
export 'profile/profile_avatar.dart';
export 'profile/editable_profile_avatar.dart';

/// Reusable profile detail tile for displaying label-value pairs.
export 'profile/profile_detail_tile.dart';

/// Vertical stat item for displaying metrics.
export 'profile/stat_item.dart';

/// Animated typing indicator for bots.
export 'states/bot_typing_indicator.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BOOKING
// Booking flow components
// ─────────────────────────────────────────────────────────────────────────────

/// Reusable doctor info card for booking flows.
export 'booking/doctor_info_card.dart';

/// Reusable grid for selecting time slots.
export 'booking/time_slot_grid.dart';

/// Reusable tile for selecting a payment method.
export 'booking/payment_option_tile.dart';

/// Reusable label-value row for booking details.
export 'booking/booking_detail_row.dart';
