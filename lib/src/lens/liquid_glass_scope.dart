import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class LiquidGlassScope extends StatefulWidget {
  const LiquidGlassScope({super.key, required this.child, this.captureScale = 0.6, this.captureFps = 30});

  final Widget child;
  final double captureScale;
  final double captureFps;

  static LiquidGlassScopeController? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_LiquidGlassScopeInherited>()?.controller;
  }

  @override
  State<LiquidGlassScope> createState() => _LiquidGlassScopeState();
}

class _LiquidGlassScopeState extends State<LiquidGlassScope> with SingleTickerProviderStateMixin {
  final GlobalKey _boundaryKey = GlobalKey();
  late final LiquidGlassScopeController _controller;
  late final Ticker _ticker;
  bool _pendingCapture = false;
  bool _capturing = false;
  double _lastCaptureTime = 0;
  ui.Image? _lastImage;
  ui.FragmentProgram? _program;

  @override
  void initState() {
    super.initState();
    _controller = LiquidGlassScopeController._(boundaryKey: _boundaryKey);
    _loadShader();
    _ticker = createTicker(_onTick)..start();
  }

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset('assets/shaders/liquid_glass.frag');
    if (!mounted) return;
    setState(() {
      _program = program;
      _controller._setProgram(program);
    });
    _scheduleCapture();
  }

  void _onTick(Duration elapsed) {
    if (!mounted || _program == null) return;
    final seconds = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    final frameInterval = 1.0 / widget.captureFps;
    if (seconds - _lastCaptureTime >= frameInterval) {
      _lastCaptureTime = seconds;
      _scheduleCapture();
    }
  }

  void _scheduleCapture() {
    if (_pendingCapture || _capturing) return;
    _pendingCapture = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      _pendingCapture = false;
      await _capture();
    });
  }

  Future<void> _capture() async {
    final boundary = _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null || boundary.debugNeedsPaint) {
      _scheduleCapture();
      return;
    }
    _capturing = true;
    try {
      final pixelRatio = (MediaQuery.maybeOf(context)?.devicePixelRatio ?? ui.window.devicePixelRatio) * widget.captureScale;
      final image = await boundary.toImage(pixelRatio: pixelRatio);
      _lastImage?.dispose();
      _lastImage = image;
      _controller._updateFrame(LiquidGlassFrame(
        image: image,
        imageSize: Size(image.width.toDouble(), image.height.toDouble()),
        time: DateTime.now().millisecondsSinceEpoch / 1000.0,
      ));
    } catch (_) {
      // Ignore capture errors, try again next frame
    } finally {
      _capturing = false;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _lastImage?.dispose();
    _controller._dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LiquidGlassScopeInherited(
      controller: _controller,
      child: RepaintBoundary(
        key: _boundaryKey,
        child: widget.child,
      ),
    );
  }
}

class _LiquidGlassScopeInherited extends InheritedWidget {
  const _LiquidGlassScopeInherited({required super.child, required this.controller});

  final LiquidGlassScopeController controller;

  @override
  bool updateShouldNotify(covariant _LiquidGlassScopeInherited oldWidget) => controller != oldWidget.controller;
}

class LiquidGlassFrame {
  LiquidGlassFrame({required this.image, required this.imageSize, required this.time});

  final ui.Image image;
  final Size imageSize;
  final double time;
}

class LiquidGlassScopeController {
  LiquidGlassScopeController._({required GlobalKey boundaryKey}) : _boundaryKey = boundaryKey;

  final GlobalKey _boundaryKey;
  final ValueNotifier<LiquidGlassFrame?> _frameNotifier = ValueNotifier<LiquidGlassFrame?>(null);
  ui.FragmentProgram? _program;

  ValueListenable<LiquidGlassFrame?> get frameListenable => _frameNotifier;
  ui.FragmentProgram? get program => _program;
  RenderBox? get boundaryBox => _boundaryKey.currentContext?.findRenderObject() as RenderBox?;

  void _setProgram(ui.FragmentProgram program) {
    _program = program;
    _frameNotifier.value = _frameNotifier.value;
  }

  void _updateFrame(LiquidGlassFrame frame) {
    final previous = _frameNotifier.value;
    if (previous != null && previous.image != frame.image) {
      previous.image.dispose();
    }
    _frameNotifier.value = frame;
  }

  void _dispose() {
    final current = _frameNotifier.value;
    current?.image.dispose();
    _frameNotifier.dispose();
  }
}
