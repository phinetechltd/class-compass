

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/presentation/widgets/parent_paid_report_item_widget.dart';
import 'package:class_compass/feature/parent_module/parent_profile/domain/model/parent_profile_model.dart';
import 'package:class_compass/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class StudentCardWidget extends StatelessWidget {
  const StudentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double imageSize = ResponsiveHelper.isDesktop(context) ? 70 : 50;
    return  GetBuilder<ParentProfileController>(
      builder: (profileController) {
        ParentProfileModel? profileModel = profileController.profileModel;
        Student? student = profileModel?.data?.student;
        return student != null?
        CustomContainer(showShadow: false, verticalPadding: Dimensions.paddingSizeDefault,
          horizontalPadding: Dimensions.paddingSizeLarge,
          color: Theme.of(context).primaryColor, child: Column(spacing: Dimensions.paddingSizeSmall, children: [
             CustomImage(radius: 300,width: imageSize, height: imageSize, image: "", placeholder: Images.profileIcon),
            Text('${student.firstName?? ""} ${student.lastName?? ""}',style: textBold.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeExtraLarge)),

             Row(spacing :Dimensions.paddingSizeSmall, children: [
              Expanded(child: ItemInfoWithStyleWidget(title: "class".tr, value: student.studentSession?.classItem?.className??'N/A', titleColor: Colors.white, valueColor: Colors.white, fontSize: Dimensions.fontSizeDefault,)),
              Expanded(child: ItemInfoWithStyleWidget(title: "section".tr, value: student.studentSession?.section?.sectionName??'N/A', titleColor: Colors.white, valueColor: Colors.white, fontSize: Dimensions.fontSizeDefault,)),
            ]),
             Row(spacing :Dimensions.paddingSizeSmall, children: [
              Expanded(child: ItemInfoWithStyleWidget(title: "roll_no".tr, value: student.rollNo?.toString()??'N/A', titleColor: Colors.white, valueColor: Colors.white, fontSize: Dimensions.fontSizeDefault,)),
              Expanded(child: ItemInfoWithStyleWidget(title: "registration_no".tr, value: student.registerNo?.toString()??'N/A', titleColor: Colors.white, valueColor: Colors.white, fontSize: Dimensions.fontSizeDefault,)),
            ]),
          ]),
        ):const SizedBox();
      }
    );
  }
}
class IconWithTitle extends StatelessWidget {
  final String icon;
  final String title;
  const IconWithTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
      SizedBox(width: 20,child: Image.asset(icon)),
      Text(title.tr, style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),],);
  }
}
