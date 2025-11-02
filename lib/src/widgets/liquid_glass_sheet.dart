import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/liquid_glass_container.dart';

/// A bottom sheet with liquid glass effect and slide-in animation.
///
/// Provides a beautiful glassmorphic bottom sheet that slides up from the bottom
/// with blur and edge shine effects.
///
/// Example:
/// ```dart
/// showLiquidGlassSheet(
///   context: context,
///   builder: (context) => LiquidGlassSheet(
///     child: Text('Sheet content'),
///   ),
/// );
/// ```
class LiquidGlassSheet extends StatefulWidget {
  /// The content to display in the sheet.
  final Widget child;

  /// The blur intensity. Defaults to 20.0.
  final double blurIntensity;

  /// The tint color. Defaults to white with 15% opacity.
  final Color tintColor;

  /// The border radius of the top corners. Defaults to 20.
  final BorderRadius borderRadius;

  /// The edge shine intensity. Defaults to 0.3.
  final double edgeShineIntensity;

  /// The padding inside the sheet.
  final EdgeInsetsGeometry? padding;

  /// Optional header widget.
  final Widget? header;

  /// Optional footer widget.
  final Widget? footer;

  /// Whether to show a drag handle indicator.
  final bool showDragHandle;

  /// Color of the drag handle.
  final Color? dragHandleColor;

  const LiquidGlassSheet({
    super.key,
    required this.child,
    this.blurIntensity = 20.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.15),
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    this.edgeShineIntensity = 0.3,
    this.padding,
    this.header,
    this.footer,
    this.showDragHandle = true,
    this.dragHandleColor,
  });

  @override
  State<LiquidGlassSheet> createState() => _LiquidGlassSheetState();
}

class _LiquidGlassSheetState extends State<LiquidGlassSheet> {
  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      blurIntensity: widget.blurIntensity,
      tintColor: widget.tintColor,
      borderRadius: widget.borderRadius,
      edgeShineIntensity: widget.edgeShineIntensity,
      padding: widget.padding ?? const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showDragHandle) _buildDragHandle(),
          if (widget.header != null) widget.header!,
          Flexible(child: widget.child),
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: widget.dragHandleColor ?? Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

/// Shows a liquid glass bottom sheet.
///
/// Returns the value returned by the sheet when it's popped.
Future<T?> showLiquidGlassSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? barrierColor,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollControlled = false,
  String? barrierLabel,
  double blurIntensity = 20.0,
  Color tintColor = const Color.fromRGBO(255, 255, 255, 0.15),
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    barrierLabel: barrierLabel ??
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
  );
}
