import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/mobile_app_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/mobile_app_section/feature_item_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/mobile_app_section/hoverable_image_widget.dart';
import 'package:class_compass/feature/landing_page/widgets/landing_section_header_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class StayConnectedWidget extends StatelessWidget {
  const StayConnectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(initState: (val) {
      
        final controller = Get.find<LandingPageController>();
        if (controller.mobileAppModel == null) {
          controller.getMobileAppData();
        }
      }, builder: (controller) {
        final model = controller.mobileAppModel;

        if (model == null || model.data?.isEmpty != false) {
          return const SizedBox();
        }

        final data = model.data!.first;
        final isDesktop = ResponsiveHelper.isDesktop(context);

        final imageWidget = _imageWidget(context, data);
        final contentWidget = _contentWidget(context, data);

        if (isDesktop) {
          return Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 50,
              horizontal: Dimensions.paddingSizeDefault),
              child: Row(spacing: Dimensions.paddingSizeExtraLarge,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                HoverableImage(imageUrl: "${AppConstants.imageBaseUrl}/mobile_app_sections/${data.image}",
                width: 400, height: 400, placeholder: Images.stayConnected),
                 Expanded(child: contentWidget),
                ])),
            ),
          );
        }

        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeDefault,
            mainAxisAlignment: MainAxisAlignment.center, children: [
              imageWidget, contentWidget]),
        );
      },
    );
  }


  Widget _imageWidget(BuildContext context, MobileItem data) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return CustomImage(width: isDesktop ? 400 : Get.width,
      height: isDesktop ? 400 : null, fit: BoxFit.fitWidth,
      image: "${AppConstants.imageBaseUrl}/mobile_app_sections/${data.image}",
      placeholder: Images.stayConnected, radius: 10);
  }

  Widget _contentWidget(BuildContext context, MobileItem data) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Column(crossAxisAlignment:
      isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      spacing: Dimensions.paddingSizeDefault, children: [
        LandingSectionHeader(textAlignCenter: !isDesktop,
          subtitle: "mobile_app".tr, title: data.title ?? ''),

        Text(data.description ?? '', textAlign: isDesktop ?
        TextAlign.start : TextAlign.center, style: textRegular.copyWith(
            fontSize: isDesktop ? 20 : Dimensions.paddingSizeDefault,
            color: Theme.of(context).hintColor)),

        Column(crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Dimensions.paddingSizeSmall, children: [
            FeatureItemWidget(title: data.featureOne),
            FeatureItemWidget(title: data.featureTwo),
            FeatureItemWidget(title: data.featureThree),
          ]),

        const SizedBox(height: Dimensions.paddingSizeDefault),
        _storeButtons(data, isDesktop),
      ],
    );
  }

  Widget _storeButtons(MobileItem data, bool isDesktop) {
    return Row(mainAxisAlignment:
      isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
      spacing: Dimensions.paddingSizeDefault, children: [
        _hoverableStoreButton(image: Images.playStore, url: data.playStoreLink ?? ''),
        _hoverableStoreButton(image: Images.appStore, url: data.appStoreLink ?? ''),
      ],
    );
  }


  Widget _hoverableStoreButton({required String image, required String url}) {
    return HoverableButton(child: InkWell(onTap: () => AppConstants.openUrl(url),
        child: CustomImage(image: image, height: 40, localAsset: true),
      ),
    );
  }
}
class HoverableButton extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const HoverableButton({
    super.key,
    required this.child,
    this.scale = 1.1,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverableButton> createState() => HoverableButtonState();
}

class HoverableButtonState extends State<HoverableButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(scale: _hovered ? widget.scale : 1.0,
        duration: widget.duration, curve: Curves.easeOut, child: widget.child),
    );
  }
}


