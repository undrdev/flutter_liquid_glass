import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';

void main() {
  group('LiquidGlassContainer', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassContainer(
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with custom blur intensity',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassContainer(
              blurIntensity: 20.0,
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with custom tint color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassContainer(
              tintColor: Colors.blue.withOpacity(0.2),
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with edge shine disabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassContainer(
              edgeShine: false,
              child: const Text('Test'),
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });
  });

  group('LiquidGlassCard', () {
    testWidgets('renders card with child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassCard(
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('handles tap callback', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassCard(
              onTap: () {
                tapped = true;
              },
              child: const Text('Tappable Card'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tappable Card'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      expect(tapped, isTrue);
    });

    testWidgets('disables animations when requested',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassCard(
              enableAnimations: false,
              child: const Text('No Animation'),
            ),
          ),
        ),
      );

      expect(find.text('No Animation'), findsOneWidget);
    });
  });

  group('LiquidGlassButton', () {
    testWidgets('renders button with child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassButton(
              onPressed: () {},
              child: const Text('Button'),
            ),
          ),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
    });

    testWidgets('handles press callback', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassButton(
              onPressed: () {
                pressed = true;
              },
              child: const Text('Press Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Press Me'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      expect(pressed, isTrue);
    });

    testWidgets('disables button when enabled is false',
        (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassButton(
              enabled: false,
              onPressed: () {
                pressed = true;
              },
              child: const Text('Disabled'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled'));
      await tester.pump();

      expect(pressed, isFalse);
    });
  });

  group('LiquidGlassSheet', () {
    testWidgets('renders sheet with child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassSheet(
              child: const Text('Sheet Content'),
            ),
          ),
        ),
      );

      expect(find.text('Sheet Content'), findsOneWidget);
    });

    testWidgets('renders drag handle when enabled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassSheet(
              showDragHandle: true,
              child: const Text('Sheet'),
            ),
          ),
        ),
      );

      expect(find.text('Sheet'), findsOneWidget);
    });

    testWidgets('hides drag handle when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LiquidGlassSheet(
              showDragHandle: false,
              child: const Text('Sheet'),
            ),
          ),
        ),
      );

      expect(find.text('Sheet'), findsOneWidget);
    });
  });

  group('LiquidGlassSnackBar', () {
    testWidgets('renders snackbar with content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const LiquidGlassSnackBar(
                      content: Text('Snackbar'),
                    ),
                  );
                },
                child: const Text('Show'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Snackbar'), findsOneWidget);
    });
  });

  group('LiquidGlassTheme', () {
    testWidgets('extends theme correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              const LiquidGlassTheme(
                blurIntensity: 25.0,
                tintColor: Colors.red,
                edgeShineIntensity: 0.5,
              ),
            ],
          ),
          home: const Scaffold(
            body: Text('Test'),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('can be accessed via context extension',
        (WidgetTester tester) async {
      LiquidGlassTheme? theme;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            extensions: [
              const LiquidGlassTheme(
                blurIntensity: 20.0,
              ),
            ],
          ),
          home: Builder(
            builder: (context) {
              theme = context.liquidGlassTheme;
              return const Scaffold(
                body: Text('Test'),
              );
            },
          ),
        ),
      );

      expect(theme, isNotNull);
      expect(theme?.blurIntensity, 20.0);
    });

    testWidgets('lerps between themes correctly', (WidgetTester tester) async {
      const theme1 = LiquidGlassTheme(
        blurIntensity: 10.0,
        tintColor: Colors.red,
      );
      const theme2 = LiquidGlassTheme(
        blurIntensity: 30.0,
        tintColor: Colors.blue,
      );

      final lerped = theme1.lerp(theme2, 0.5);
      expect(lerped.blurIntensity, 20.0);
    });

    testWidgets('copyWith creates new theme with changes',
        (WidgetTester tester) async {
      const original = LiquidGlassTheme(
        blurIntensity: 15.0,
        tintColor: Colors.red,
      );

      final updated = original.copyWith(
        blurIntensity: 25.0,
      );

      expect(updated.blurIntensity, 25.0);
      expect(updated.tintColor, Colors.red);
    });
  });

  group('LiquidGlassCurves', () {
    test('provides predefined curves', () {
      expect(LiquidGlassCurves.gentleEase, isNotNull);
      expect(LiquidGlassCurves.snappyEase, isNotNull);
      expect(LiquidGlassCurves.elegantEase, isNotNull);
      expect(LiquidGlassCurves.elastic, isNotNull);
      expect(LiquidGlassCurves.bounce, isNotNull);
    });
  });
}
