import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:class_compass/feature/sms/sms_template/domain/models/sms_template_model.dart';
import 'package:class_compass/feature/sms/sms_template/presentation/widgets/sms_template_item_widget.dart';
import 'package:class_compass/feature/sms/sms_template/presentation/screens/create_new_sms_template_screen.dart';

class SmsTemplateListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SmsTemplateListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmsTemplateController>(
      initState: (val) => Get.find<SmsTemplateController>().getSmsTemplateList(),
      builder: (smsTemplateController) {
        final smsTemplateModel = smsTemplateController.smsTemplateModel;
        final smsData = smsTemplateModel?.data;
        return GenericListSection<SmsTemplateItem>(
          sectionTitle: "sms_management".tr,
          pathItems: ["template".tr],
          addNewTitle: "add_new_sms_template".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "template".tr,
              child: const CreateNewSmsTemplateScreen())),
          headings: const ["name", "description", ],
          scrollController: scrollController,
          isLoading: smsTemplateModel == null,
          totalSize: 0,
          offset: 0,
          onPaginate: (offset) async => await smsTemplateController.getSmsTemplateList(),
          items: smsData ?? [],
          itemBuilder: (item, index) => SmsTemplateItemWidget(index: index, smsTemplateItem: item),
        );
      },
    );
  }
}
