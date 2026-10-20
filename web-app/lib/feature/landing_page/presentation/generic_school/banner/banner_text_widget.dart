import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/banner_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class BannerTextWidget extends StatefulWidget {
  final BannerItem? banner;
  const BannerTextWidget({
    super.key,
    this.banner,
  });

  @override
  State<BannerTextWidget> createState() => _BannerTextWidgetState();
}

class _BannerTextWidgetState extends State<BannerTextWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..translateByDouble(0, _isHover ? -3 : 0, 0, 1) // slight upward
          ..scaleByDouble(_isHover ? 1.02 : 1, _isHover ? 1.02 : 1, 1, 1), // subtle scale
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: textRegular.copyWith(
                    fontSize: isDesktop ? 46
                        : Dimensions.fontSizeExtraLarge,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 1),
                  ),
                  child: SizedBox(
                    width: 1000,
                    child: Text(
                      widget.banner?.title ??
                          "banner_title_placeholder".tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: textMedium.copyWith(
                    fontSize: isDesktop ? 20
                        : Dimensions.fontSizeDefault,
                    color: Colors.white.withValues(alpha: 1),
                    height: 1.4,
                  ),
                  child: Text(
                    widget.banner?.description ??
                        "banner_description_placeholder".tr,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
