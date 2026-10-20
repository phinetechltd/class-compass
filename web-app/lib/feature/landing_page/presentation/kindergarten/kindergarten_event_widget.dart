import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/event_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/event/event_loading_widget.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class KindergartenEventWidget extends StatelessWidget {
  const KindergartenEventWidget({super.key});

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
        return eventModel != null?
        Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text("stay_updated_with_our_latest_events".tr, style: textBold.copyWith(fontSize: 40, color: Theme.of(context).colorScheme.primary)),

              SizedBox(height: 450,
                child: ListView.builder(
                  itemCount: eventModel.data?.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {
                    return EventItemWidget(item: eventModel.data![index]);
                  }
                ),
              ),
            ],
            ),
          ),
        ):const EventLoadingWidget();
      }
    );
  }
}

class EventItemWidget extends StatelessWidget {
  final EventItem item;
  const EventItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomContainer( width: 250,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeSmall, children: [
          CustomImage(image: item.image,width: 250, placeholder: Images.eventPlaceHolder,),
          Text(item.name??'', style: textMedium.copyWith(fontSize: 20,color: Theme.of(context).colorScheme.primary),),
          Text("${DateConverter.isoStringToLocalString(item.startDate??'')} ${"to".tr} ${DateConverter.isoStringToLocalString(item.endDate??'')}",
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).colorScheme.primary),),
          Text(item.details??'', maxLines: 2, overflow: TextOverflow.ellipsis, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: 16),),
          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Text("view_events".tr, style: textRegular.copyWith(color: Theme.of(context).secondaryHeaderColor),),
             Image.asset(Images.arrowRight,  color: Theme.of(context).secondaryHeaderColor)
          ])
          ],
        ),
      ),
    );
  }
}