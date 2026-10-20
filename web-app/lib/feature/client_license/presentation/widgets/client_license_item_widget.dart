import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/client_license/controller/client_license_controller.dart';
import 'package:class_compass/feature/client_license/domain/models/client_license_model.dart';
import 'package:class_compass/feature/client_license/presentation/widgets/create_client_license_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ClientLicenseItemWidget extends StatelessWidget {
  final ClientLicenseItem? licenseItem;
  final int index;
  const ClientLicenseItemWidget({super.key, this.licenseItem, required this.index});

  Color _statusColor() {
    switch (licenseItem?.status) {
      case 'active':
        return Colors.green;
      case 'suspended':
        return Colors.orange;
      case 'revoked':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: _statusColor(),
      ),
      child: Text(
        (licenseItem?.status ?? 'active').tr,
        style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = EditDeleteSection(
      horizontal: true,
      onEdit: () => Get.dialog(CustomDialogWidget(
        title: "client_license".tr,
        child: CreateClientLicenseWidget(licenseItem: licenseItem),
      )),
      onDelete: () => Get.dialog(ConfirmationDialog(
        title: "client_license",
        content: "client_license",
        onTap: () {
          Get.back();
          Get.find<ClientLicenseController>().deleteLicense(licenseItem!.id!);
        },
      )),
      onChange: licenseItem?.status == 'revoked'
          ? null
          : (value) => Get.find<ClientLicenseController>().changeStatus(licenseItem!.id!),
      actionValue: licenseItem?.status == 'active',
    );

    if (ResponsiveHelper.isDesktop(context)) {
      return Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text: licenseItem?.instituteName ?? 'N/A')),
        Expanded(child: CustomItemTextWidget(text: licenseItem?.planName ?? 'N/A')),
        Expanded(child: CustomItemTextWidget(text: licenseItem?.licenseKey ?? 'N/A')),
        Expanded(child: CustomItemTextWidget(text: licenseItem?.expiresAt ?? 'N/A')),
        Expanded(child: Align(alignment: Alignment.centerLeft, child: _statusBadge())),
        actions,
      ]);
    }

    return CustomContainer(
      borderRadius: Dimensions.paddingSizeExtraSmall,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
          NumberingWidget(index: index),
          Expanded(child: Text(licenseItem?.instituteName ?? 'N/A',
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
          actions,
        ]),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        CustomItemTextWidget(text: "${"plan".tr}: ${licenseItem?.planName ?? 'N/A'}"),
        CustomItemTextWidget(text: "${"license_key".tr}: ${licenseItem?.licenseKey ?? 'N/A'}"),
        CustomItemTextWidget(text: "${"expiry_date".tr}: ${licenseItem?.expiresAt ?? 'N/A'}"),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        _statusBadge(),
      ]),
    );
  }
}
