import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/administrator/event/controller/event_controller.dart';
import 'package:class_compass/feature/administrator/event/domain/models/event_model.dart';
import 'package:class_compass/feature/administrator/event/presentation/screens/create_new_event_screen.dart';
import 'package:class_compass/feature/administrator/event/presentation/widgets/create_new_event_widget.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class EventItemWidget extends StatelessWidget {
  final EventItem? eventItem;
  final int index;
  const EventItemWidget({super.key, this.eventItem, required this.index});

  @override
  Widget build(BuildContext context) {
    log("iii==> ${"${AppConstants.imageBaseUrl}/events/${eventItem?.image}"}");
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault,
      children: [
        NumberingWidget(index: index),
          CustomImage(width: 40, height: 40,
              image: "${AppConstants.imageBaseUrl}/events/${eventItem?.image}"),
          Expanded(child: CustomItemTextWidget(text: eventItem?.name??'N/A')),
          Expanded(child: CustomItemTextWidget(text: eventItem?.details??'N/A')),
          Expanded(child: CustomItemTextWidget(text: eventItem?.location??'N/A')),
          Expanded(child: CustomItemTextWidget(text: DateConverter.dateTimeStringToDateTime(eventItem?.startDate??''))),
          Expanded(child: CustomItemTextWidget(text: DateConverter.dateTimeStringToDateTime(eventItem?.endDate??''))),

        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CustomDialogWidget(title: "event".tr,
              child: CreateNewEventWidget(eventItem: eventItem)));
        },
          onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: "event",
              content: "event",
              onTap: (){
                Get.back();
                Get.find<EventController>().deleteEvent(eventItem!.id!);
              },));

          },)
      ],
    ):
    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"title".tr} : ${eventItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Text("${"description".tr} : ${eventItem?.details??''}", style: textRegular.copyWith(),),
            Text("${"start".tr} : ${DateConverter.dateTimeStringToDateTime(eventItem?.startDate??'')}", style: textRegular.copyWith(),),
            Text("${"end".tr} : ${DateConverter.dateTimeStringToDateTime(eventItem?.endDate??'')}", style: textRegular.copyWith(),),

          ]),
          ),
          EditDeleteSection(onEdit: (){
            Get.to(() => CreateNewEventScreen(eventItem: eventItem));
          },
            onDelete: (){
              Get.dialog(ConfirmationDialog(
                title: "event",
                content: "event",
                onTap: (){
                  Get.back();
                  Get.find<EventController>().deleteEvent(eventItem!.id!);
                },));

            },)
        ],
      ),
    );
  }
}