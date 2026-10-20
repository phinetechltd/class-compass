import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:class_compass/feature/sms/sms_template/domain/models/sms_template_model.dart';
import 'package:class_compass/util/dimensions.dart';

class SelectSmsTemplateWidget extends StatefulWidget {
  const SelectSmsTemplateWidget({super.key});

  @override
  State<SelectSmsTemplateWidget> createState() => _SelectSmsTemplateWidgetState();
}

class _SelectSmsTemplateWidgetState extends State<SelectSmsTemplateWidget> {
  @override
  void initState() {
    super.initState();
    if (Get.find<SmsTemplateController>().smsTemplateModel == null) {
      Get.find<SmsTemplateController>().getSmsTemplateList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: Dimensions.paddingSizeDefault),
      const CustomTitle(title: "template"),
      GetBuilder<SmsTemplateController>(builder: (templateController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:  CustomGenericDropdown<SmsTemplateItem>(
            title: "select_template",
            items: templateController.smsTemplateModel?.data ?? [],
            selectedValue: templateController.selectedSmsTemplateItem,
            onChanged: (val) {
              templateController.setSelectedItem(val!);
            },
            getLabel: (item) => item.name ?? '',
          ),
        );
      }
      ),
    ],
    );
  }
}
