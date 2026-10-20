import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/event_model.dart';
import 'package:class_compass/feature/landing_page/presentation/event_details_dialog_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class LandingEventItemWidget extends StatefulWidget {
  final EventItem item;
  const LandingEventItemWidget({super.key, required this.item});

  @override
  State<LandingEventItemWidget> createState() => _LandingEventItemWidgetState();
}

class _LandingEventItemWidgetState extends State<LandingEventItemWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MouseRegion(cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250), curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: _hovered ? [
              BoxShadow(color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20, offset: const Offset(0, 8))]
                : [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5,
                offset: const Offset(0, 2))]),

          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1.0, end: _hovered ? 1.03 : 1.0),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: GestureDetector(onTap: () => Get.dialog(
                CustomDialogWidget(child: EventDetailsDialogWidget(item: widget.item))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Dimensions.paddingSizeSmall, children: [
                  CustomImage(image: widget.item.image, width: 350, height: 250,
                    radius: 10,
                    placeholder: Images.eventPlaceHolder),
                  Text(widget.item.name ?? '',
                    style: textMedium.copyWith(fontSize: 20)),

                  Text("${DateConverter.isoStringToLocalString(widget.item.startDate ?? '')} "
                        "${"to".tr} "
                        "${DateConverter.isoStringToLocalString(widget.item.endDate ?? '')}",
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: systemLandingPagePrimaryColor())),

                  InkWell(onTap: () => Get.dialog(
                      Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                        child: EventDetailsDialogWidget(item: widget.item))),

                    child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                        Text("view_events".tr, style: textRegular.copyWith(
                              color: systemLandingPagePrimaryColor())),
                        const CustomImage(image: Images.arrowRight, localAsset: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
