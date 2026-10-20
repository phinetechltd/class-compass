import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class UnpaidSearchWidget extends StatelessWidget {
  const UnpaidSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaidInfoController>(builder: (paidInfoController) {
      return Padding(padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault),
        child: CustomContainer(
          child: Row(spacing: Dimensions.paddingSizeDefault,
              crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Expanded(child: SelectClassWidget()),
            const Expanded(child: SelectSectionWidget()),
            IntrinsicWidth(child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: paidInfoController.isLoading?
                const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){
                  int? classId  = Get.find<ClassController>().selectedClassItem?.id;
                  int? sectionId  = Get.find<SectionController>().selectedSectionItem?.id;
                  if(classId == null){
                    showCustomSnackBar("select_class".tr);
                  }else{
                    paidInfoController.getUnPaidReport(classId, sectionId);
                  }
                }, text: "search".tr),
              ),
            )
          ]),
        ),
      );
    }
    );
  }
}
