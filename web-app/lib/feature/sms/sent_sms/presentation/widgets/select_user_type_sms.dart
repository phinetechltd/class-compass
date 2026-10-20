import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';

class SelectUserTypeSms extends StatelessWidget {
  const SelectUserTypeSms({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SentSmsController>(
      builder: (smsController) {
        return Column(children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomDropdown(width: Get.width, title: "select".tr,
              items: smsController.userTypesForSms,
              selectedValue: smsController.selectedUserType,
              onChanged: (val){
                smsController.changeUserType(val!);
              },
            ),),
        ],);
      }
    );
  }
}
