import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class ParentNoticeRepository{
  final ApiClient apiClient;
  ParentNoticeRepository({required this.apiClient});


  Future<Response?> getNoticeList(int page) async {
    return await apiClient.getData("${AppConstants.childrenStudentNotices}?page=$page&perPage=10");
  }


}