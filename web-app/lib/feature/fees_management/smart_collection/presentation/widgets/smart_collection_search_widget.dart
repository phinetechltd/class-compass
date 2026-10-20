import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class SmartCollectionSearchWidget extends StatelessWidget {
  const SmartCollectionSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: CustomContainer(
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeDefault, children: [
          const Expanded(child: SelectClassWidget()),
          const Expanded(child: SelectSectionWidget()),

          Padding(padding: const EdgeInsets.only(bottom: 8.0),
            child: GetBuilder<SmartCollectionController>(
                builder: (studentController) {
                  return SizedBox(width: 90, child:
                  studentController.isLoading?
                  const Center(child: CircularProgressIndicator()):
                  CustomButton(onTap: (){
                    int? classId = Get.find<ClassController>().selectedClassItem?.id;
                    int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;

                    if(classId == null){
                      showCustomSnackBar("select_class".tr);
                    }
                     else {
                      studentController.getStudentListForSmartCollection(classId, sectionId, 1);
                    }
                  }, text: "search", innerPadding: EdgeInsets.zero,));
                }
            ),
          )
        ],
        ),
      ),
    );
  }
}
