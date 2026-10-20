import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/about_us_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/styles.dart';

class LandingAboutUsSection extends StatefulWidget {
  final LandingAboutUsItem? aboutUsModel;
  const LandingAboutUsSection({super.key, this.aboutUsModel});

  @override
  State<LandingAboutUsSection> createState() => _LandingAboutUsSectionState();
}

class _LandingAboutUsSectionState extends State<LandingAboutUsSection> {
  bool _isImageHover = false;
  bool _isTextHover = false;

  @override
  Widget build(BuildContext context) {
    final aboutUsModel = widget.aboutUsModel;

    return Row(children: [
        MouseRegion(onEnter: (_) => setState(() => _isImageHover = true),
          onExit: (_) => setState(() => _isImageHover = false),
          child: AnimatedContainer(duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..scaleByDouble(_isImageHover ? 1.05 : 1, _isImageHover ? 1.05 : 1, 1, 1),
            child: CustomImage(width: 445, height: 450,
              image: "${AppConstants.imageBaseUrl}/about_us/${aboutUsModel?.image}",
            ),
          )),
        const SizedBox(width: 40),


        Expanded(
          child: MouseRegion(onEnter: (_) => setState(() => _isTextHover = true),
            onExit: (_) => setState(() => _isTextHover = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translateByDouble(0, _isTextHover ? -5 : 0, 0, 1)
                ..scaleByDouble(_isTextHover ? 1.02 : 1, _isTextHover ? 1.02 : 1, 1, 1),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Text('about_us'.tr,
                    style: textMedium.copyWith(fontSize: 20, color: systemLandingPagePrimaryColor())),
                  const SizedBox(height: 6),

                  Text(aboutUsModel?.title ?? '', style: textBold.copyWith(
                      color: systemLandingPagePrimaryColor(), fontSize: 40)),
                  const SizedBox(height: 12),


                  Text(aboutUsModel?.description ??
                        'We provide a nurturing environment, a challenging curriculum, and a dedicated faculty to ensure student success.',
                    maxLines: 5, overflow: TextOverflow.ellipsis,
                    style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                  const SizedBox(height: 50),
                  SizedBox(width: 200,
                    child: CustomButton(buttonColor: systemLandingPagePrimaryColor(),
                        onTap: () {}, text: "learn_more_about_us".tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
