import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/liquid_glass_container.dart';

/// A button widget with liquid glass effect and touch feedback animations.
///
/// Provides a beautiful glassmorphic button with animated press effects.
/// Supports both basic onPressed callback and more advanced gesture handling.
///
/// Example:
/// ```dart
/// LiquidGlassButton(
///   onPressed: () => print('Button pressed!'),
///   child: Text('Press Me'),
/// )
/// ```
class LiquidGlassButton extends StatefulWidget {
  /// The content to display inside the button.
  final Widget child;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button is enabled. Defaults to true.
  final bool enabled;

  /// Whether to show touch animations. Defaults to true.
  final bool enableAnimations;

  /// The blur intensity. Defaults to 15.0.
  final double blurIntensity;

  /// The tint color. Defaults to white with 10% opacity.
  final Color tintColor;

  /// The button's border radius. Defaults to 12.
  final BorderRadius borderRadius;

  /// The edge shine intensity. Defaults to 0.3.
  final double edgeShineIntensity;

  /// Padding inside the button.
  final EdgeInsetsGeometry? padding;

  /// Optional width for the button.
  final double? width;

  /// Optional height for the button.
  final double? height;

  /// Optional minimum width for the button.
  final double? minWidth;

  /// Optional minimum height for the button.
  final double? minHeight;

  /// The splash color for ripple effect.
  final Color? splashColor;

  /// The highlight color when pressed.
  final Color? highlightColor;

  const LiquidGlassButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.enableAnimations = true,
    this.blurIntensity = 15.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.1),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.edgeShineIntensity = 0.3,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.splashColor,
    this.highlightColor,
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled || !widget.enableAnimations) return;
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled || !widget.enableAnimations) return;
    setState(() => _isPressed = false);
    _controller.reverse().then((_) {
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    });
  }

  void _handleTapCancel() {
    if (!widget.enabled || !widget.enableAnimations) return;
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOpacity = widget.enabled ? 1.0 : 0.5;

    Widget button = Opacity(
      opacity: effectiveOpacity,
      child: LiquidGlassContainer(
        blurIntensity: widget.blurIntensity,
        tintColor: _isPressed && widget.enableAnimations
            ? widget.tintColor.withOpacity(0.15)
            : widget.tintColor,
        borderRadius: widget.borderRadius,
        edgeShineIntensity: widget.edgeShineIntensity,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        width: widget.width,
        height: widget.height,
        child: widget.child,
      ),
    );

    if (widget.enableAnimations) {
      button = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: button,
        ),
      );
    } else if (widget.onPressed != null) {
      button = GestureDetector(
        onTap: widget.enabled ? widget.onPressed : null,
        child: button,
      );
    }

    return button;
  }
}
