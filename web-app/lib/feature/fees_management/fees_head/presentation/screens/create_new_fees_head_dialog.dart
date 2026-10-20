import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_head/domain/model/fees_head_model.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewFeesHeadDialog extends StatefulWidget {
  final FeesHeadItem? feesHeadItem;
  const CreateNewFeesHeadDialog({super.key, this.feesHeadItem});

  @override
  State<CreateNewFeesHeadDialog> createState() => _CreateNewFeesHeadDialogState();
}

class _CreateNewFeesHeadDialogState extends State<CreateNewFeesHeadDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _serialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.feesHeadItem != null) {
      _nameController.text = widget.feesHeadItem!.name ?? '';
      _serialController.text = widget.feesHeadItem!.serial ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesHeadController>(builder: (feesHeadController) {
      return Column(spacing: Dimensions.paddingSizeDefault, children: [
        CustomTextField(
          title: "name".tr,
          controller: _nameController,
          inputType: TextInputType.text,
          hintText: "enter_name".tr,
        ),


        CustomTextField(
          title: "serial".tr,
          controller: _serialController,
          inputType: TextInputType.number,
          hintText: "enter_serial".tr,
        ),


        CustomButton(
          isLoading: feesHeadController.isLoading,
          text: widget.feesHeadItem != null ? "update".tr : "add".tr,
          onTap: () {
            String name = _nameController.text.trim();
            String serial = _serialController.text.trim();

            if (name.isEmpty) {
              showCustomSnackBar("name_is_required".tr);
            }
            else if (serial.isEmpty) {
              showCustomSnackBar("serial_is_required".tr);
            }

            if (widget.feesHeadItem != null) {
              feesHeadController.updateNewFeesHead(name, serial, widget.feesHeadItem!.id!);
            } else {
              feesHeadController.addNewFeesHead(name, serial);
            }
          },
        ),
      ]);
    });
  }
}
