import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class BulkSmsSettingsWidget extends StatefulWidget {
  const BulkSmsSettingsWidget({super.key});

  @override
  State<BulkSmsSettingsWidget> createState() => _BulkSmsSettingsWidgetState();
}

class _BulkSmsSettingsWidgetState extends State<BulkSmsSettingsWidget> {
  TextEditingController apiKeyController = TextEditingController();
  TextEditingController senderIdController = TextEditingController();

  @override
  void initState() {
    final systemSettings = Get.find<SystemSettingsController>().generalSettingModel?.data;
    apiKeyController.text = systemSettings?.bulkSmsApiKey ?? '';
    senderIdController.text = systemSettings?.bulkSmsSenderId ?? '';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
        builder: (settingsController) {
          return Column(spacing: Dimensions.paddingSizeSmall, children: [
            CustomTitle(title: "bulk_sms_bd".tr, webTitle: true, leftPadding: 0,
                widget: ActiveInActiveWidget(active: settingsController.generalSettingModel?.data?.smsGateway == "bulksmsbd",
                  onChanged: (val){
                    Get.find<SystemSettingsController>().setDefaultSmsGateway("bulksmsbd");
                  },)),
            Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(child: CustomTextField(title: "bulk_sms_api_key".tr,
                  hintText: "bulk_sms_api_key".tr, controller: apiKeyController)),
              Expanded(child: CustomTextField(title: "bulk_sms_sender_id".tr,
                  hintText: "bulk_sms_sender_id".tr, controller: senderIdController))]),


            const SizedBox(height: Dimensions.paddingSizeDefault,),
            Align(alignment: Alignment.centerRight,
                child: SizedBox(width: 130, child: settingsController.loading?
                Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
                CustomButton(onTap: (){

                  String apiKey = apiKeyController.text.trim();
                  String senderId = senderIdController.text.trim();
                  if(apiKey.isEmpty){
                    showCustomSnackBar("api_key_is_empty".tr);
                  }else if(senderId.isEmpty){
                    showCustomSnackBar("sender_id_is_empty".tr);
                  }
                  else{
                    settingsController.updateBulkSmsBd(apiKey, senderId);
                  }

                }, text: "save_settings".tr))),

          ],);
        }
    );
  }
}
