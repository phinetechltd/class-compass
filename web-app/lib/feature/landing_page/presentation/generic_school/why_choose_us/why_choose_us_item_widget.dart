import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/why_choose_us_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class LandingWhyChooseUsItemWidget extends StatefulWidget {
  final WhyChooseUsItem? item;
  const LandingWhyChooseUsItemWidget({super.key, this.item});

  @override
  State<LandingWhyChooseUsItemWidget> createState() => _LandingWhyChooseUsItemWidgetState();
}

class _LandingWhyChooseUsItemWidgetState extends State<LandingWhyChooseUsItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _hovered
            ? (Matrix4.identity()..translateByDouble(0.0, -8.0, 0.0, 1.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ]
              : [],
        ),
        child: Column(
          children: [
            SvgPicture.asset(Images.logo),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: _hovered ? 1.08 : 1.0, // image zoom
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  child: CustomImage(
                    image:
                    "${AppConstants.imageBaseUrl}/why_choose_us/${widget.item?.icon}",
                    height: 150,
                  ),
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault),

                Text(
                  "${widget.item?.title}",
                  style: textBold.copyWith(
                    fontSize: 20,
                    color: systemLandingPagePrimaryColor(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "${widget.item?.description}",
                  maxLines: ResponsiveHelper.isDesktop(context) ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




class BorderProgressPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final double radius;

  BorderProgressPainter({
    required this.animation,
    required this.color,
    required this.radius,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final rrect = RRect.fromRectAndRadius(
      rect.deflate(1),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metric = path.computeMetrics().first;

    final extractPath = metric.extractPath(
      0,
      metric.length * animation.value,
    );

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
