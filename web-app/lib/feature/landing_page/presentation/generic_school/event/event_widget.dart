import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/event_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/event/event_loading_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/event/landing_event_item_widget.dart';
import 'package:class_compass/feature/landing_page/widgets/landing_section_header_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class EventWidget extends StatelessWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val){
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.eventModel == null) {
          landingPageController.getEventInfoData();
        }
      },
      builder: (landingPageController) {
        EventFrontEndModel? eventModel = landingPageController.eventModel;
        final isDesktop = ResponsiveHelper.isDesktop(context);
        return eventModel != null? isDesktop?
        Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [

              LandingSectionHeader(subtitle: "events".tr,
                  title: "stay_updated_with_our_latest_events".tr),


              SizedBox(height: 400,
                child: ListView.builder(
                  itemCount: eventModel.data?.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {
                    return LandingEventItemWidget(item: eventModel.data![index]);
                  }
                ),
              ),
            ],
            ),
          ),
        ):
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeDefault,mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [


            LandingSectionHeader(subtitle: "events".tr,
                title: "stay_updated_with_our_latest_events".tr),

            SizedBox(height: 400,width: Get.width,
              child: ListView.builder(
                      itemCount: eventModel.data?.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (context, index) {
                        return LandingEventItemWidget(item: eventModel.data![index]);
                      })),
              ]),
            ) :const EventLoadingWidget();
      }
    );
  }
}

