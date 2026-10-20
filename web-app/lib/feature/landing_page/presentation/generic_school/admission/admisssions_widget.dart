import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/ready_to_join_us_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/admission/admission_loading_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/admission/landing_ready_to_join_widget.dart';
import 'package:class_compass/feature/landing_page/widgets/landing_section_header_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class AdmissionsWidget extends StatelessWidget {
  const AdmissionsWidget({super.key});

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
            child: Padding(padding: EdgeInsets.symmetric(vertical:ResponsiveHelper.isDesktop(context)?50 : Dimensions.paddingSizeDefault),
              child: isDesktop ? Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [
                  Expanded(child: Column( mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center, children: [

                      LandingSectionHeader(subtitle: "admissions".tr, title: "ready_to_join_us".tr),

                        ListView.builder(
                          itemCount: readyToJoinUsModel.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return LandingReadyToJoinUsItemWidget(item: readyToJoinUsModel.data?[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ) :
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                LandingSectionHeader(subtitle: "admissions".tr, title: "ready_to_join_us".tr),
                  ListView.builder(
                    itemCount: readyToJoinUsModel.data?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return LandingReadyToJoinUsItemWidget(
                        item: readyToJoinUsModel.data?[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ):const AdmissionWidgetLoadingWidget();
      },
    );
  }
}




