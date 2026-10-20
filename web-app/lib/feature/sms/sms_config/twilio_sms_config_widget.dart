
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class TwilioSmsSettingsWidget extends StatefulWidget {
  const TwilioSmsSettingsWidget({super.key});

  @override
  State<TwilioSmsSettingsWidget> createState() => _TwilioSmsSettingsWidgetState();
}

class _TwilioSmsSettingsWidgetState extends State<TwilioSmsSettingsWidget> {
  TextEditingController idController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    final systemSettings = Get.find<SystemSettingsController>().generalSettingModel?.data;
    idController.text = systemSettings?.twilioSid ?? '';
    tokenController.text = systemSettings?.twilioToken ?? '';
    numberController.text = systemSettings?.twilioFromNumber ?? '';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
        builder: (settingsController) {
          return Column(spacing: Dimensions.paddingSizeSmall, children: [
            CustomTitle(title: "twilio".tr, webTitle: true, leftPadding: 0,
                widget: ActiveInActiveWidget(active: settingsController.generalSettingModel?.data?.smsGateway == "twilio",
                  onChanged: (val){
                    Get.find<SystemSettingsController>().setDefaultSmsGateway("twilio");
                  },)),
            Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(
                child: CustomTextField(title: "twilio_sid".tr,
                    hintText: "twilio_sid".tr, controller: idController),
              ),
              Expanded(
                child: CustomTextField(title: "twilio_token".tr,
                    hintText: "twilio_token".tr, controller: tokenController),
              ),
              Expanded(
                  child: CustomTextField(title: "twilio_from_number".tr,
                      hintText: "twilio_from_number".tr, controller: numberController))]),





            const SizedBox(height: Dimensions.paddingSizeDefault,),
            Align(alignment: Alignment.centerRight,
                child: SizedBox(width: 130, child: settingsController.loading?
                Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
                CustomButton(onTap: (){
                  String id = idController.text;
                  String token = tokenController.text;
                  String number = numberController.text;
                  if(id.isEmpty){
                    showCustomSnackBar("id_is_empty".tr);
                  }else if(token.isEmpty){
                    showCustomSnackBar("token_is_empty".tr);
                  }else if (number.isEmpty){
                    showCustomSnackBar("number_is_empty".tr);
                  }else{
                    settingsController.updateTwilioConfig(id, token, number);
                  }
                }, text: "save_settings".tr))),

          ],);
        }
    );
  }
}
