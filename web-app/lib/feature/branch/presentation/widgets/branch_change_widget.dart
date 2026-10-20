import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/feature/branch/controller/branch_controller.dart';

class ChangeBranchWidget extends StatefulWidget {
  final bool change;
  final String? title;
  const ChangeBranchWidget({super.key, this.change = true, this.title});

  @override
  State<ChangeBranchWidget> createState() => _ChangeBranchWidgetState();
}

class _ChangeBranchWidgetState extends State<ChangeBranchWidget> {
  @override
  void initState() {
    if(Get.find<BranchController>().branchModel == null){
      Get.find<BranchController>().getBranchList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BranchController>(builder: (branchController) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if(widget.title != null)
                Text(widget.title??''),
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomGenericDropdown(width: Get.width,
                  title: "${"branch".tr}: ${branchController.branchName??"".tr}",
                  items: branchController.branchModel?.data?.data??[],
                  selectedValue: branchController.selectedBranchItem,
                  onChanged: (val){
                    branchController.selectBranch(val!, change: widget.change);
                  },
                  getLabel: (item) => item.name ?? '',
                ),),
            ],
          );
        }
    );
  }
}
