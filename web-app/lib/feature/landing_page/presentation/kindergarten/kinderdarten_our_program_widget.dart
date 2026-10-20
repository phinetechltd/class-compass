import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/ready_to_join_us_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class KindergartenOurProgramWidget extends StatelessWidget {
  const KindergartenOurProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (state) {
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.admissionModel == null) {
          landingPageController.getAdmissionData();
        }
      },
      builder: (landingPageController) {
        ReadyToJoinUsModel? readyToJoinUsModel = landingPageController.admissionModel;
        final isDesktop = ResponsiveHelper.isDesktop(context);
        return readyToJoinUsModel != null?
        Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child:  Column( mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, spacing: Dimensions.paddingSizeSmall, children: [
                    SizedBox(height: isDesktop? 50: Dimensions.paddingSizeDefault),
                    Text("our_program".tr, style: textBold.copyWith(fontSize: 40, color: Theme.of(context).colorScheme.primary)),
                    Text("nursing_every_stage".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),


                    Padding(padding: EdgeInsets.only(top: Dimensions.paddingSizeLarge, bottom: isDesktop? 50 : 15),
                      child: MasonryGridView.builder(
                        itemCount: readyToJoinUsModel.data?.length ?? 0,
                        shrinkWrap: true,
                        crossAxisSpacing: 20, mainAxisSpacing: 20,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return ReadyToJoinUsItemWidget(item: readyToJoinUsModel.data?[index]);
                        }, gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ):const SizedBox();
      },
    );
  }
}



class ReadyToJoinUsItemWidget extends StatelessWidget {
  final ReadyToJoinUsItem? item;
  const ReadyToJoinUsItemWidget({super.key, this.item});
  @override
  Widget build(BuildContext context) {
    return CustomContainer(borderRadius: Dimensions.radiusSmall,
      verticalPadding: Dimensions.paddingSizeLarge,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, spacing: Dimensions.paddingSizeSmall,
          mainAxisAlignment: MainAxisAlignment.center, children: [
        CustomImage(image: item?.icon, height: 70,width: 70, placeholder: Images.program),
        Text(item?.title??'',style: textHeavy.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
         Text(item?.description??'', style: textRegular.copyWith(), textAlign: TextAlign.center,
             maxLines: 2, overflow: TextOverflow.ellipsis),
       ]),
    );
  }
}
