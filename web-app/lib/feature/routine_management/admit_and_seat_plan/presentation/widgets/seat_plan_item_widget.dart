import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/controller/admit_and_seat_plan_controller.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/presentation/widgets/admit_card_item_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SeatPlanItemWidget extends StatelessWidget {
  final AdmitCardItem? admitCardItem;
  final int index;
  const SeatPlanItemWidget({super.key, this.admitCardItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdmitAndSeatPlanController>(
      builder: (admitAndSeatPlanController) {
        AdmitCardModel? admitCard = admitAndSeatPlanController.admitCardModel;
        return CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
            CustomContainer(borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall,
                child: Row(children: [
                  CustomImage(image: Get.find<SystemSettingsController>().logoUrl,height: 40,),
                  Expanded(child: Center(child: Column(children: [
                      Text(AppConstants.appName.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                      Text("${admitCardItem?.classItem?.className??'N/A'} ${admitCardItem?.section?.sectionName??'N/A'}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall),),
                    ],
                  ))),
                ])),

            Center(child: Padding(padding: const EdgeInsets.all(8.0),
                child: Text("Seat Plan for ${admitCard?.data?.examName??'N/A'}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)))),

            CustomContainer(borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall,
              child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
                  CustomRow(title: "roll".tr, info: admitCardItem?.roll??""),
                  CustomRow(title: "name".tr, info: "${admitCardItem?.student?.firstName??""} ${admitCardItem?.student?.lastName??""}"),
                  CustomRow(title: "section".tr, info: "${admitCardItem?.section?.sectionName??""} ${admitCardItem?.student?.lastName??""}"),
                  CustomRow(title: "group".tr, info: "${admitCardItem?.student?.studentGroup?.groupName??""} ${admitCardItem?.student?.lastName??""}"),
                ],
                )),
                CustomImage(width: 120, height: 120,
                    image: '${AppConstants.imageBaseUrl}/users/${admitCardItem?.student?.user?.image}'),


              ]),
            ),

          ],
          ),
        );
      }
    );
  }
}
