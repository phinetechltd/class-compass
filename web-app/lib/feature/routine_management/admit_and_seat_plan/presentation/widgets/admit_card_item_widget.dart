import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/controller/admit_and_seat_plan_controller.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AdmitCardItemWidget extends StatelessWidget {
  final AdmitCardItem? admitCardItem;
  final int index;
  const AdmitCardItemWidget({super.key, this.admitCardItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdmitAndSeatPlanController>(
      builder: (admitAndSeatPlanController) {
        AdmitCardModel? admitCard = admitAndSeatPlanController.admitCardModel;
        return CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
            CustomContainer(borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall,
            child: Row(children: [
               CustomImage(image: Get.find<SystemSettingsController>().logoUrl, height: 40,),
              Expanded(child: Center(child: Column(
                children: [
                  Text(AppConstants.appName.tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  Text("${admitCardItem?.classItem?.className??'N/A'} ${admitCardItem?.section?.sectionName??'N/A'}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeSmall),),
                ],
              ))),
            ])),

            Center(child: Padding(padding: const EdgeInsets.all(8.0),
              child: Text("Admit Card ${admitCard?.data?.examName??'N/A'}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)))),

            CustomContainer(borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall,
              child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
                    CustomRow(title: "roll".tr, info: admitCardItem?.roll??"N/A"),
                    CustomRow(title: "name".tr, info: "${admitCardItem?.student?.firstName??""} ${admitCardItem?.student?.lastName??""}"),
                    CustomRow(title: "section".tr, info: "${admitCardItem?.section?.sectionName??""} ${admitCardItem?.student?.lastName??""}"),
                    CustomRow(title: "group".tr, info: "${admitCardItem?.student?.studentGroup?.groupName??""} ${admitCardItem?.student?.lastName??""}"),
                    CustomRow(title: "fathers_name".tr, info: admitCardItem?.student?.fatherName??""),
                    CustomRow(title: "mothers_name".tr, info: admitCardItem?.student?.motherName??""),
                    ],
                  )),
                  CustomImage(width: 120, height: 120,
                     image: '${AppConstants.imageBaseUrl}/users/${admitCardItem?.student?.user?.image}'),


                ]),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            Row(spacing: Dimensions.paddingSizeDefault,children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall,
              children: [
                Text("1. Examine must entered into the exam hall at least 15 minutes before the exam start", style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                Text("2. No extra papers will be allowed except the admit and registration card.", style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                Text("3. Examine must carry all necessary essentials for the exam e.g pen, pencil.", style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                Text("4. Authority deserves all rights to expel the examine due to unfair-means in the exam", style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),

              ],),),
              Column(spacing: Dimensions.paddingSizeExtraSmall, children: [
                CustomContainer(showShadow: false, borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall, height: 2, width: 150),
                Text("Signature of Class Teacher", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
              ],),
              Column(spacing: Dimensions.paddingSizeExtraSmall,children: [
                CustomContainer(showShadow: false, borderColor: Theme.of(context).hintColor, borderRadius: Dimensions.paddingSizeExtraSmall, height: 2, width: 150),
                Text("Signature of Principal", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              ],),

            ],)
            ],
          ),
        );
      }
    );
  }
}

class CustomRow extends StatelessWidget {
  final String title;
  final String info;
  final Widget? infoWidget;
  const CustomRow({super.key, required this.title, required this.info, this.infoWidget});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeSmall, children: [
      Expanded(flex: 3, child: Text(title, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
      Expanded(flex: 8,child: Text(info, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),

    ]);
  }
}
