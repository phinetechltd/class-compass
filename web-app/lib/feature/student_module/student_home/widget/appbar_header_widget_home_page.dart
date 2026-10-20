import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/parent_module/parent_profile/domain/model/parent_profile_model.dart';
import 'package:class_compass/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:class_compass/feature/parent_module/parents/presentation/widget/switch_children_dialog.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';


class ParentHeaderSectionWidget extends StatelessWidget {
  const ParentHeaderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentProfileController>(
      builder: (profileController) {
        ParentProfileModel? profileModel = profileController.profileModel;
        Student? student = profileModel?.data?.student;
        return profileModel != null?
        Row(spacing: Dimensions.paddingSizeSmall, children: [
          CustomContainer(horizontalPadding: 8,verticalPadding: 5,
            onTap: ()=> showModalBottomSheet(isScrollControlled: true, showDragHandle: true,
              useSafeArea: true,
              context: context, builder: (context) => const SwitchChildrenDialog(),),
            color: Theme.of(context).cardColor.withValues(alpha: 0.5),showShadow: false,
            borderRadius: 5,borderColor: Theme.of(context).hintColor,
            child: Row( spacing: Dimensions.paddingSizeExtraSmall, children: [
              const CustomImage(radius: 100,width: 25,height: 25, image: "", placeholder: Images.profileIcon),
              Text("${student?.firstName??''} ${student?.lastName??''}",
                  style: textBold.copyWith( fontSize: 12)),
              const Icon(Icons.keyboard_arrow_down, size: 16,),
            ])),
        ]) : const SizedBox();
      }
    );
  }
}