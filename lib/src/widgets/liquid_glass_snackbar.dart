import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/liquid_glass_container.dart';

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
  LiquidGlassSnackBar({
    super.key,
    required Widget content,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    EdgeInsetsGeometry margin = const EdgeInsets.all(12),
    double blurIntensity = 22.0,
    Color tintColor = const Color.fromRGBO(255, 255, 255, 0.16),
    double edgeShineIntensity = 0.45,
    bool edgeShine = true,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(18)),
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    VoidCallback? onVisible,
    DismissDirection dismissDirection = DismissDirection.down,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) : super(
          content: _GlassSnackBarContent(
            content: content,
            action: action,
            blurIntensity: blurIntensity,
            tintColor: tintColor,
            edgeShineIntensity: edgeShineIntensity,
            edgeShine: edgeShine,
            borderRadius: borderRadius,
            padding: padding,
          ),
          duration: duration,
          margin: margin,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: behavior,
          dismissDirection: dismissDirection,
          onVisible: onVisible,
        );
}

class _GlassSnackBarContent extends StatelessWidget {
  final Widget content;
  final SnackBarAction? action;
  final double blurIntensity;
  final Color tintColor;
  final double edgeShineIntensity;
  final bool edgeShine;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  const _GlassSnackBarContent({
    required this.content,
    required this.action,
    required this.blurIntensity,
    required this.tintColor,
    required this.edgeShineIntensity,
    required this.edgeShine,
    required this.borderRadius,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.snackBarTheme.contentTextStyle?.color ??
        theme.colorScheme.onSurface;

    Widget actionWidget = const SizedBox.shrink();
    if (action != null) {
      actionWidget = Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SnackBarAction(
          label: action!.label,
          onPressed: action!.onPressed,
          textColor: action!.textColor,
          disabledTextColor: action!.disabledTextColor,
        ),
      );
    }

    return LiquidGlassContainer(
      blurIntensity: blurIntensity,
      tintColor: tintColor,
      edgeShineIntensity: edgeShineIntensity,
      edgeShine: edgeShine,
      borderRadius: borderRadius,
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              child: content,
            ),
          ),
          if (action != null) actionWidget,
        ],
      ),
    );
  }
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
