import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/feature/client_license/presentation/widgets/client_license_list_widget.dart';
import 'package:class_compass/feature/client_license/presentation/widgets/create_client_license_widget.dart';

class ClientLicenseScreen extends StatefulWidget {
  const ClientLicenseScreen({super.key});

  @override
  State<ClientLicenseScreen> createState() => _ClientLicenseScreenState();
}

class _ClientLicenseScreenState extends State<ClientLicenseScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "client_licenses".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: ClientLicenseListWidget(scrollController: scrollController),
        ),
      ]),
      floatingActionButton: CustomFloatingButton(
        title: "add",
        onTap: () => Get.dialog(CustomDialogWidget(
          title: "client_license".tr,
          child: const CreateClientLicenseWidget(),
        )),
      ),
    );
  }
}
