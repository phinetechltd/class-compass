import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:class_compass/feature/fees_management/waiver/domain/model/waiver_model.dart';

class SelectWaiverWidget extends StatefulWidget {
  const SelectWaiverWidget({super.key});

  @override
  State<SelectWaiverWidget> createState() => _SelectWaiverWidgetState();
}

class _SelectWaiverWidgetState extends State<SelectWaiverWidget> {
  @override
  void initState() {
    super.initState();
    if (Get.find<WaiverController>().waiverModel == null) {
      Get.find<WaiverController>().getWaiverList(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "waiver"),
      GetBuilder<WaiverController>(builder: (waiverController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:  CustomGenericDropdown<WaiverItem>(
            title: "select".tr,
            items: waiverController.waiverModel?.data?.data ?? [],
            selectedValue: waiverController.selectedWaiverItem,
            onChanged: (val) {
              waiverController.setSelectedWaiverItem(val!);
            },
            getLabel: (item) => item.waiver ?? '',
          ),
        );
      }
      ),
    ],
    );
  }
}
