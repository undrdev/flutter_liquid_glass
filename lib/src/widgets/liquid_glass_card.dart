import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/liquid_glass_container.dart';

/// A card widget with liquid glass effect and optional touch animations.
///
/// This is a high-level widget that combines [LiquidGlassContainer] with
/// optional touch interactions. Ideal for displaying content cards with
/// beautiful glassmorphic styling.
///
/// Example:
/// ```dart
/// LiquidGlassCard(
///   onTap: () => print('Tapped!'),
///   child: Text('Hello, Glass Card!'),
/// )
/// ```
class LiquidGlassCard extends StatefulWidget {
  /// The content to display inside the card.
  final Widget child;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  /// Optional callback when the card is pressed (with animation).
  final VoidCallback? onPressed;

  /// Whether to enable touch animations. Defaults to true.
  final bool enableAnimations;

  /// The blur intensity. Defaults to 15.0.
  final double blurIntensity;

  /// The tint color. Defaults to white with 10% opacity.
  final Color tintColor;

  /// The border radius. Defaults to 20.
  final BorderRadius borderRadius;

  /// The edge shine intensity. Defaults to 0.3.
  final double edgeShineIntensity;

  /// Padding inside the card.
  final EdgeInsetsGeometry? padding;

  /// Margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Optional width for the card.
  final double? width;

  /// Optional height for the card.
  final double? height;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.onPressed,
    this.enableAnimations = true,
    this.blurIntensity = 15.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.1),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.edgeShineIntensity = 0.3,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  State<LiquidGlassCard> createState() => _LiquidGlassCardState();
}

class _LiquidGlassCardState extends State<LiquidGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
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
    if (!widget.enableAnimations) return;
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enableAnimations) return;
    _controller.reverse().then((_) {
      widget.onPressed?.call();
      widget.onTap?.call();
    });
  }

  void _handleTapCancel() {
    if (!widget.enableAnimations) return;
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = LiquidGlassContainer(
      blurIntensity: widget.blurIntensity,
      tintColor: widget.tintColor,
      borderRadius: widget.borderRadius,
      edgeShineIntensity: widget.edgeShineIntensity,
      padding: widget.padding,
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      child: widget.child,
    );

    if (widget.enableAnimations) {
      card = GestureDetector(
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
          child: card,
        ),
      );
    } else if (widget.onTap != null) {
      card = GestureDetector(
        onTap: widget.onTap,
        child: card,
      );
    }

    return card;
  }
}
