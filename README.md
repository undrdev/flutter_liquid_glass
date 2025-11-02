# Flutter Liquid Glass

A Flutter package implementing Apple's Liquid Glass design system with beautiful glassmorphic effects, dynamic edge shine, physics-based animations, and touch-responsive interactions.

[![pub package](https://img.shields.io/pub/v/flutter_liquid_glass.svg)](https://pub.dev/packages/flutter_liquid_glass)

## Features

✨ **Glassmorphic Effects**
- Backdrop blur with configurable intensity
- Background tint with opacity control
- Border gradient support
- Dynamic edge shine simulation

🎨 **High-Level Widgets**
- `LiquidGlassCard` - Beautiful content cards
- `LiquidGlassButton` - Interactive buttons with touch feedback
- `LiquidGlassSheet` - Bottom sheets and modals
- `LiquidGlassAppBar` - Translucent app bar
- `LiquidGlassNavigationBar` - Bottom navigation with blur
- `LiquidGlassSnackBar` - Floating snackbar with animations

🎭 **Animations**
- Physics-based spring animations
- Touch ripple effects
- Smooth resize transitions
- Hover/press state animations

🌍 **Platform Support**
- iOS, Android, Web, macOS, Windows, Linux
- Platform-adaptive behavior
- Accessibility support (reduce motion, contrast)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_liquid_glass: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Getting Started

Liquid glass refraction relies on a shader-backed capture of the scene. Wrap the portion of your app that should allow glass refraction with `LiquidGlassScope`:

```dart
void main() {
  runApp(
    MaterialApp(
      home: LiquidGlassScope(
        child: MyHomePage(),
      ),
    ),
  );
}
```

All `LiquidGlass*` widgets automatically fall back to the blur-only implementation if the scope is absent, but wrapping with `LiquidGlassScope` enables the fluid, water-like distortion inspired by Apple.

Check out the [Quick Start Guide](QUICKSTART.md) to get up and running in 5 minutes! For detailed documentation, see the sections below.

### Quick Start

```dart
import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';

// Basic glass card
LiquidGlassCard(
  child: Text('Hello, Liquid Glass!'),
)

// Glass button with touch feedback
LiquidGlassButton(
  onPressed: () {},
  child: Text('Tap Me'),
)

// Glass snackbar
ScaffoldMessenger.of(context).showSnackBar(
  LiquidGlassSnackBar(
    content: Text('Glass effect snackbar!'),
  ),
)
```

> Tip: Place these widgets inside a `LiquidGlassScope` to enable the refractive shader lens.

### Custom Configuration

```dart
LiquidGlassContainer(
  blurIntensity: 20.0,
  tintColor: Colors.white.withOpacity(0.1),
  borderRadius: BorderRadius.circular(20),
  borderGradient: LinearGradient(
    colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.0)],
  ),
  edgeShine: true,
  edgeShineIntensity: 0.5,
  child: YourWidget(),
)
```

### Theme Integration

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      LiquidGlassTheme(
        blurIntensity: 15.0,
        tintColor: Colors.white,
        edgeShineIntensity: 0.3,
      ),
    ],
  ),
  home: MyHomePage(),
)
```

## Example

See the [example](example) directory for a complete demo application showcasing all features.

## Documentation

For more details and API documentation, visit:
- [API Documentation](https://pub.dev/documentation/flutter_liquid_glass/latest/)
- [Example App](example)

## References

Based on [Apple Liquid Glass documentation](https://developer.apple.com/documentation/technologyoverviews/liquid-glass) and [Liquid Glass design principles](https://liquidglassui.xyz/).

## Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests to our [repository](https://github.com/undrdev/flutter_liquid_glass).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.