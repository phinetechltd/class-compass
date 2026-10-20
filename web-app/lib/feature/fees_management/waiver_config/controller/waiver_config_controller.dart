
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/fees_management/waiver/domain/model/waiver_model.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/model/waiver_config_body.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/model/waiver_config_model.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/repository/waiver_config_repository.dart';

class WaiverConfigController extends GetxController implements GetxService{
  final WaiverConfigRepository waiverConfigRepository;
  WaiverConfigController({required this.waiverConfigRepository});

  WaiverModel? waiverModel;
  Future<void> getWaiverAssignList(int page) async {
    Response? response = await waiverConfigRepository.getWaiverAssignListList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        waiverModel = WaiverModel.fromJson(response?.body);
      }else{
        waiverModel?.data?.data?.addAll(WaiverModel.fromJson(response?.body).data!.data!);
        waiverModel?.data?.currentPage = WaiverModel.fromJson(response?.body).data?.currentPage;
        waiverModel?.data?.total = WaiverModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  Future<void> waiverConfig(WaiverConfigBody body) async {
    isLoading = true;
    update();
    Response? response = await waiverConfigRepository.waiverConfig(body);
    if(response!.statusCode == 200){
      Get.back();
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getWaiverConfigList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  WaiverConfigModel? waiverConfigModel;
  Future<void> getWaiverConfigList(int page) async {
    Response? response = await waiverConfigRepository.getWaiverConfigList(page);
    if(response!.statusCode == 200){
      waiverConfigModel = WaiverConfigModel.fromJson(response.body);
    }else{
      ApiChecker.checkApi(response);
    }
    update();
  }


  bool isLoading = false;
  int waiverConfigTypeIndex = 0;
  void setSelectedWaiverConfigTypeIndex(int typeIndex){
    waiverConfigTypeIndex = typeIndex;
    update();
  }
}