import 'dart:async';
import 'package:flutter/material.dart';

/// Controller for managing liquid glass animations with spring physics.
///
/// This controller provides pre-configured animation curves and spring physics
/// for natural, fluid motion in liquid glass widgets.
class LiquidGlassAnimationController {
  final AnimationController _controller;
  final TickerProvider _vsync;

  /// Creates a new animation controller with the given duration and vsync.
  LiquidGlassAnimationController({
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 300),
  })  : _controller = AnimationController(
          duration: duration,
          vsync: vsync,
        ),
        _vsync = vsync;

  /// Returns the underlying AnimationController.
  AnimationController get controller => _controller;

  /// Returns the TickerProvider used by this controller.
  TickerProvider get vsync => _vsync;

  /// Creates a spring animation description for natural, bouncy motion.
  ///
  /// Common use cases: button press, card tap, sheet opening.
  static const SpringDescription lightSpring = SpringDescription(
    mass: 1.0,
    stiffness: 300.0,
    damping: 25.0,
  );

  /// Creates a medium spring animation description for moderate motion.
  ///
  /// Common use cases: panel resize, drawer transitions.
  static const SpringDescription mediumSpring = SpringDescription(
    mass: 1.0,
    stiffness: 250.0,
    damping: 30.0,
  );

  /// Creates a heavy spring animation description for slower, more deliberate motion.
  ///
  /// Common use cases: modal presentations, large layout changes.
  static const SpringDescription heavySpring = SpringDescription(
    mass: 1.0,
    stiffness: 200.0,
    damping: 35.0,
  );

  /// Creates a scale animation for touch interactions.
  ///
  /// Returns an animation that scales from [start] to [end].
  /// Typical usage: scale from 1.0 to 0.95 on press.
  Animation<double> createScaleAnimation({
    double start = 1.0,
    double end = 0.95,
    Curve curve = Curves.easeOut,
  }) {
    return Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: curve,
      ),
    );
  }

  /// Creates an opacity animation for fade effects.
  ///
  /// Returns an animation that fades from [start] to [end] opacity.
  Animation<double> createOpacityAnimation({
    double start = 0.0,
    double end = 1.0,
  }) {
    return Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  /// Creates a ripple effect animation.
  ///
  /// The ripple expands from 0.0 to [maxScale] over [duration].
  /// Returns a subscription that can be cancelled.
  StreamSubscription<void> createRippleAnimation({
    required void Function(double) onUpdate,
    double maxScale = 1.5,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    final controller = AnimationController(
      duration: duration,
      vsync: _vsync,
    );

    final animation = Tween<double>(begin: 0.0, end: maxScale).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );

    animation.addListener(() {
      onUpdate(animation.value);
    });

    controller.forward().then((_) {
      controller.dispose();
    });

    return Stream.fromFuture(controller.forward())
        .listen((_) {}, onDone: () {});
  }

  /// Disposes of the controller and all animations.
  void dispose() {
    _controller.dispose();
  }
}

/// Pre-defined curves for liquid glass animations.
class LiquidGlassCurves {
  /// Smooth, gentle ease for subtle transitions.
  static const Curve gentleEase = Cubic(0.25, 0.1, 0.25, 1.0);

  /// Quick, snappy ease for responsive interactions.
  static const Curve snappyEase = Cubic(0.4, 0.0, 0.2, 1.0);

  /// Slow, elegant ease for emphasis.
  static const Curve elegantEase = Cubic(0.4, 0.0, 0.6, 1.0);

  /// Bouncy elastic for fun interactions.
  static const Curve elastic = Curves.elasticOut;

  /// Smooth bounce for natural motion.
  static const Curve bounce = Curves.bounceOut;
}
