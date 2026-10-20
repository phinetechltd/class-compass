import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class GeneralSettingsWidget extends StatefulWidget {
  const GeneralSettingsWidget({super.key});

  @override
  State<GeneralSettingsWidget> createState() => _GeneralSettingsWidgetState();
}

class _GeneralSettingsWidgetState extends State<GeneralSettingsWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController siteTitleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currencySymbolController = TextEditingController();
  TextEditingController examResultController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController eiinController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController transferCertificateController = TextEditingController();
  TextEditingController liveNoticeController = TextEditingController();
  TextEditingController onlineAdmissionDisplayStatusController = TextEditingController();
  TextEditingController examResultDisplayController = TextEditingController();
  TextEditingController appUrlController = TextEditingController();
  TextEditingController appVersionController = TextEditingController();

  @override
  void initState() {
    final systemSettings = Get.find<SystemSettingsController>().generalSettingModel?.data;
    nameController.text = systemSettings?.schoolName ?? '';
    siteTitleController.text = systemSettings?.siteTitle ?? '';
    phoneController.text = systemSettings?.phone ?? '';
    emailController.text = systemSettings?.email ?? '';
    currencySymbolController.text = systemSettings?.currencySymbol ?? '';
    examResultController.text = systemSettings?.examResultPhone ?? '';
    addressController.text = systemSettings?.address ?? '';
    eiinController.text = systemSettings?.eiinCode ?? '';
    instituteController.text = systemSettings?.instituteCode ?? '';
    transferCertificateController.text = systemSettings?.tcAmount ?? '';
    liveNoticeController.text = systemSettings?.headerNotice ?? '';
    onlineAdmissionDisplayStatusController.text = systemSettings?.admissionDisplayStatus ?? '';
    examResultDisplayController.text = systemSettings?.examResultStatus ?? '';
    appUrlController.text = systemSettings?.appUrl ?? '';
    appVersionController.text = systemSettings?.appVersion ?? '';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (settingsController) {
        return Column(spacing: Dimensions.paddingSizeSmall, children: [
          CustomTitle(title: "general".tr, webTitle: true, leftPadding: 0),
          Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(
                child: CustomTextField(title: "institute_name".tr,
                  hintText: "institute_name".tr, controller: nameController),
              ),
              Expanded(
                child: CustomTextField(title: "site_title".tr,
                    hintText: "site_title".tr, controller: siteTitleController))]),


          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "phone".tr,
                  hintText: "phone".tr, controller: phoneController),
            ),
            Expanded(
                child: CustomTextField(title: "currency_symbol".tr,
                    hintText: "currency_symbol".tr,
                    controller: currencySymbolController))]),



          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "exam_result".tr,
                  hintText: "exam_result".tr, controller: examResultController),
            ),
            Expanded(
                child: CustomTextField(title: "email".tr,
                    hintText: "email".tr, controller: emailController))]),



          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "address".tr,
                  hintText: "address".tr, controller: addressController),
            ),
            Expanded(
                child: CustomTextField(title: "eiin".tr,
                    hintText: "eiin".tr, controller: eiinController))]),


          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "institute_id".tr,
                  hintText: "institute_id".tr, controller: instituteController),
            ),
            Expanded(
                child: CustomTextField(title: "transfer_certificate_fee".tr,
                    hintText: "transfer_certificate_fee".tr, controller: transferCertificateController))]),


          CustomTextField(title: "live_notice_on_head".tr,
              minLines: 3, maxLines: 5, maxLength: 500,
              inputType: TextInputType.multiline, inputAction: TextInputAction.newline,
              hintText: "live_notice_on_head".tr, controller: liveNoticeController),

          Row(spacing: Dimensions.paddingSizeSmall, children: [

            Expanded(
                child: CustomTextField(title: "online_admission_display_status".tr,
                    hintText: "online_admission_display_status".tr, controller: onlineAdmissionDisplayStatusController)),
            Expanded(
                child: CustomTextField(title: "exam_result_display_status".tr,
                    hintText: "exam_result_display_status".tr, controller: examResultDisplayController))
          ]),

          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "app_version".tr,
                  hintText: "app_version".tr, controller: appVersionController),
            ),
            Expanded(
                child: CustomTextField(title: "app_url".tr,
                    hintText: "app_url".tr, controller: appUrlController))]),

          const SizedBox(height: Dimensions.paddingSizeDefault,),
          Align(alignment: Alignment.centerRight,
              child: SizedBox(width: 130, child: settingsController.loading?
                  Center(child: CircularProgressIndicator(color: systemPrimaryColor())):
              CustomButton(onTap: (){
                SettingItem body = SettingItem(
                  schoolName: nameController.text,
                  siteTitle: siteTitleController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                  currencySymbol: currencySymbolController.text,
                  examResultPhone: examResultController.text,
                  address: addressController.text,
                  eiinCode: eiinController.text,
                  instituteCode: instituteController.text,
                  tcAmount: transferCertificateController.text,
                  headerNotice: liveNoticeController.text,
                  admissionDisplayStatus: onlineAdmissionDisplayStatusController.text,
                  examResultStatus: examResultDisplayController.text,
                  appVersion: appVersionController.text,
                  appUrl: appUrlController.text,
                );
                log("Here is the Body ==> ${body.toJson()}");
                settingsController.updateGeneralSetting(body);
              }, text: "save_settings".tr))),

        ],);
      }
    );
  }
}
