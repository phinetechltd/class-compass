
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/why_choose_us_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/why_choose_us/why_choose_us_item_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/why_choose_us/why_choose_us_loading_widget.dart';
import 'package:class_compass/feature/landing_page/widgets/landing_section_header_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class WhyChooseUsWidget extends StatelessWidget {
  const WhyChooseUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val){
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.whyChooseUsModel == null) {
          landingPageController.getWhyChooseUsData();
        }
      },
      builder: (landingPageController) {
        WhyChooseUsModel? whyChooseUsModel = landingPageController.whyChooseUsModel;
        final isDesktop = ResponsiveHelper.isDesktop(context);
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).hintColor.withValues(alpha: 0.1)),
          child: Padding(padding:  EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? 50 : Dimensions.paddingSizeExtraLarge),
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [

                LandingSectionHeader(subtitle: "why_choose_us".tr,
                    title: "${"why".tr} ${AppConstants.appName} ${"is_the_right_choice".tr}"),



                  isDesktop?
                  SizedBox(height: 260,
                    child: whyChooseUsModel != null ? ListView.builder(
                        itemCount: whyChooseUsModel.data?.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 280 : Get.width * 0.2,
                              child: LandingWhyChooseUsItemWidget(item: whyChooseUsModel.data?[index]),
                            ));
                        })
                        : const WhyChooseUsLoadingWidget(),
                  ): whyChooseUsModel != null ? ListView.separated(
                      itemCount: whyChooseUsModel.data?.length??0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 280 : Get.width * 0.2,
                              child: LandingWhyChooseUsItemWidget(item: whyChooseUsModel.data?[index]),
                            ));
                      }, separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: Dimensions.paddingSizeExtraLarge);
                  },)
                      : const WhyChooseUsLoadingWidget()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


