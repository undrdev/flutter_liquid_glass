import 'dart:math' as math;

import 'package:flutter/material.dart';

class LiquidBackground extends StatefulWidget {
  const LiquidBackground({super.key, required this.child});

  final Widget child;

  @override
  State<LiquidBackground> createState() => _LiquidBackgroundState();
}

class _LiquidBackgroundState extends State<LiquidBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _LiquidBackgroundPainter(progress: _controller.value),
          child: widget.child,
        );
      },
    );
  }
}

class _LiquidBackgroundPainter extends CustomPainter {
  _LiquidBackgroundPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF6D6BFF),
        const Color(0xFF7F8BFF),
        const Color(0xFFFF7EC7),
      ],
    );

    final rect = Offset.zero & size;
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    final shapes = _buildShapes(size);
    for (final shape in shapes) {
      shape.paint(canvas, progress);
    }
  }

  List<_LiquidShape> _buildShapes(Size size) {
    final width = size.width;
    final height = size.height;
    return [
      _LiquidShape(
        center: Offset(width * 0.2, height * 0.25),
        radius: width * 0.25,
        color: Colors.white.withOpacity(0.12),
        dx: 40,
        dy: 30,
        speed: 0.7,
      ),
      _LiquidShape(
        center: Offset(width * 0.75, height * 0.3),
        radius: width * 0.18,
        color: Colors.white.withOpacity(0.1),
        dx: -30,
        dy: 35,
        speed: 0.5,
      ),
      _LiquidShape(
        center: Offset(width * 0.6, height * 0.7),
        radius: width * 0.32,
        color: Colors.white.withOpacity(0.08),
        dx: 45,
        dy: -20,
        speed: 0.6,
      ),
      _LiquidShape(
        center: Offset(width * 0.25, height * 0.75),
        radius: width * 0.2,
        color: Colors.white.withOpacity(0.07),
        dx: -35,
        dy: -25,
        speed: 0.48,
      ),
    ];
  }

  @override
  bool shouldRepaint(covariant _LiquidBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _LiquidShape {
  _LiquidShape({
    required this.center,
    required this.radius,
    required this.color,
    required this.dx,
    required this.dy,
    required this.speed,
  });

  final Offset center;
  final double radius;
  final Color color;
  final double dx;
  final double dy;
  final double speed;

  void paint(Canvas canvas, double t) {
    final angle = t * 2 * math.pi * speed;
    final offset = Offset(dx * math.sin(angle), dy * math.cos(angle));
    final paint = Paint()..color = color;
    canvas.drawCircle(center + offset, radius, paint);
  }
}
