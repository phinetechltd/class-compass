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

class BkashPaymentGatewayCardItem extends StatefulWidget {
  const BkashPaymentGatewayCardItem({super.key});

  @override
  State<BkashPaymentGatewayCardItem> createState() => _BkashPaymentGatewayCardItemState();
}

class _BkashPaymentGatewayCardItemState extends State<BkashPaymentGatewayCardItem> {


  TextEditingController appKeyController = TextEditingController();
  TextEditingController appSecretKeyController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController callBackUrlController = TextEditingController();


  @override
  void initState() {
    final paymentInfo = Get.find<PaymentGatewayController>().bKashPaymentGatewayItem?.paymentInfo;
    appKeyController.text = paymentInfo?.appKey ?? "";
    appSecretKeyController.text = paymentInfo?.appSecret ?? "";
    userNameController.text = paymentInfo?.username ?? "";
    passwordController.text = paymentInfo?.password ?? "";
    callBackUrlController.text = paymentInfo?.callbackUrl ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentGatewayController>(
      builder: (saasPaymentGatewayController) {
        PaymentGatewayItem? paymentGatewayItem = saasPaymentGatewayController.bKashPaymentGatewayItem;
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

               CustomContainer(color: Theme.of(context).hintColor,
                   child: const CustomImage( height: 50, image: Images.bKash, localAsset: true,)),


              CustomTextField(title: "app_key".tr,
                controller: appKeyController,
                hintText: paymentGatewayItem.paymentInfo?.appKey,),

              CustomTextField(title: "app_secret".tr,
                controller: appSecretKeyController,
                hintText: paymentGatewayItem.paymentInfo?.appSecret,),



              CustomTextField(title: "user_name".tr,
                controller: userNameController,
                hintText: paymentGatewayItem.paymentInfo?.username,),

              CustomTextField(title: "password".tr,
                controller: passwordController,
                hintText: paymentGatewayItem.paymentInfo?.password),



              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(alignment: Alignment.centerRight, child: CustomButton(width: 100, onTap: (){
                String appKey = appKeyController.text.trim();
                String appSecretKey = appSecretKeyController.text.trim();
                String userName = userNameController.text.trim();
                String password = passwordController.text.trim();
                if(appKey.isEmpty){
                  showCustomSnackBar("app_key_is_empty".tr);
                }
                else if(appSecretKey.isEmpty){
                  showCustomSnackBar("app_secret_is_empty".tr);
                }
                else if(userName.isEmpty){
                  showCustomSnackBar("user_name_is_empty".tr);
                }

                else if(password.isEmpty){
                  showCustomSnackBar("password_is_empty".tr);
                }

                else if(AppConstants.demo) {
                  showCustomSnackBar(AppConstants.demoModeMessage.tr);
                }
                else{
                  saasPaymentGatewayController.editPaymentGateway(PaymentGatewayItem(id: paymentGatewayItem.id,
                      status: paymentGatewayItem.status,
                      name: paymentGatewayItem.name,
                      paymentInfo: PaymentInfo(appKey: appKey, appSecret: appSecretKey, username: userName, password: password)));
                }
              }, text: "save".tr))
            ])): const SizedBox();
      }
    );
  }
}
