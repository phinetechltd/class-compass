import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:get/get.dart' as get_type;

class ParentPaidInfoRepository{
  final ApiClient apiClient;
  ParentPaidInfoRepository({required this.apiClient});

  Future<Response?> getPaidInfo() async {
    final String? userType = get_type.Get.find<ProfileController>().profileModel?.data?.role;
    if(userType == AppConstants.parent){
      return await apiClient.getData(AppConstants.childrenPaidReport);}
    else {
      return await apiClient.getData(AppConstants.studentPaidReport);
    }
  }

  Future<Response?> getUnPaidInfo() async {
    final String? userType = get_type.Get.find<ProfileController>().profileModel?.data?.role;
    if(userType == AppConstants.parent){
      return await apiClient.getData(AppConstants.childrenUnpaidReport);}
    else {
      return await apiClient.getData(AppConstants.studentUnPaidReport);
    }
  }



}