import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/sms/purchase_sms/domain/models/purchase_sms_body.dart';
import 'package:class_compass/util/app_constants.dart';

class PurchaseSmsRepository{
  final ApiClient apiClient;
  PurchaseSmsRepository({required this.apiClient});


  Future<Response?> getPurchaseSmsList(int page) async {
    return await apiClient.getData("${AppConstants.smsPurchase}?per_page=20&page=$page");
  }

  Future<Response?> createPurchaseSms(PurchaseSmsBody purchaseSmsBody) async {
    return await apiClient.postData(AppConstants.smsPurchase, purchaseSmsBody.toJson());
  }

  Future<Response?> updatePurchaseSms(PurchaseSmsBody purchaseSmsBody, int id) async {
    return await apiClient.putData("${AppConstants.smsPurchase}/$id", purchaseSmsBody.toJson());
  }
  

  Future<Response?> deletePurchaseSms (int id) async {
    return await apiClient.deleteData("${AppConstants.smsPurchase}/$id");
  }
}