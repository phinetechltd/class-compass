import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/account_management/fund_transfer/domain/model/fund_transfer_body.dart';
import 'package:class_compass/util/app_constants.dart';

class FundTransferRepository{
  final ApiClient apiClient;
  FundTransferRepository({required this.apiClient});


  Future<Response?> fundTransfer(FundTransferBody body) async {
    return await apiClient.postData(AppConstants.fundTransfer, body.toJson());
  }

}