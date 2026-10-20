import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_image.dart';

class HoverableImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double scale;
  final Duration duration;
  final String? placeholder;

  const HoverableImage({
    super.key,
    required this.imageUrl,
    this.width = 400,
    this.height = 400,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 300),
    this.placeholder,
  });

  @override
  State<HoverableImage> createState() => _HoverableImageState();
}

class _HoverableImageState extends State<HoverableImage> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? widget.scale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: CustomImage(
          fit: BoxFit.contain,
          width: widget.width,
          height: widget.height,
          image: widget.imageUrl,
          placeholder: widget.placeholder ?? '',
          radius: 10,
        ),
      ),
    );
  }
}
