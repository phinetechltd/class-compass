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

class RazorPayPaymentGatewayCardItem extends StatefulWidget {
  const RazorPayPaymentGatewayCardItem({super.key});

  @override
  State<RazorPayPaymentGatewayCardItem> createState() => _RazorPayPaymentGatewayCardItemState();
}

class _RazorPayPaymentGatewayCardItemState extends State<RazorPayPaymentGatewayCardItem> {

  TextEditingController apiKeyController = TextEditingController();
  TextEditingController apiSecretController = TextEditingController();

  @override
  void initState() {
    apiKeyController.text = Get.find<PaymentGatewayController>().razorPayPaymentGatewayItem?.paymentInfo?.apiKey ?? "";
    apiSecretController.text = Get.find<PaymentGatewayController>().razorPayPaymentGatewayItem?.paymentInfo?.apiSecret ?? "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.razorPayPaymentGatewayItem;
        return paymentGatewayItem != null?
        CustomContainer(borderRadius: Dimensions.radiusSmall,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
              Row(children: [
                Expanded(child: Text('${paymentGatewayItem.name?.toUpperCase().replaceAll("_", " ")}',
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                ActiveInActiveWidget(active: paymentGatewayItem.status == "1",
                    onChanged: (onChanged){
                      saasPaymentGatewayController.paymentGatewayStatusUpdate(paymentGatewayItem.id!);
                    }),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: CustomDivider()),

              const CustomImage( height: 100, image: Images.razorPay, localAsset: true,),



              CustomTextField(title: "api_key".tr,
                controller: apiKeyController,
                hintText: paymentGatewayItem.paymentInfo?.apiKey,),


              CustomTextField(title: "api_secret".tr,
                controller: apiSecretController,
                hintText: paymentGatewayItem.paymentInfo?.apiSecret,),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String apiKey = apiKeyController.text.trim();
                String apiSecret = apiSecretController.text.trim();
                if(apiKey.isEmpty){
                  showCustomSnackBar("api_key_is_empty".tr);
                }
                else if(apiSecret.isEmpty){
                  showCustomSnackBar("api_secret_is_empty".tr);
                }
                else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {
                  saasPaymentGatewayController.editPaymentGateway(PaymentGatewayItem(
                      id: paymentGatewayItem.id,
                      status: paymentGatewayItem.status,
                      paymentInfo: PaymentInfo(apiKey: apiKey, apiSecret: apiSecret),
                      name: paymentGatewayItem.name
                  ));
                }
              }, text: "save".tr))
            ])): const SizedBox();
      }
    );
  }
}
