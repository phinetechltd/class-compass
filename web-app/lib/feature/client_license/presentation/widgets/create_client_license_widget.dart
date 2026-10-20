import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/client_license/controller/client_license_controller.dart';
import 'package:class_compass/feature/client_license/domain/models/client_license_model.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateClientLicenseWidget extends StatefulWidget {
  final ClientLicenseItem? licenseItem;
  const CreateClientLicenseWidget({super.key, this.licenseItem});

  @override
  State<CreateClientLicenseWidget> createState() => _CreateClientLicenseWidgetState();
}

class _CreateClientLicenseWidgetState extends State<CreateClientLicenseWidget> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _studentLimitController = TextEditingController();
  final TextEditingController _branchLimitController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  ClientLicenseItem? selectedInstitute;
  PackageItem? selectedPlan;
  String selectedStatus = 'active';
  bool update = false;

  @override
  void initState() {
    super.initState();
    if (widget.licenseItem != null) {
      update = true;
      _keyController.text = widget.licenseItem?.licenseKey ?? '';
      _studentLimitController.text = widget.licenseItem?.studentLimit?.toString() ?? '';
      _branchLimitController.text = widget.licenseItem?.branchLimit?.toString() ?? '';
      _notesController.text = widget.licenseItem?.notes ?? '';
      selectedStatus = widget.licenseItem?.status ?? 'active';
      final datePicker = Get.find<DatePickerController>();
      if (widget.licenseItem?.issuedAt != null) {
        datePicker.setDateFromString(widget.licenseItem!.issuedAt!);
      }
      if (widget.licenseItem?.expiresAt != null) {
        datePicker.setEndDateFromString(widget.licenseItem!.expiresAt!);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<ClientLicenseController>();
      if (controller.institutes.isNotEmpty) {
        selectedInstitute = controller.institutes.firstWhereOrNull(
            (e) => e.id == widget.licenseItem?.instituteId);
      }
      if (controller.plans.isNotEmpty) {
        selectedPlan = controller.plans.firstWhereOrNull(
            (e) => e.id == widget.licenseItem?.planId);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientLicenseController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomTitle(title: "client_license"),
          ),
          CustomGenericDropdown<ClientLicenseItem>(
            title: "institute",
            items: controller.institutes,
            selectedValue: selectedInstitute,
            getLabel: (item) => item.instituteName ?? '',
            onChanged: (value) => setState(() => selectedInstitute = value),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          CustomGenericDropdown<PackageItem>(
            title: "plan",
            items: controller.plans,
            selectedValue: selectedPlan,
            getLabel: (item) => item.name ?? '',
            onChanged: (value) {
              setState(() {
                selectedPlan = value;
                if (value != null) {
                  _studentLimitController.text = value.studentLimit?.toString() ?? '';
                  _branchLimitController.text = value.branchLimit?.toString() ?? '';
                }
              });
            },
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(children: [
            Expanded(
              child: CustomTextField(
                title: "license_key".tr,
                controller: _keyController,
                hintText: "license_key".tr,
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              child: CustomButton(
                width: 130,
                height: 40,
                text: "generate".tr,
                onTap: () async {
                  final key = await controller.generateKey();
                  if (key != null) {
                    _keyController.text = key;
                    setState(() {});
                  }
                },
              ),
            ),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          CustomGenericDropdown<String>(
            title: "status",
            items: const ['active', 'expired', 'suspended', 'revoked'],
            selectedValue: selectedStatus,
            getLabel: (item) => item.tr,
            onChanged: (value) => setState(() => selectedStatus = value ?? 'active'),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          const Row(children: [
            Expanded(child: DateSelectionWidget(title: "issue_date")),
            SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: DateSelectionWidget(title: "expiry_date", end: true)),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(children: [
            Expanded(
              child: CustomTextField(
                title: "student_limit".tr,
                controller: _studentLimitController,
                inputType: TextInputType.number,
                hintText: "student_limit".tr,
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(
              child: CustomTextField(
                title: "branch_limit".tr,
                controller: _branchLimitController,
                inputType: TextInputType.number,
                hintText: "branch_limit".tr,
              ),
            ),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          CustomTextField(
            title: "notes".tr,
            controller: _notesController,
            hintText: "enter_notes".tr,
            maxLines: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: update ? "update".tr : "confirm".tr,
                    onTap: () {
                      if (selectedInstitute == null) {
                        showCustomSnackBar("select_institute".tr);
                        return;
                      }
                      final body = ClientLicenseBody(
                        instituteId: selectedInstitute?.id,
                        planId: selectedPlan?.id,
                        licenseKey: _keyController.text.trim(),
                        status: selectedStatus,
                        issuedAt: Get.find<DatePickerController>().formatedDate,
                        expiresAt: Get.find<DatePickerController>().formatedEndDate,
                        studentLimit: _studentLimitController.text.trim(),
                        branchLimit: _branchLimitController.text.trim(),
                        notes: _notesController.text.trim(),
                      );
                      if (update) {
                        controller.updateLicense(body, widget.licenseItem!.id!);
                      } else {
                        controller.createLicense(body);
                      }
                    },
                  ),
          ),
        ]),
      );
    });
  }
}
