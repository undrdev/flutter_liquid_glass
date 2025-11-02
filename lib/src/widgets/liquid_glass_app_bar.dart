import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/liquid_glass_container.dart';

/// An AppBar with liquid glass effect.
///
/// Provides a translucent glassmorphic app bar with blur and edge shine effects.
/// Ideal for creating modern, elegant navigation bars.
///
/// Example:
/// ```dart
/// Scaffold(
///   appBar: LiquidGlassAppBar(
///     title: Text('My App'),
///   ),
///   body: MyBody(),
/// )
/// ```
class LiquidGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// A list of widgets to display before the title.
  final List<Widget>? leading;

  /// A list of widgets to display after the title.
  final List<Widget>? actions;

  /// The blur intensity. Defaults to 20.0.
  final double blurIntensity;

  /// The tint color. Defaults to white with 10% opacity.
  final Color tintColor;

  /// The edge shine intensity. Defaults to 0.3.
  final double edgeShineIntensity;

  /// Background color for the app bar.
  final Color? backgroundColor;

  /// Elevation of the app bar.
  final double? elevation;

  /// Center title in the app bar.
  final bool centerTitle;

  /// Automatically imply leading.
  final bool automaticallyImplyLeading;

  /// Flexible space widget.
  final PreferredSizeWidget? flexibleSpace;

  /// Bottom widget.
  final PreferredSizeWidget? bottom;

  /// Custom toolbar height.
  final double? toolbarHeight;

  /// Leading widget width.
  final double? leadingWidth;

  /// Whether to show a shadow below the app bar.
  final bool showShadow;

  @override
  final Size preferredSize;

  LiquidGlassAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.blurIntensity = 20.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.1),
    this.edgeShineIntensity = 0.3,
    this.backgroundColor,
    this.elevation,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.leadingWidth,
    this.showShadow = true,
  }) : preferredSize = _calculatePreferredSize(toolbarHeight, bottom);

  static Size _calculatePreferredSize(
      double? toolbarHeight, PreferredSizeWidget? bottom) {
    final height =
        (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0);
    return Size(double.infinity, height);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LiquidGlassContainer(
        blurIntensity: blurIntensity,
        tintColor: backgroundColor ?? tintColor,
        edgeShineIntensity: edgeShineIntensity,
        borderWidth: 0,
        edgeShine: false,
        child: PreferredSize(
          preferredSize: preferredSize,
          child: Container(
            decoration: showShadow
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                : null,
            child: AppBar(
              title: title,
              leading: leading?.isNotEmpty == true ? leading!.first : null,
              actions: actions,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: centerTitle,
              automaticallyImplyLeading: automaticallyImplyLeading,
              flexibleSpace: flexibleSpace,
              bottom: bottom,
              toolbarHeight: toolbarHeight,
              leadingWidth: leadingWidth,
            ),
          ),
        ),
      ),
    );
  }
}
