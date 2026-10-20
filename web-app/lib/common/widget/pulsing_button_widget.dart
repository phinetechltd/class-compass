import 'dart:math';
import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AnimatedBorderButton extends StatefulWidget {
  final String? title;
  final VoidCallback? onTap;
  const AnimatedBorderButton({super.key, this.title, this.onTap});

  @override
  State<AnimatedBorderButton> createState() => _AnimatedBorderButtonState();
}

class _AnimatedBorderButtonState extends State<AnimatedBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final colors = [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.purple,
          Colors.red,
        ];

        // animate gradient rotation
        final angle = _controller.value * 2 * pi;

        return CustomContainer(verticalPadding: 5, onTap: widget.onTap,
          showShadow: false, borderRadius: 8,
          child: Container(padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              gradient: SweepGradient(startAngle: 0, endAngle: 2 * pi, colors: colors,
                transform: GradientRotation(angle))),
            child: Container(alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(color: systemPrimaryColor(),
                borderRadius: BorderRadius.circular(5)),
              child: Text(widget.title ?? "Buy Now", style: textSemiBold.copyWith(
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeLarge),
              ),
            ),
          ),
        );
      },
    );
  }
}
