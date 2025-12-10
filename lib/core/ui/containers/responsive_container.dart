import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Responsive breakpoints for layout adaptation.
///
/// Based on Material Design 3 guidelines:
/// - Mobile: 320-599dp (compact)
/// - Tablet: 600-1023dp (medium)
/// - Desktop: 1024dp+ (expanded)
enum DeviceBreakpoint {
  /// Mobile devices (320-599dp width)
  mobile,

  /// Tablet devices (600-1023dp width)
  tablet,

  /// Desktop screens (1024dp+ width)
  desktop,
}

/// Responsive container that adapts its child based on screen size.
///
/// Usage:
/// ```dart
/// ResponsiveContainer(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// )
///
/// // Or with builder for access to breakpoint:
/// ResponsiveContainer.builder(
///   builder: (context, breakpoint) {
///     return Text('Current: $breakpoint');
///   },
/// )
/// ```
class ResponsiveContainer extends StatelessWidget {
  /// Widget to display on mobile (320-599dp)
  final Widget? mobile;

  /// Widget to display on tablet (600-1023dp)
  final Widget? tablet;

  /// Widget to display on desktop (1024dp+)
  final Widget? desktop;

  /// Builder function that receives the current breakpoint
  final Widget Function(BuildContext context, DeviceBreakpoint breakpoint)?
  builder;

  /// Builder function for sliver layouts
  final Widget Function(BuildContext context, DeviceBreakpoint breakpoint)?
  sliverBuilder;

  const ResponsiveContainer({super.key, this.mobile, this.tablet, this.desktop})
    : builder = null,
      sliverBuilder = null;

  /// Create a responsive container with a builder function.
  const ResponsiveContainer.builder({super.key, required this.builder})
    : mobile = null,
      tablet = null,
      desktop = null,
      sliverBuilder = null;

  /// Create a responsive container for sliver layouts.
  const ResponsiveContainer.sliverBuilder({
    super.key,
    required this.sliverBuilder,
  }) : mobile = null,
       tablet = null,
       desktop = null,
       builder = null;

  /// Get the current device breakpoint from context.
  static DeviceBreakpoint of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return getBreakpoint(width);
  }

  /// Get breakpoint from width value.
  static DeviceBreakpoint getBreakpoint(double width) {
    if (width < 600) {
      return DeviceBreakpoint.mobile;
    } else if (width < 1024) {
      return DeviceBreakpoint.tablet;
    } else {
      return DeviceBreakpoint.desktop;
    }
  }

  /// Check if current device is mobile.
  static bool isMobile(BuildContext context) {
    return of(context) == DeviceBreakpoint.mobile;
  }

  /// Check if current device is tablet.
  static bool isTablet(BuildContext context) {
    return of(context) == DeviceBreakpoint.tablet;
  }

  /// Check if current device is desktop.
  static bool isDesktop(BuildContext context) {
    return of(context) == DeviceBreakpoint.desktop;
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = of(context);

    if (sliverBuilder != null) {
      return sliverBuilder!(context, breakpoint);
    }

    if (builder != null) {
      return builder!(context, breakpoint);
    }

    switch (breakpoint) {
      case DeviceBreakpoint.mobile:
        return mobile ?? tablet ?? desktop ?? const SizedBox.shrink();
      case DeviceBreakpoint.tablet:
        return tablet ?? mobile ?? desktop ?? const SizedBox.shrink();
      case DeviceBreakpoint.desktop:
        return desktop ?? tablet ?? mobile ?? const SizedBox.shrink();
    }
  }
}

/// Responsive padding that adapts based on screen size.
///
/// Usage:
/// ```dart
/// ResponsivePadding(
///   child: Text('Content'),
/// )
/// ```
class ResponsivePadding extends StatelessWidget {
  /// The child widget to apply padding to
  final Widget child;

  /// Horizontal padding for mobile (defaults to screenPaddingH)
  final double? mobileHorizontal;

  /// Horizontal padding for tablet
  final double? tabletHorizontal;

  /// Horizontal padding for desktop
  final double? desktopHorizontal;

  /// Vertical padding (same for all breakpoints)
  final double vertical;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobileHorizontal,
    this.tabletHorizontal,
    this.desktopHorizontal,
    this.vertical = 0,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveContainer.of(context);

    double horizontal;
    switch (breakpoint) {
      case DeviceBreakpoint.mobile:
        horizontal = mobileHorizontal ?? AppSpacing.screenPaddingH;
        break;
      case DeviceBreakpoint.tablet:
        horizontal = tabletHorizontal ?? AppSpacing.lg;
        break;
      case DeviceBreakpoint.desktop:
        horizontal = desktopHorizontal ?? AppSpacing.xl;
        break;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}

/// Responsive value selector based on breakpoint.
///
/// Usage:
/// ```dart
/// final fontSize = ResponsiveValue<double>(
///   context: context,
///   mobile: 14,
///   tablet: 16,
///   desktop: 18,
/// ).value;
/// ```
class ResponsiveValue<T> {
  final BuildContext context;
  final T mobile;
  final T? tablet;
  final T? desktop;

  const ResponsiveValue({
    required this.context,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Get the value for the current breakpoint.
  T get value {
    final breakpoint = ResponsiveContainer.of(context);

    switch (breakpoint) {
      case DeviceBreakpoint.mobile:
        return mobile;
      case DeviceBreakpoint.tablet:
        return tablet ?? mobile;
      case DeviceBreakpoint.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
