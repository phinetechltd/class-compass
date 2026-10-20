import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/account_management/payment/domain/model/payment_body.dart';
import 'package:class_compass/util/app_constants.dart';

class PaymentRepository{
  final ApiClient apiClient;
  PaymentRepository({required this.apiClient});


  Future<Response?> makePayment(PaymentBody paymentBody) async {
    return await apiClient.postData(AppConstants.payment, paymentBody.toJson());
  }

}