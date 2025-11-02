/// Flutter Liquid Glass - A beautiful implementation of Apple's Liquid Glass design system.
///
/// This package provides glassmorphic effects with blur, edge shine, and physics-based animations.
///
/// Example:
/// ```dart
/// import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';
///
/// LiquidGlassCard(
///   child: Text('Hello, Liquid Glass!'),
/// )
/// ```
library flutter_liquid_glass;

// Core Components
export 'src/liquid_glass_container.dart';
export 'src/edge_shine_painter.dart';
export 'src/liquid_glass_animation_controller.dart';

// High-Level Widgets
export 'src/widgets/liquid_glass_card.dart';
export 'src/widgets/liquid_glass_button.dart';
export 'src/widgets/liquid_glass_sheet.dart';
export 'src/widgets/liquid_glass_app_bar.dart';
export 'src/widgets/liquid_glass_navigation_bar.dart';
export 'src/widgets/liquid_glass_snackbar.dart';

// Theme
export 'src/liquid_glass_theme.dart';

// Shader-based lens and scope
export 'src/lens/liquid_glass_scope.dart';
