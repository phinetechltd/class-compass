import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/testimonial_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class LandingTestimonialCard extends StatefulWidget {
  final TestimonialItem? item;
  const LandingTestimonialCard({super.key, this.item});

  @override
  State<LandingTestimonialCard> createState() => _LandingTestimonialCardState();
}

class _LandingTestimonialCardState extends State<LandingTestimonialCard>
    with SingleTickerProviderStateMixin {
  bool _isHover = false;
  late AnimationController _borderController;

  @override
  void initState() {
    super.initState();
    _borderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  void _onHover(bool v) {
    setState(() => _isHover = v);

    if (v) {
      _borderController.forward(from: 0); // draw border
    } else {
      _borderController.reverse(); // erase border smoothly
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = systemLandingPagePrimaryColor();

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0, _isHover ? -6 : 0, 0, 1)
          ..scaleByDouble(_isHover ? 1.03 : 1, _isHover ? 1.03 : 1, 1, 1),
        child: Stack(
          children: [
            /// Main Card
            CustomContainer(
              showShadow: _isHover,
              borderRadius: Dimensions.paddingSizeExtraSmall,
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: .15),
                width: .5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    CustomImage(
                      image: widget.item?.user?.image,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      placeholder: Images.profilePlaceHolder,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item?.user?.name ?? '',
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                          ),
                          Text(
                            widget.item?.user?.email ?? 'Nursery',
                            style: textRegular.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Text(
                    widget.item?.description ?? 'N/A',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: textRegular.copyWith(
                      height: 1.5,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ),

            /// Animated Border Overlay
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _borderController,
                  builder: (_, __) {
                    return CustomPaint(
                      painter: BorderDrawPainter(
                        progress: _borderController.value,
                        color: primary,
                        radius: Dimensions.paddingSizeExtraSmall,
                        strokeWidth: 1.6,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= BORDER PAINTER =================

class BorderDrawPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double radius;
  final double strokeWidth;

  BorderDrawPainter({
    required this.progress,
    required this.color,
    this.radius = 8,
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final path = Path()..addRRect(rrect);

    final metrics = path.computeMetrics().first;
    final extract = metrics.extractPath(0, metrics.length * progress);

    canvas.drawPath(extract, paint);
  }

  @override
  bool shouldRepaint(covariant BorderDrawPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
