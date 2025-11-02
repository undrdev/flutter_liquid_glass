import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A custom painter that creates an edge shine effect simulating light reflection.
///
/// This painter applies a gradient along the edges of a rounded rectangle to
/// simulate the way light reflects off glass surfaces, creating the characteristic
/// liquid glass appearance with highlighted edges.
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

  const EdgeShinePainter({
    required this.borderRadius,
    this.intensity = 0.3,
    this.shineColor = Colors.white,
    this.shineWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0.0) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = shineWidth
      ..blendMode = BlendMode.plus;

    // Calculate RRect for rounded rectangle
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = borderRadius.toRRect(rect);

    // Create gradient for edge shine
    // Simulate light from top-left
    final gradient = ui.Gradient.linear(
      const Offset(0, 0), // Light source at top-left
      Offset(size.width, size.height), // Darkest at bottom-right
      [
        shineColor.withOpacity(intensity * 0.6), // Bright near top-left
        shineColor.withOpacity(intensity * 0.3),
        shineColor.withOpacity(intensity * 0.1),
        shineColor.withOpacity(intensity * 0.05),
        shineColor.withOpacity(0),
      ],
      [0.0, 0.2, 0.4, 0.7, 1.0],
    );

    paint.shader = gradient;

    // Draw the rounded rectangle with gradient stroke
    canvas.drawRRect(rrect, paint);

    // Additional highlight on the top-left corner
    final highlightPaint = Paint()
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.plus;

    // Draw subtle highlights at the corners
    _drawCornerHighlight(canvas, highlightPaint, 0, 0, size, 'topLeft');
    _drawCornerHighlight(
        canvas, highlightPaint, size.width, 0, size, 'topRight');
    _drawCornerHighlight(
        canvas, highlightPaint, 0, size.height, size, 'bottomLeft');
    _drawCornerHighlight(
        canvas, highlightPaint, size.width, size.height, size, 'bottomRight');
  }

  void _drawCornerHighlight(
    Canvas canvas,
    Paint paint,
    double x,
    double y,
    Size size,
    String corner,
  ) {
    final radius = _getCornerRadius(corner);
    if (radius == 0) return;

    // Determine highlight position and intensity based on corner
    final isTopLeft = corner == 'topLeft';
    final opacity = isTopLeft
        ? intensity * 0.4
        : (corner == 'topRight' || corner == 'bottomLeft')
            ? intensity * 0.15
            : intensity * 0.05;

    paint.color = shineColor.withOpacity(opacity);

    // Draw a small radial gradient at the corner
    canvas.drawCircle(
      Offset(x, y),
      radius / 3,
      paint,
    );
  }

  double _getCornerRadius(String corner) {
    switch (corner) {
      case 'topLeft':
        return borderRadius.topLeft.x;
      case 'topRight':
        return borderRadius.topRight.x;
      case 'bottomLeft':
        return borderRadius.bottomLeft.x;
      case 'bottomRight':
        return borderRadius.bottomRight.x;
      default:
        return 0;
    }
  }

  @override
  bool shouldRepaint(EdgeShinePainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.intensity != intensity ||
        oldDelegate.shineColor != shineColor ||
        oldDelegate.shineWidth != shineWidth;
  }
}
