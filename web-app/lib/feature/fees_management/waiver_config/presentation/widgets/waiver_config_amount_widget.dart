import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/widgets/select_fees_head_widget.dart';
import 'package:class_compass/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:class_compass/feature/fees_management/waiver/presentation/widgets/select_waiver_widget.dart';
import 'package:class_compass/feature/fees_management/waiver_config/controller/waiver_config_controller.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/model/waiver_config_body.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';

class WaiverConfigAmountWidget extends StatefulWidget {
  const WaiverConfigAmountWidget({super.key});

  @override
  State<WaiverConfigAmountWidget> createState() => _WaiverConfigAmountWidgetState();
}

class _WaiverConfigAmountWidgetState extends State<WaiverConfigAmountWidget> {
  TextEditingController waiverAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverConfigController>(builder: (waiverConfigController) {
        return GetBuilder<StudentController>(builder: (studentController) {
            return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeDefault, children: [
                 Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectFeesHeadWidget(title: "fee_head".tr)),
                  const Expanded(child: SelectWaiverWidget()),
                ],),
                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: CustomTextField(
                    controller: waiverAmountController,
                    hintText: "amount".tr,
                    isAmount: true,
                    inputType: TextInputType.number,
                    inputFormatters: [AppConstants.numberFormat],
                  )),

                  SizedBox(width: 90, child: waiverConfigController.isLoading?
                  const Center(child: CircularProgressIndicator()):
                  CustomButton(onTap: (){
                    String amount = waiverAmountController.text.trim();
                    int? feesHeadId = Get.find<FeesHeadController>().selectedFeesHeadItem?.id;
                    int? waiverId = Get.find<WaiverController>().selectedWaiverItem?.id;
                    if(feesHeadId == null){
                      showCustomSnackBar("select_fees_head".tr, isError: true);
                    }else if(waiverId == null){
                      showCustomSnackBar("select_waiver".tr, isError: true);
                    }else if(amount.isEmpty){
                      showCustomSnackBar("enter_amount".tr, isError: true);
                    }else if(GetUtils.isNum(amount) == false){
                      showCustomSnackBar("enter_valid_amount".tr, isError: true);
                    }else{

                      List<int> selectedStudentIds = [];
                       selectedStudentIds = studentController.studentModel!.data!.data!
                          .where((student) => student.isSelected == true)
                          .map((student) => student.id!)
                          .toList();

                      WaiverConfigBody body = WaiverConfigBody(
                        feeHeadId: feesHeadId,
                          students: selectedStudentIds,
                          wavierId: waiverId,
                          waiverAmount: amount);
                      waiverConfigController.waiverConfig(body);
                    }

                  }, text: "confirm".tr))

                ])
              ]),
            );
          }
        );
      }
    );
  }
}
