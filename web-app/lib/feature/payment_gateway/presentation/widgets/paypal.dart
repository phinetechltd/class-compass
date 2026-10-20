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

class PaypalPaymentGatewayCardItem extends StatefulWidget {
  const PaypalPaymentGatewayCardItem({super.key});

  @override
  State<PaypalPaymentGatewayCardItem> createState() => _PaypalPaymentGatewayCardItemState();
}

class _PaypalPaymentGatewayCardItemState extends State<PaypalPaymentGatewayCardItem> {


  TextEditingController clientIdController = TextEditingController();
  TextEditingController clientSecretController = TextEditingController();

  @override
  void initState() {
    clientIdController.text = Get.find<PaymentGatewayController>().payPalPaymentGatewayItem?.paymentInfo?.clientId ?? "";
    clientSecretController.text = Get.find<PaymentGatewayController>().payPalPaymentGatewayItem?.paymentInfo?.clientSecret ?? "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.payPalPaymentGatewayItem;
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

              const CustomImage( height: 50, image: Images.payPal, localAsset: true,),


              CustomTextField(title: "client_id".tr,
                controller: clientIdController,
                hintText: paymentGatewayItem.paymentInfo?.clientId,),

              CustomTextField(title: "client_secret".tr,
                controller: clientSecretController,
                hintText: paymentGatewayItem.paymentInfo?.clientSecret,),


              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight,
                  child: CustomButton(width: 100, onTap: (){
                String clientId = clientIdController.text.trim();
                String clientSecret = clientSecretController.text.trim();

                if(clientId.isEmpty){
                  showCustomSnackBar("client_id_is_empty".tr);
                } else if(clientSecret.isEmpty){
                  showCustomSnackBar("client_secret_is_empty".tr);
                }else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else {
                  saasPaymentGatewayController.editPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem.id,
                      status: paymentGatewayItem.status,
                      paymentInfo: PaymentInfo(clientId: clientId, clientSecret: clientSecret),
                      name: paymentGatewayItem.name));
                }
              }, text: "save".tr))
            ])):const SizedBox();
      }
    );
  }
}
