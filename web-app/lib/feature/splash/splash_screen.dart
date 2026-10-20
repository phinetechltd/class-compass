import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<String> _emojis = ["🖥️", "📐", "🎓", "📚", "🔬", "🎨", "📊", "✏️"];
  late final List<Offset> _positions;

  @override
  void initState() {
    super.initState();
    _positions = List.generate(
        _emojis.length,
            (_) => Offset(
          _random.nextDouble(),
          _random.nextDouble(),
        ));

    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _floatingEmoji(String emoji, Offset position, double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double offsetY = 20 * (0.5 - (_controller.value + delay) % 1);
        double offsetX = 15 * (0.5 - (_controller.value + delay) % 1);

        return Positioned(
          top: MediaQuery.of(context).size.height * position.dy + offsetY,
          left: MediaQuery.of(context).size.width * position.dx + offsetX,
          child: Opacity(
            opacity: 0.6 + 0.4 * (_controller.value),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      for (int i = 0; i < _emojis.length; i++)
        _floatingEmoji(_emojis[i], _positions[i], i * 0.1),

        ],
      ),
    );
  }
}
