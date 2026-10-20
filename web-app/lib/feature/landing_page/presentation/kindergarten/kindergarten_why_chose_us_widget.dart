import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/why_choose_us_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class KindergartenWhyChooseUsWidget extends StatelessWidget {
  const KindergartenWhyChooseUsWidget({super.key});

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
        return Container(padding: EdgeInsets.symmetric(vertical: isDesktop? 50: 20),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: whyChooseUsModel != null ? Center(
            child: SizedBox(width: Dimensions.webMaxWidth,
              child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeLarge, children: [
                isDesktop?
                Row(spacing: Dimensions.paddingSizeDefault,mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: [
                  Text("growing_together_with_your_child".tr, style: textHeavy.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                  Text("building_a_bright_future".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                ],):Column(spacing: Dimensions.paddingSizeSmall,mainAxisSize: MainAxisSize.min, children: [
                  Text("growing_together_with_your_child".tr, style: textHeavy.copyWith(fontSize: Dimensions.fontSizeOverLarge),),
                  Text("building_a_bright_future".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
                ]),
                  MasonryGridView.builder(
                    crossAxisSpacing: 20, mainAxisSpacing: 20,
                      itemCount: whyChooseUsModel.data?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return WhyChooseUsItemWidget(item: whyChooseUsModel.data?[index]);
                      }, gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 700)),
                ],
              ),
            ),
          )
              : const SizedBox(),
        );
      },
    );
  }
}



class WhyChooseUsItemWidget extends StatelessWidget {
  final WhyChooseUsItem? item;
  const WhyChooseUsItemWidget({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(color: Theme.of(context).cardColor,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,spacing: Dimensions.paddingSizeDefault, children: [
          CustomImage(image: "${AppConstants.imageBaseUrl}/why_choose_us/${item?.icon}", width: 50, height: 50),

        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${item?.title}", style: textBold.copyWith(fontSize: 20, color: Theme.of(context).colorScheme.primary,),maxLines: 1, overflow: TextOverflow.ellipsis,),
            Text("${item?.description}",maxLines: ResponsiveHelper.isDesktop(context)? 3:2,
              overflow: TextOverflow.ellipsis, style: textRegular.copyWith(color: Theme.of(context).hintColor)),

          ],),
        )

        ],
      ),
    );
  }
}
