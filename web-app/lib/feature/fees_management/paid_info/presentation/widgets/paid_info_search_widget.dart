import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class PaidInfoSearchWidget extends StatelessWidget {
  const PaidInfoSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: GetBuilder<PaidInfoController>(
        builder: (controller) {
          return CustomContainer(
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeDefault,children: [
            const Expanded(child: SelectClassWidget()),
              Expanded(child: DateSelectionWidget(title: "from_date".tr)),
              Expanded(child: DateSelectionWidget(end: true, title: "to_date".tr)),
              SizedBox(width: 90,
                child: controller.isLoading?
                const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){
                int? classId = Get.find<ClassController>().selectedClassItem?.id;

                if(classId == null){
                  showCustomSnackBar("select_class".tr);
                  return;
                }else {
                  Get.find<PaidInfoController>().getPaidFeeInfoList(
                    classId,
                      Get.find<DatePickerController>().formatedDate,
                      Get.find<DatePickerController>().formatedEndDate);
                }
              }, text: "search"),),
            ]),
          );
        }
      ),
    );
  }
}
