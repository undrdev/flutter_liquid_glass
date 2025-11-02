# Quick Start Guide

Get started with Flutter Liquid Glass in 5 minutes!

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_liquid_glass: ^0.1.0
```

Then run:
```bash
flutter pub get
```

## Basic Usage

### 1. Import the Package

```dart
import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';
```

### 2. Add a Background

Liquid Glass works best with a colorful background. Add a gradient:

```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.deepPurple.shade300,
        Colors.blue.shade300,
        Colors.pink.shade300,
      ],
    ),
  ),
  child: YourContent(),
)
```

### 3. Create Glass Components

#### Glass Card

```dart
LiquidGlassCard(
  onTap: () => print('Tapped!'),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        Text(
          'Hello Glass!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Beautiful glassmorphic card',
          style: TextStyle(color: Colors.white70),
        ),
      ],
    ),
  ),
)
```

#### Glass Button

```dart
LiquidGlassButton(
  onPressed: () {
    print('Button pressed!');
  },
  child: Text(
    'Press Me',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  ),
)
```

#### Glass Snackbar

```dart
ScaffoldMessenger.of(context).showSnackBar(
  LiquidGlassSnackBar(
    content: Text('Hello from liquid glass!'),
  ),
)
```

## Customization

### Adjust Blur Intensity

```dart
LiquidGlassContainer(
  blurIntensity: 25.0, // Default: 15.0
  child: YourWidget(),
)
```

### Change Edge Shine

```dart
LiquidGlassContainer(
  edgeShineIntensity: 0.6, // Default: 0.3, Range: 0.0-1.0
  child: YourWidget(),
)
```

### Custom Colors

```dart
LiquidGlassContainer(
  tintColor: Colors.blue.withOpacity(0.15),
  borderColor: Colors.white.withOpacity(0.4),
  child: YourWidget(),
)
```

### Disable Edge Shine

```dart
LiquidGlassContainer(
  edgeShine: false,
  child: YourWidget(),
)
```

## Theme Integration

Set default styles globally:

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      LiquidGlassTheme(
        blurIntensity: 20.0,
        tintColor: Colors.white.withOpacity(0.1),
        edgeShineIntensity: 0.4,
      ),
    ],
  ),
  home: MyHomePage(),
)
```

Access theme values:

```dart
final theme = context.liquidGlassTheme;
final blur = theme?.blurIntensity ?? 15.0;
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          LiquidGlassTheme(
            blurIntensity: 15.0,
            tintColor: Colors.white.withOpacity(0.1),
          ),
        ],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade300,
              Colors.blue.shade300,
            ],
          ),
        ),
        child: Center(
          child: LiquidGlassCard(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                LiquidGlassSnackBar(
                  content: Text('Hello, Liquid Glass! ✨'),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tap Me!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Experience liquid glass',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Next Steps

- Run the [example app](example) to see all features
- Check the [full documentation](README.md)
- Browse the [API reference](https://pub.dev/documentation/flutter_liquid_glass/latest/)
- Customize animations with [LiquidGlassAnimationController](https://pub.dev/documentation/flutter_liquid_glass/latest/flutter_liquid_glass/LiquidGlassAnimationController-class.html)

## Tips

1. **Use colorful backgrounds** - Glass effects work best over gradients or images
2. **Adjust blur intensity** - Higher values (20-30) for stronger effects, lower (5-10) for subtle
3. **Layer components** - Stack glass elements for depth
4. **Accessibility** - The theme respects user preferences
5. **Performance** - Use `RepaintBoundary` for complex layouts

## Troubleshooting

**Glass effect not visible?**
- Ensure there's a colorful background behind the glass
- Check that `blurIntensity > 0`
- Verify `tintColor` opacity is set

**Animations not working?**
- Ensure `enableAnimations: true` (default)
- Check that tap/press callbacks are set

**Theme not applying?**
- Verify ThemeData extensions include LiquidGlassTheme
- Check theme is in the widget tree

## Resources

- [Package README](README.md)
- [Publishing Guide](PUBLISHING.md)
- [Example App](example)
- [Apple Liquid Glass](https://developer.apple.com/documentation/technologyoverviews/liquid-glass)

Happy coding! ✨

