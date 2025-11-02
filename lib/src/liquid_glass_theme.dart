import 'dart:ui';
import 'package:flutter/material.dart';

/// A theme extension for Liquid Glass styling.
///
/// This extension allows you to define global liquid glass styling that can be
/// accessed throughout your app using `Theme.of(context).extension<LiquidGlassTheme>()`.
///
/// Example:
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       LiquidGlassTheme(
///         blurIntensity: 15.0,
///         tintColor: Colors.white,
///         edgeShineIntensity: 0.3,
///       ),
///     ],
///   ),
/// )
/// ```
class LiquidGlassTheme extends ThemeExtension<LiquidGlassTheme> {
  /// The default blur intensity.
  final double blurIntensity;

  /// The default tint color.
  final Color tintColor;

  /// The default border color.
  final Color borderColor;

  /// The default edge shine intensity.
  final double edgeShineIntensity;

  /// The default edge shine color.
  final Color edgeShineColor;

  /// The default border radius.
  final BorderRadius borderRadius;

  /// The default refraction strength for the shader lens.
  final double refractionStrength;

  /// The default magnification amount for the shader lens.
  final double magnification;

  const LiquidGlassTheme({
    this.blurIntensity = 15.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.1),
    this.borderColor = const Color.fromRGBO(255, 255, 255, 0.3),
    this.edgeShineIntensity = 0.3,
    this.edgeShineColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.refractionStrength = 0.03,
    this.magnification = 1.018,
  });

  @override
  LiquidGlassTheme copyWith({
    double? blurIntensity,
    Color? tintColor,
    Color? borderColor,
    double? edgeShineIntensity,
    Color? edgeShineColor,
    BorderRadius? borderRadius,
    double? refractionStrength,
    double? magnification,
  }) {
    return LiquidGlassTheme(
      blurIntensity: blurIntensity ?? this.blurIntensity,
      tintColor: tintColor ?? this.tintColor,
      borderColor: borderColor ?? this.borderColor,
      edgeShineIntensity: edgeShineIntensity ?? this.edgeShineIntensity,
      edgeShineColor: edgeShineColor ?? this.edgeShineColor,
      borderRadius: borderRadius ?? this.borderRadius,
      refractionStrength: refractionStrength ?? this.refractionStrength,
      magnification: magnification ?? this.magnification,
    );
  }

  @override
  LiquidGlassTheme lerp(
    ThemeExtension<LiquidGlassTheme>? other,
    double t,
  ) {
    if (other is! LiquidGlassTheme) {
      return this;
    }

    return LiquidGlassTheme(
      blurIntensity: lerpDouble(blurIntensity, other.blurIntensity, t) ?? 15.0,
      tintColor: Color.lerp(tintColor, other.tintColor, t) ??
          const Color.fromRGBO(255, 255, 255, 0.1),
      borderColor: Color.lerp(borderColor, other.borderColor, t) ??
          const Color.fromRGBO(255, 255, 255, 0.3),
      edgeShineIntensity:
          lerpDouble(edgeShineIntensity, other.edgeShineIntensity, t) ?? 0.3,
      edgeShineColor:
          Color.lerp(edgeShineColor, other.edgeShineColor, t) ?? Colors.white,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          const BorderRadius.all(Radius.circular(20)),
      refractionStrength:
          lerpDouble(refractionStrength, other.refractionStrength, t) ?? 0.03,
      magnification: lerpDouble(magnification, other.magnification, t) ?? 1.018,
    );
  }
}

/// Extension to easily access LiquidGlassTheme from BuildContext.
extension LiquidGlassThemeExtension on BuildContext {
  /// Returns the LiquidGlassTheme for this context.
  LiquidGlassTheme? get liquidGlassTheme =>
      Theme.of(this).extension<LiquidGlassTheme>();
}
