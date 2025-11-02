import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/liquid_glass_container.dart';

/// A navigation bar with liquid glass effect.
///
/// Provides a translucent glassmorphic bottom navigation bar with blur and
/// edge shine effects. Ideal for creating modern, elegant navigation.
///
/// Example:
/// ```dart
/// Scaffold(
///   bottomNavigationBar: LiquidGlassNavigationBar(
///     currentIndex: 0,
///     items: [
///       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///       BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
///     ],
///     onTap: (index) {},
///   ),
/// )
/// ```
class LiquidGlassNavigationBar extends StatelessWidget {
  /// The current selected index.
  final int currentIndex;

  /// Callback when an item is tapped.
  final ValueChanged<int> onTap;

  /// The list of navigation items.
  final List<BottomNavigationBarItem> items;

  /// The blur intensity. Defaults to 20.0.
  final double blurIntensity;

  /// The tint color. Defaults to white with 15% opacity.
  final Color tintColor;

  /// The edge shine intensity. Defaults to 0.3.
  final double edgeShineIntensity;

  /// Selected item color.
  final Color? selectedItemColor;

  /// Unselected item color.
  final Color? unselectedItemColor;

  /// Selected font size.
  final double? selectedFontSize;

  /// Unselected font size.
  final double? unselectedFontSize;

  /// Show labels.
  final bool showSelectedLabels;

  final bool showUnselectedLabels;

  /// Icon size.
  final double iconSize;

  /// Whether to show a shadow above the navigation bar.
  final bool showShadow;

  /// Background color.
  final Color? backgroundColor;

  const LiquidGlassNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.blurIntensity = 20.0,
    this.tintColor = const Color.fromRGBO(255, 255, 255, 0.15),
    this.edgeShineIntensity = 0.3,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedFontSize,
    this.unselectedFontSize,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = false,
    this.iconSize = 24.0,
    this.showShadow = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LiquidGlassContainer(
        blurIntensity: blurIntensity,
        tintColor: backgroundColor ?? tintColor,
        edgeShineIntensity: edgeShineIntensity,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        borderWidth: 0,
        edgeShine: false,
        child: Container(
          decoration: showShadow
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                )
              : null,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            items: items,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            selectedFontSize: selectedFontSize ?? 12,
            unselectedFontSize: unselectedFontSize ?? 12,
            showSelectedLabels: showSelectedLabels,
            showUnselectedLabels: showUnselectedLabels,
            iconSize: iconSize,
          ),
        ),
      ),
    );
  }
}
