import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/payment_gateway/domain/model/payment_gateway_model.dart';
import 'package:class_compass/feature/payment_gateway/logic/payment_gateway_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

/// Safaricom M-Pesa Daraja (Lipa na M-Pesa Online / STK push) settings for a school.
class MpesaPaymentGatewayCardItem extends StatefulWidget {
  const MpesaPaymentGatewayCardItem({super.key});

  @override
  State<MpesaPaymentGatewayCardItem> createState() => _MpesaPaymentGatewayCardItemState();
}

class _MpesaPaymentGatewayCardItemState extends State<MpesaPaymentGatewayCardItem> {
  final consumerKeyController = TextEditingController();
  final consumerSecretController = TextEditingController();
  final shortcodeController = TextEditingController();
  final passkeyController = TextEditingController();
  final tillNumberController = TextEditingController();
  final callbackUrlController = TextEditingController();
  String transactionType = 'paybill';
  String environment = 'sandbox';

  @override
  void initState() {
    final info = Get.find<PaymentGatewayController>().mpesaPaymentGatewayItem?.paymentInfo;
    consumerKeyController.text = info?.consumerKey ?? '';
    consumerSecretController.text = info?.consumerSecret ?? '';
    shortcodeController.text = info?.shortcode ?? '';
    passkeyController.text = info?.passkey ?? '';
    tillNumberController.text = info?.tillNumber ?? '';
    callbackUrlController.text = info?.callbackUrl ?? '';
    transactionType = (info?.transactionType == 'till') ? 'till' : 'paybill';
    environment = (info?.environment == 'production') ? 'production' : 'sandbox';
    super.initState();
  }

  Widget _choice(String label, String value, String groupValue, ValueChanged<String> onSelected) {
    final selected = value == groupValue;
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: selected ? Colors.white : null, fontWeight: FontWeight.w600)),
      selected: selected,
      selectedColor: const Color(0xFF00A651),
      checkmarkColor: Colors.white,
      onSelected: (_) => setState(() => onSelected(value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(builder: (controller) {
      PaymentGatewayItem? item = controller.mpesaPaymentGatewayItem;
      if (item == null) return const SizedBox();
      return CustomContainer(borderRadius: Dimensions.radiusSmall,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
          Row(children: [
            Expanded(child: Text('M-PESA (DARAJA)', style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
            ActiveInActiveWidget(active: item.status == "1", onChanged: (_) => controller.paymentGatewayStatusUpdate(item.id!)),
          ]),
          const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall), child: CustomDivider()),
          const CustomImage(height: 34, image: Images.mpesa, localAsset: true),
          Text("mpesa_setup_hint".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          Text("environment".tr, style: textMedium),
          Wrap(spacing: Dimensions.paddingSizeSmall, children: [
            _choice("sandbox".tr, 'sandbox', environment, (v) => environment = v),
            _choice("production".tr, 'production', environment, (v) => environment = v),
          ]),
          Text("account_type".tr, style: textMedium),
          Wrap(spacing: Dimensions.paddingSizeSmall, children: [
            _choice("paybill".tr, 'paybill', transactionType, (v) => transactionType = v),
            _choice("till_buy_goods".tr, 'till', transactionType, (v) => transactionType = v),
          ]),

          CustomTextField(title: "consumer_key".tr, controller: consumerKeyController, hintText: "consumer_key".tr),
          CustomTextField(title: "consumer_secret".tr, controller: consumerSecretController, hintText: "consumer_secret".tr, isPassword: true),
          CustomTextField(title: transactionType == 'till' ? "store_number".tr : "paybill_number".tr,
              controller: shortcodeController, hintText: "174379", inputType: TextInputType.number),
          if (transactionType == 'till')
            CustomTextField(title: "till_number".tr, controller: tillNumberController, hintText: "till_number".tr, inputType: TextInputType.number),
          CustomTextField(title: "passkey".tr, controller: passkeyController, hintText: "passkey".tr, isPassword: true),
          CustomTextField(title: "callback_base_url_optional".tr, controller: callbackUrlController, hintText: "https://api.yourschool.co.ke"),

          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(mainAxisAlignment: MainAxisAlignment.end, spacing: Dimensions.paddingSizeSmall, children: [
            CustomButton(width: 150, showBorderOnly: true, text: controller.testingMpesa ? "testing".tr : "test_connection".tr,
                onTap: controller.testingMpesa ? null : () => controller.testMpesaCredentials()),
            CustomButton(width: 100, text: "save".tr, onTap: () {
              if (consumerKeyController.text.trim().isEmpty) {
                showCustomSnackBar("consumer_key".tr);
              } else if (consumerSecretController.text.trim().isEmpty) {
                showCustomSnackBar("consumer_secret".tr);
              } else if (shortcodeController.text.trim().isEmpty) {
                showCustomSnackBar("paybill_number".tr);
              } else if (passkeyController.text.trim().isEmpty) {
                showCustomSnackBar("passkey".tr);
              } else if (transactionType == 'till' && tillNumberController.text.trim().isEmpty) {
                showCustomSnackBar("till_number".tr);
              } else if (AppConstants.demo) {
                showCustomSnackBar(AppConstants.demoModeMessage.tr);
              } else {
                controller.editPaymentGateway(PaymentGatewayItem(id: item.id, status: item.status, name: item.name,
                    mode: environment == 'production' ? 'live' : 'test',
                    paymentInfo: PaymentInfo(
                      consumerKey: consumerKeyController.text.trim(),
                      consumerSecret: consumerSecretController.text.trim(),
                      shortcode: shortcodeController.text.trim(),
                      passkey: passkeyController.text.trim(),
                      transactionType: transactionType,
                      tillNumber: tillNumberController.text.trim(),
                      environment: environment,
                      callbackUrl: callbackUrlController.text.trim(),
                    )));
              }
            }),
          ]),
        ]),
      );
    });
  }
}
