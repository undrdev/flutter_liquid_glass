import 'package:flutter/material.dart';

/// A SnackBar with liquid glass effect and slide-in animation.
///
/// Provides a beautiful glassmorphic snackbar that slides up from the bottom
/// with blur, edge shine, and smooth animations.
///
/// Example:
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar(
///   LiquidGlassSnackBar(
///     content: Text('Hello, Glass Snackbar!'),
///   ),
/// );
/// ```
class LiquidGlassSnackBar extends SnackBar {
  /// The blur intensity. Defaults to 20.0.
  final double blurIntensity;

  /// The tint color. Defaults to white with 15% opacity.
  final Color tintColor;

  /// The edge shine intensity. Defaults to 0.3.
  final double edgeShineIntensity;

  /// Border radius for the snackbar.
  final BorderRadius? borderRadius;

  /// Whether to show edge shine.
  final bool edgeShine;

  const LiquidGlassSnackBar({
    super.key,
    required super.content,
    super.duration = const Duration(seconds: 4),
    super.action,
    super.margin = const EdgeInsets.all(8),
    super.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.blurIntensity = 20.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.15),
    this.edgeShineIntensity = 0.3,
    this.borderRadius,
    this.edgeShine = true,
    super.onVisible,
    super.dismissDirection = DismissDirection.down,
    super.behavior = SnackBarBehavior.floating,
  }) : super(
          backgroundColor: Colors.transparent,
          elevation: 0,
        );

  @override
  // ignore: overridden_fields
  ShapeBorder? get shape => RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      );
}

/// Shows a liquid glass snackbar.
///
/// Displays a glassmorphic snackbar with slide and fade animations.
void showLiquidGlassSnackBar({
  required BuildContext context,
  required String message,
  Duration? duration,
  SnackBarAction? action,
  Color? backgroundColor,
  double blurIntensity = 20.0,
  Color tintColor = const Color.fromRGBO(255, 255, 255, 0.15),
  double edgeShineIntensity = 0.3,
  bool edgeShine = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    LiquidGlassSnackBar(
      content: Text(message),
      duration: duration ?? const Duration(seconds: 4),
      action: action,
      blurIntensity: blurIntensity,
      tintColor: tintColor,
      edgeShineIntensity: edgeShineIntensity,
      edgeShine: edgeShine,
    ),
  );
}
