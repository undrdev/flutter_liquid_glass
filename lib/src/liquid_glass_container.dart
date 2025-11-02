import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/edge_shine_painter.dart';

/// A container widget that provides a glassmorphic effect with blur, tint, and edge shine.
///
/// This is the core building block for all Liquid Glass widgets. It combines
/// backdrop blur, background tint, and optional edge shine effects to create
/// the characteristic liquid glass appearance based on Apple's design system.
///
/// Example:
/// ```dart
/// LiquidGlassContainer(
///   blurIntensity: 20.0,
///   tintColor: Colors.white.withOpacity(0.1),
///   borderRadius: BorderRadius.circular(20),
///   child: Text('Glass effect content'),
/// )
/// ```
class LiquidGlassContainer extends StatelessWidget {
  /// The child widget to display inside the container.
  final Widget child;

  /// The intensity of the blur effect. Defaults to 20.0.
  ///
  /// Higher values create a stronger blur effect. Recommended range: 5-30.
  final double blurIntensity;

  /// The color tint applied to the background. Defaults to white with 10% opacity.
  final Color tintColor;

  /// The color of the border. Defaults to white with 30% opacity.
  final Color? borderColor;

  /// The width of the border. Defaults to 1.0.
  final double borderWidth;

  /// Optional gradient for the border. If provided, overrides [borderColor].
  final Gradient? borderGradient;

  /// The border radius of the container. Defaults to circular radius of 20.
  final BorderRadius borderRadius;

  /// Whether to enable edge shine effect. Defaults to true.
  final bool edgeShine;

  /// The intensity of the edge shine effect. Defaults to 0.5.
  ///
  /// Range: 0.0 to 1.0. Higher values create more pronounced shine.
  final double edgeShineIntensity;

  /// Bevel depth - additional depth effect at the edge (0-1). Defaults to 0.08.
  final double bevelDepth;

  /// Bevel width - width of the bevel zone (0-1). Defaults to 0.15.
  final double bevelWidth;

  /// Enable specular highlights (animated light reflections). Defaults to true.
  final bool specular;

  /// Adds a soft drop-shadow under the pane. Defaults to true.
  final bool shadow;

  /// The padding inside the container.
  final EdgeInsetsGeometry? padding;

  /// The margin around the container.
  final EdgeInsetsGeometry? margin;

  /// Optional width constraint for the container.
  final double? width;

  /// Optional height constraint for the container.
  final double? height;

  /// Optional clip behavior for the container.
  final Clip clipBehavior;

  /// The alignment of the child widget.
  final AlignmentGeometry? alignment;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.blurIntensity = 20.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.1),
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderGradient,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.edgeShine = true,
    this.edgeShineIntensity = 0.5,
    this.bevelDepth = 0.08,
    this.bevelWidth = 0.15,
    this.specular = true,
    this.shadow = true,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.clipBehavior = Clip.antiAlias,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: _buildBorder(),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: clipBehavior,
        child: Stack(
          children: [
            // Glass effect layer
            ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurIntensity,
                  sigmaY: blurIntensity,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: tintColor,
                  ),
                ),
              ),
            ),

            // Edge shine effect
            if (edgeShine)
              Positioned.fill(
                child: CustomPaint(
                  painter: EdgeShinePainter(
                    borderRadius: borderRadius,
                    intensity: edgeShineIntensity,
                    bevelDepth: bevelDepth,
                    bevelWidth: bevelWidth,
                    specular: specular,
                    time: 0.0, // Static for now
                  ),
                ),
              ),

            // Content
            if (alignment != null)
              Align(
                alignment: alignment!,
                child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: child,
                ),
              )
            else
              Padding(
                padding: padding ?? EdgeInsets.zero,
                child: child,
              ),
          ],
        ),
      ),
    );

    return content;
  }

  Border? _buildBorder() {
    if (borderGradient != null) {
      // For gradient borders, we'll use a shader mask
      // This is handled in the custom paint
      return Border.fromBorderSide(
        BorderSide(
          color: Colors.transparent,
          width: borderWidth,
        ),
      );
    }

    return Border.fromBorderSide(
      BorderSide(
        color: borderColor ?? const Color.fromRGBO(255, 255, 255, 0.3),
        width: borderWidth,
      ),
    );
  }
}
