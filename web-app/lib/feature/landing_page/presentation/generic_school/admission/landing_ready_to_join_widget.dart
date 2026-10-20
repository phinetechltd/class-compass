import 'package:flutter/material.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/ready_to_join_us_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class LandingReadyToJoinUsItemWidget extends StatefulWidget {
  final ReadyToJoinUsItem? item;
  const LandingReadyToJoinUsItemWidget({super.key, this.item});

  @override
  State<LandingReadyToJoinUsItemWidget> createState() => _LandingReadyToJoinUsItemWidgetState();
}

class _LandingReadyToJoinUsItemWidgetState extends State<LandingReadyToJoinUsItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transformAlignment: Alignment.center,
        transform: _hovered
            ? (Matrix4.identity()..translateByDouble(0, -4, 0, 1)) // lift
            : Matrix4.identity(),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: CustomContainer(
            showShadow: _hovered,
            borderRadius: Dimensions.radiusSmall,
            border: Border.all(
              width: .8,
              color: _hovered
                  ? systemLandingPagePrimaryColor().withValues(alpha: .4)
                  : Theme.of(context)
                  .primaryColorDark
                  .withValues(alpha: 0.1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  image: (widget.item?.icon ?? '').startsWith('http')
                      ? widget.item?.icon
                      : "${AppConstants.imageBaseUrl}/ready_to_join_us/${widget.item?.icon}",
                  height: 50,
                  width: 50,
                  placeholder: Images.program,
                ),
                const SizedBox(width: 20),

                /// 👉 Text section with slide effect
                Expanded(
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.only(left: _hovered ? 6 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item?.title ?? '',
                          style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.item?.description ?? '',
                          style: textRegular.copyWith(),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "Contact Us",
                              style: textRegular.copyWith(
                                color: systemLandingPagePrimaryColor(),
                              ),
                            ),
                            const SizedBox(width: 6),
                            AnimatedSlide(
                              duration: const Duration(milliseconds: 220),
                              offset:
                              _hovered ? const Offset(0.2, 0) : Offset.zero,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: systemLandingPagePrimaryColor(),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}