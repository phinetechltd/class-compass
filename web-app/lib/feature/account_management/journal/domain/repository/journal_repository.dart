import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/account_management/journal/domain/model/journal_body.dart';
import 'package:class_compass/util/app_constants.dart';

class JournalRepository{
  final ApiClient apiClient;
  JournalRepository({required this.apiClient});


  Future<Response?> journalTransfer(JournalBody body) async {
    return await apiClient.postData(AppConstants.journalTransfer, body.toJson());
  }

}