
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class GeneralExamListSearchWidget extends StatelessWidget {
  const GeneralExamListSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        return Row(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Expanded(child: SelectClassWidget()),
          const Expanded(child: SelectGroupWidget()),


          SizedBox(width: 90, child: Padding(padding: const EdgeInsets.only(bottom: 8.0),
              child: markConfigController.isLoading?
                  const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){
            int? classId = Get.find<ClassController>().selectedClassItem?.id;
            int? groupId = Get.find<GroupController>().groupItem?.id;
            if(classId == null){
              showCustomSnackBar("class_is_empty".tr);
            }
            else if(groupId == null){
              showCustomSnackBar("group_is_empty".tr);
            }

            else{
              markConfigController.getGeneralExamList(classId, groupId);
            }
          }, text: "search".tr)))
        ]);
      }
    );
  }
}
