import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/flutter_liquid_glass.dart';

import 'backgrounds/liquid_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Liquid Glass Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        extensions: [
          LiquidGlassTheme(
            blurIntensity: 15.0,
            tintColor: Colors.white.withOpacity(0.1),
            edgeShineIntensity: 0.3,
          ),
        ],
      ),
      home: LiquidGlassScope(child: const DemoHome()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: LiquidGlassContainer(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  edgeShine: true,
                  shadow: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Liquid Glass',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildWelcomeCard(),
                    const SizedBox(height: 20),
                    _buildFeaturesSection(),
                    const SizedBox(height: 20),
                    _buildInteractiveSection(context),
                    const SizedBox(height: 20),
                    _buildComponentsGrid(context),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return LiquidGlassCard(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Liquid Glass',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Experience Apple\'s beautiful Liquid Glass design system in Flutter',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return LiquidGlassCard(
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            _FeatureItem(icon: Icons.blur_on, text: 'Glassmorphic Effects'),
            SizedBox(height: 12),
            _FeatureItem(icon: Icons.light_mode, text: 'Dynamic Edge Shine'),
            SizedBox(height: 12),
            _FeatureItem(
              icon: Icons.animation,
              text: 'Physics-Based Animations',
            ),
            SizedBox(height: 12),
            _FeatureItem(icon: Icons.touch_app, text: 'Touch Interactions'),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveSection(BuildContext context) {
    return LiquidGlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Try It Out',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            LiquidGlassButton(
              onPressed: () {
                _showSnackbar(context);
              },
              child: const Text(
                'Show Snackbar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            LiquidGlassButton(
              onPressed: () {
                _showSheet(context);
              },
              child: const Text(
                'Show Bottom Sheet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentsGrid(BuildContext context) {
    return LiquidGlassCard(
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Components',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ComponentChip(text: 'Card'),
                _ComponentChip(text: 'Button'),
                _ComponentChip(text: 'Sheet'),
                _ComponentChip(text: 'AppBar'),
                _ComponentChip(text: 'NavBar'),
                _ComponentChip(text: 'SnackBar'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context) {
    showLiquidGlassSnackBar(
      context: context,
      message: 'Hello from Liquid Glass Snackbar! ✨',
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showLiquidGlassSheet(
      context: context,
      builder: (context) => LiquidGlassSheet(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Liquid Glass Sheet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'This is a beautiful bottom sheet with glassmorphic effects.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              LiquidGlassButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 16, color: Colors.white70)),
      ],
    );
  }
}

class _ComponentChip extends StatelessWidget {
  final String text;

  const _ComponentChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
