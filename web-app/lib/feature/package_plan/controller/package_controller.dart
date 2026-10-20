import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';
import 'package:class_compass/feature/package_plan/domain/models/saas_payment_gateway_model.dart';
import 'package:class_compass/feature/package_plan/domain/repository/package_repository.dart';

class PackageController extends GetxController implements GetxService{
  final PackageRepository packageRepository;
  PackageController({required this.packageRepository});




  bool isLoading = false;
  ApiResponse<PackageItem>? packageModel;
  Future<void> getPackageList(int offset) async {
    Response? response = await packageRepository.getPackageList(offset);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<PackageItem>.fromJson(response?.body, (json)=> PackageItem.fromJson(json));
      if(offset == 1){
        packageModel = apiResponse;
      }else{
        packageModel?.data?.data?.addAll(apiResponse.data!.data!);
        packageModel?.data?.currentPage = apiResponse.data?.currentPage;
        packageModel?.data?.total = apiResponse.data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }



  TextEditingController extraDaysController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  PackageItem? selectedPackageItem;
  int? selectedPackageIndex;
  void selectPackage(PackageItem item, int index){
    selectedPackageItem = item;
    selectedPackageIndex = index;
    amountController.text = selectedPackageItem?.price?.toString()??"0";
    extraDaysController.text = selectedPackageItem?.durationDays?.toString() ??"0";
    update();
  }

  Future<void> updateSubscriptionPlan(int planId, int instituteId, {bool fromUpdate = false}) async {
    isLoading = true;
    Response? response = await packageRepository.subscriptionPlanUpdate(planId, instituteId);
    if (response?.statusCode == 200) {
      showCustomSnackBar("request_sent_successfully".tr, isError: false);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  SaasPaymentGatewayModel? saasPaymentGatewayModel;
  PaymentGatewayItem? payStackPaymentGatewayItem;
  PaymentGatewayItem? razorPayPaymentGatewayItem;
  PaymentGatewayItem? stripePaymentGatewayItem;
  PaymentGatewayItem? payPalPaymentGatewayItem;
  PaymentGatewayItem? sslCommerzPaymentGatewayItem;
  PaymentGatewayItem? paymobAcceptPaymentGatewayItem;
  PaymentGatewayItem? flutterWavePaymentGatewayItem;
  PaymentGatewayItem? senangPayPaymentGatewayItem;
  PaymentGatewayItem? payTmPaymentGatewayItem;
  PaymentGatewayItem? bKashPaymentGatewayItem;
  Future<void> getSaasPaymentGateway() async {
    Response? response = await packageRepository.getSaasPaymentGateway();
    if (response?.statusCode == 200) {
      saasPaymentGatewayModel = SaasPaymentGatewayModel.fromJson(response!.body);

      PaymentGatewayItem? findGatewaySafe(String name) {
        final list = saasPaymentGatewayModel?.data;
        if (list == null) return null;
        for (var item in list) {
          if (item.name == name) return item;
        }
        return null;
      }

      payStackPaymentGatewayItem = findGatewaySafe("paystack");
      razorPayPaymentGatewayItem = findGatewaySafe("razor_pay");
      stripePaymentGatewayItem = findGatewaySafe("stripe");
      payPalPaymentGatewayItem = findGatewaySafe("paypal");
      sslCommerzPaymentGatewayItem = findGatewaySafe("ssl_commerz");
      paymobAcceptPaymentGatewayItem = findGatewaySafe("paymob_accept");
      flutterWavePaymentGatewayItem = findGatewaySafe("flutterwave");
      senangPayPaymentGatewayItem = findGatewaySafe("senang_pay");
      payTmPaymentGatewayItem = findGatewaySafe("paytm");
      bKashPaymentGatewayItem = findGatewaySafe("bkash");

    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  int? selectedIndex;
  String? selectedPaymentType;
  void selectPaymentType(int index, String paymentType) {
    selectedIndex = index;
    selectedPaymentType = paymentType;
    update();
  }


}