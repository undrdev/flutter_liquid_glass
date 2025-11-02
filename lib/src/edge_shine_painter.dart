import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A custom painter that creates an edge shine effect with bevel and specular highlights.
///
/// This painter applies gradients and highlights along the edges of a rounded rectangle to
/// simulate the way light reflects off glass surfaces, creating the characteristic
/// liquid glass appearance with highlighted edges and depth.
///
/// The light source is simulated from the top-left, with varying intensity
/// based on the angle of the edge relative to the light source.
class EdgeShinePainter extends CustomPainter {
  /// The border radius of the shape to paint.
  final BorderRadius borderRadius;

  /// The intensity of the edge shine effect. Range: 0.0 to 1.0.
  final double intensity;

  /// The color of the edge shine. Defaults to white.
  final Color shineColor;

  /// The width of the edge shine effect. Defaults to 2.0.
  final double shineWidth;

  /// Bevel depth - additional depth effect at the edge (0-1).
  final double bevelDepth;

  /// Bevel width - width of the bevel zone (0-1).
  final double bevelWidth;

  /// Enable specular highlights (animated light reflections).
  final bool specular;

  /// Specular animation offset for time-based animation.
  final double specularOffset;

  /// The amount of time elapsed for animation.
  final double time;

  const EdgeShinePainter({
    required this.borderRadius,
    this.intensity = 0.5,
    this.shineColor = Colors.white,
    this.shineWidth = 1.5,
    this.bevelDepth = 0.08,
    this.bevelWidth = 0.15,
    this.specular = true,
    this.specularOffset = 0.0,
    this.time = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0.0) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..blendMode = BlendMode.screen;

    // Calculate RRect for rounded rectangle
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = borderRadius.toRRect(rect);

    // Calculate bevel width in pixels
    final minDimension = size.width < size.height ? size.width : size.height;
    final bevelWidthPixels = minDimension * bevelWidth;

    // Draw outer bevel edge (brighter)
    _drawBevelEdge(canvas, rrect, size, bevelWidthPixels, paint);

    // Draw specular highlight on top edge if enabled
    if (specular) {
      _drawSpecularHighlight(canvas, rrect, size, bevelWidthPixels);
    }
  }

  void _drawBevelEdge(Canvas canvas, RRect rrect, Size size,
      double bevelWidthPixels, Paint paint) {
    // Create gradient for edge shine - top-left is brightest
    final gradient = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(size.width, size.height),
      [
        shineColor.withOpacity(intensity * 0.9 * bevelDepth), // Top-left
        shineColor.withOpacity(intensity * 0.4 * bevelDepth),
        shineColor.withOpacity(intensity * 0.15 * bevelDepth),
        shineColor.withOpacity(intensity * 0.05 * bevelDepth),
        shineColor.withOpacity(0),
      ],
      [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    paint
      ..shader = gradient
      ..strokeWidth = bevelWidthPixels * 2;

    // Draw subtle outer edge
    canvas.drawRRect(rrect, paint);

    // Draw additional bright edge on top and left
    _drawBrightEdges(canvas, rrect, size, bevelWidthPixels);
  }

  void _drawBrightEdges(
      Canvas canvas, RRect rrect, Size size, double bevelWidthPixels) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = bevelWidthPixels
      ..blendMode = BlendMode.screen;

    // Top edge - brightest
    paint.color = shineColor.withOpacity(intensity * 0.8);
    canvas.drawLine(
      Offset(rrect.left, rrect.top + bevelWidthPixels / 2),
      Offset(rrect.right, rrect.top + bevelWidthPixels / 2),
      paint,
    );

    // Left edge - bright
    paint.color = shineColor.withOpacity(intensity * 0.6);
    canvas.drawLine(
      Offset(rrect.left + bevelWidthPixels / 2, rrect.top),
      Offset(rrect.left + bevelWidthPixels / 2, rrect.bottom),
      paint,
    );

    // Top-left corner highlight
    if (rrect.tlRadius.x > 0) {
      _drawCornerHighlight(
          canvas, rrect.left, rrect.top, rrect.tlRadius.x, intensity * 0.6);
    }
  }

  void _drawSpecularHighlight(
      Canvas canvas, RRect rrect, Size size, double bevelWidthPixels) {
    if (intensity <= 0.3) return;

    // Animate specular highlight position based on time
    final animationOffset = (time * 0.5 + specularOffset).remainder(1.0);
    final highlightPosition = animationOffset * (size.width + size.height * 2);

    // Draw moving specular highlight
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.screen;

    // Calculate specular path (diagonal sweep across top-left area)
    if (highlightPosition < size.width) {
      // Top edge sweep
      final x = highlightPosition;
      paint.shader = ui.Gradient.radial(
        Offset(x, rrect.top),
        bevelWidthPixels * 2,
        [
          shineColor.withOpacity(intensity * 0.8),
          shineColor.withOpacity(0),
        ],
      );
    } else if (highlightPosition < size.width + size.height) {
      // Left edge sweep
      final y = highlightPosition - size.width;
      paint.shader = ui.Gradient.radial(
        Offset(rrect.left, y),
        bevelWidthPixels * 2,
        [
          shineColor.withOpacity(intensity * 0.8),
          shineColor.withOpacity(0),
        ],
      );
    }
  }

  void _drawCornerHighlight(
      Canvas canvas, double x, double y, double radius, double opacity) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.screen;

    paint.shader = ui.Gradient.radial(
      Offset(x, y),
      radius / 2,
      [
        shineColor.withOpacity(opacity),
        shineColor.withOpacity(opacity * 0.5),
        shineColor.withOpacity(0),
      ],
      [0.0, 0.5, 1.0],
    );

    canvas.drawCircle(
      Offset(x, y),
      radius / 2.5,
      paint,
    );
  }

  @override
  bool shouldRepaint(EdgeShinePainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.intensity != intensity ||
        oldDelegate.shineColor != shineColor ||
        oldDelegate.shineWidth != shineWidth ||
        oldDelegate.bevelDepth != bevelDepth ||
        oldDelegate.bevelWidth != bevelWidth ||
        oldDelegate.specular != specular ||
        oldDelegate.time != time;
  }
}
