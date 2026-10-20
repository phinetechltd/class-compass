import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/account_management/contra/domain/model/contra_model.dart';
import 'package:class_compass/util/app_constants.dart';

class ContraRepository{
  final ApiClient apiClient;
  ContraRepository({required this.apiClient});


  Future<Response?> contraTransfer(ContraBody body) async {
    return await apiClient.postData(AppConstants.contraTransfer, body.toJson());
  }

}