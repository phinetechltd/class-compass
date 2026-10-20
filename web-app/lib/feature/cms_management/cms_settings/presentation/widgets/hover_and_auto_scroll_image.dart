import 'package:flutter/material.dart';

class HoverAdvancedScrollImage extends StatefulWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double speed;

  const HoverAdvancedScrollImage({
    super.key,
    required this.imageUrl,
    this.height = 350,
    this.width = 250,
    this.speed = 40,
  });

  @override
  State<HoverAdvancedScrollImage> createState() =>
      _HoverAdvancedScrollImageState();
}

class _HoverAdvancedScrollImageState extends State<HoverAdvancedScrollImage> {
  final ScrollController _controller = ScrollController();

  bool hoverActive = false;
  bool animating = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Scroll UP on hover
  Future<void> autoScrollUp() async {
    if (animating) return;
    animating = true;

    while (hoverActive) {
      await Future.delayed(const Duration(milliseconds: 16));

      double newPos = (_controller.position.pixels + widget.speed)
          .clamp(0, _controller.position.maxScrollExtent);

      await _controller.animateTo(
        newPos,
        duration: const Duration(milliseconds: 120),
        curve: Curves.linear,
      );
    }

    animating = false;
  }

  // Scroll DOWN on exit
  void scrollDownOnExit() {
    _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        hoverActive = true;
        autoScrollUp();
      },
      onExit: (_) {
        hoverActive = false;
        scrollDownOnExit();
      },
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          // mobile drag support
          _controller.jumpTo(
            (_controller.position.pixels - details.delta.dy)
                .clamp(0, _controller.position.maxScrollExtent),
          );
        },
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: SingleChildScrollView(
            controller: _controller,
            child: Image.asset(
              widget.imageUrl,
              width: widget.width,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
