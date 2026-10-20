import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ParentLibraryRepository{
  final ApiClient apiClient;
  ParentLibraryRepository({required this.apiClient});

  Future<Response?> getLibraryHistoryList() async {
    return await apiClient.getData(AppConstants.libraryHistory);
  }
}