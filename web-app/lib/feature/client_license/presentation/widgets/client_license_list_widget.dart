import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/feature/client_license/controller/client_license_controller.dart';
import 'package:class_compass/feature/client_license/domain/models/client_license_model.dart';
import 'package:class_compass/feature/client_license/presentation/widgets/client_license_item_widget.dart';
import 'package:class_compass/feature/client_license/presentation/widgets/create_client_license_widget.dart';

class ClientLicenseListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ClientLicenseListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientLicenseController>(
      initState: (val) {
        Get.find<ClientLicenseController>().getLicenseList(1);
        Get.find<ClientLicenseController>().getDropdownData();
      },
      builder: (clientLicenseController) {
        final licenseModel = clientLicenseController.licenseModel;
        final licenseData = licenseModel?.data;

        return GenericListSection<ClientLicenseItem>(
          sectionTitle: "client_licenses".tr,
          pathItems: ["client_licenses".tr],
          addNewTitle: "add_new_client_license".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "client_license".tr,
            child: const CreateClientLicenseWidget(),
          )),
          headings: const [
            "institute",
            "plan",
            "license_key",
            "expiry_date",
            "status",
          ],
          scrollController: scrollController,
          isLoading: licenseModel == null,
          totalSize: licenseData?.total ?? 0,
          offset: licenseData?.currentPage ?? 0,
          onPaginate: (offset) async =>
              await clientLicenseController.getLicenseList(offset ?? 1),
          items: licenseData?.data ?? [],
          topWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SizedBox(
              width: 220,
              child: CustomGenericDropdown<String>(
                title: "all_status".tr,
                items: const ['', 'active', 'expired', 'suspended', 'revoked'],
                selectedValue: clientLicenseController.selectedStatus,
                getLabel: (item) => item.isEmpty ? "all_status".tr : item.tr,
                onChanged: (value) =>
                    clientLicenseController.filterByStatus(value),
              ),
            ),
          ),
          itemBuilder: (item, index) => ClientLicenseItemWidget(
            index: index,
            licenseItem: item,
          ),
        );
      },
    );
  }
}
