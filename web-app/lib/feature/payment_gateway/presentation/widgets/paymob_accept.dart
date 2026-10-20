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

class PaymobAcceptPaymentGatewayCardItem extends StatefulWidget {
  const PaymobAcceptPaymentGatewayCardItem({super.key});

  @override
  State<PaymobAcceptPaymentGatewayCardItem> createState() => _PaymobAcceptPaymentGatewayCardItemState();
}

class _PaymobAcceptPaymentGatewayCardItemState extends State<PaymobAcceptPaymentGatewayCardItem> {

  TextEditingController apiKeyController = TextEditingController();
  TextEditingController integrationIdController = TextEditingController();
  TextEditingController iframeIdController = TextEditingController();
  TextEditingController hmacSecretController = TextEditingController();
  TextEditingController paymentGatewayTitleController = TextEditingController();
  TextEditingController supportedCountryController = TextEditingController();


  @override
  void initState() {
    final controller = Get.find<PaymentGatewayController>();
    final item = controller.paymobAcceptPaymentGatewayItem;
    final info = item?.paymentInfo;
    apiKeyController.text = info?.apiKey ?? "";
    integrationIdController.text = info?.integrationId ?? "";
    iframeIdController.text = info?.iframeId ?? "";
    hmacSecretController.text = info?.hmacSecret ?? "";
    paymentGatewayTitleController.text = item?.name ?? "";
    supportedCountryController.text = info?.supportedCountry ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.paymobAcceptPaymentGatewayItem;
        return paymentGatewayItem != null?
        CustomContainer(borderRadius: Dimensions.radiusSmall,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Dimensions.paddingSizeExtraSmall, children: [
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

               const CustomImage( height: 50, image: Images.payMob, localAsset: true),

              CustomTextField(title: "api_key".tr,
                controller: apiKeyController,
                hintText: paymentGatewayItem.paymentInfo?.accessToken,),

              CustomTextField(title: "integration_id".tr,
                controller: integrationIdController,
                hintText: paymentGatewayItem.paymentInfo?.clientId,),

              CustomTextField(title: "iframe_id".tr,
                controller: iframeIdController,
                hintText: paymentGatewayItem.paymentInfo?.clientSecret,),

              CustomTextField(title: "hmac_secret".tr,
                controller: hmacSecretController,
                hintText: paymentGatewayItem.paymentInfo?.apiKey,),

              CustomTextField(title: "supported_country".tr,
                controller: supportedCountryController,
                hintText: paymentGatewayItem.paymentInfo?.publishedKey,),


              CustomTextField(title: "payment_gateway_title".tr,
                controller: paymentGatewayTitleController,
                hintText: paymentGatewayItem.name,),

              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight,
                  child: CustomButton(width: 100, onTap: (){
                String apiKey = apiKeyController.text.trim();
                String integrationId = integrationIdController.text.trim();
                String iframeId = iframeIdController.text.trim();
                String hmacSecret = hmacSecretController.text.trim();
                String supportedCountry = supportedCountryController.text.trim();

                if(apiKey.isEmpty){
                  showCustomSnackBar("api_key_is_empty".tr);
                }
                else if(integrationId.isEmpty){
                  showCustomSnackBar("integration_id_is_empty".tr);
                }
                else if(iframeId.isEmpty){
                  showCustomSnackBar("iframe_id_is_empty".tr);
                }
                else if(hmacSecret.isEmpty){
                  showCustomSnackBar("hmac_secret_is_empty".tr);
                }

                else if(supportedCountry.isEmpty){
                  showCustomSnackBar("supported_country_is_empty".tr);
                }else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {
                  saasPaymentGatewayController.editPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem.id,
                    status: paymentGatewayItem.status,
                    paymentInfo: PaymentInfo(apiKey: apiKey,
                      integrationId: integrationId,
                      iframeId: iframeId,
                      hmacSecret: hmacSecret,
                      supportedCountry: supportedCountry,

                    ),
                  ));
                }
              }, text: "save".tr))
            ])):const SizedBox();
      }
    );
  }
}
