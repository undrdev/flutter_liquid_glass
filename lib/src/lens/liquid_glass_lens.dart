import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'liquid_glass_scope.dart';

class LiquidGlassLens extends StatefulWidget {
  const LiquidGlassLens({
    super.key,
    required this.borderRadius,
    required this.refraction,
    required this.magnification,
  });

  final BorderRadius borderRadius;
  final double refraction;
  final double magnification;

  @override
  State<LiquidGlassLens> createState() => _LiquidGlassLensState();
}

class _LiquidGlassLensState extends State<LiquidGlassLens> {
  Rect? _regionUv;
  Size? _lensSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateRegion());
  }

  @override
  void didUpdateWidget(covariant LiquidGlassLens oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.borderRadius != widget.borderRadius) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _updateRegion());
    }
  }

  void _updateRegion() {
    final scope = LiquidGlassScope.maybeOf(context);
    if (scope == null) return;
    final boundary = scope.boundaryBox;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (boundary == null || renderBox == null || !renderBox.hasSize) {
      return;
    }
    final topLeft = renderBox.localToGlobal(Offset.zero, ancestor: boundary);
    final size = renderBox.size;
    final imageSize = scope.frameListenable.value?.imageSize;
    if (imageSize == null || imageSize.width == 0 || imageSize.height == 0) {
      return;
    }
    final rect = Rect.fromLTWH(topLeft.dx, topLeft.dy, size.width, size.height);
    final normalized = Rect.fromLTWH(
      rect.left / imageSize.width,
      rect.top / imageSize.height,
      rect.width / imageSize.width,
      rect.height / imageSize.height,
    );
    if (_regionUv != normalized || _lensSize != size) {
      setState(() {
        _regionUv = normalized;
        _lensSize = size;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scope = LiquidGlassScope.maybeOf(context);
    if (scope == null || scope.program == null) {
      return const SizedBox.shrink();
    }

    return ValueListenableBuilder<LiquidGlassFrame?>(
      valueListenable: scope.frameListenable,
      builder: (context, frame, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _updateRegion());
        if (frame == null || _regionUv == null || _lensSize == null) {
          return const SizedBox.shrink();
        }

        return CustomPaint(
          painter: _LiquidGlassLensPainter(
            program: scope.program!,
            frame: frame,
            regionUv: _regionUv!,
            lensSize: _lensSize!,
            borderRadius: widget.borderRadius,
            refraction: widget.refraction,
            magnification: widget.magnification,
          ),
        );
      },
    );
  }
}

class _LiquidGlassLensPainter extends CustomPainter {
  _LiquidGlassLensPainter({
    required this.program,
    required this.frame,
    required this.regionUv,
    required this.lensSize,
    required this.borderRadius,
    required this.refraction,
    required this.magnification,
  });

  final ui.FragmentProgram program;
  final LiquidGlassFrame frame;
  final Rect regionUv;
  final Size lensSize;
  final BorderRadius borderRadius;
  final double refraction;
  final double magnification;

  @override
  void paint(Canvas canvas, Size size) {
    final shader = program.fragmentShader();
    shader.setImageSampler(0, frame.image);
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, regionUv.left);
    shader.setFloat(3, regionUv.top);
    shader.setFloat(4, regionUv.width);
    shader.setFloat(5, regionUv.height);
    shader.setFloat(6, frame.time);
    shader.setFloat(7, refraction);
    shader.setFloat(8, magnification);

    final paint = Paint()..shader = shader;
    final rrect = borderRadius.toRRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRRect(rrect, paint);
    shader.dispose();
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassLensPainter oldDelegate) {
    return !identical(oldDelegate.frame, frame) ||
        oldDelegate.regionUv != regionUv ||
        oldDelegate.refraction != refraction ||
        oldDelegate.magnification != magnification ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.lensSize != lensSize;
  }
}
