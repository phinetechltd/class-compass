
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/absent_fine_body.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/absent_fine_model.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/fees_body.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/fees_model.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/repository/fees_repository.dart';

class FeesController extends GetxController implements GetxService{
  final FeesRepository feesRepository;
  FeesController({required this.feesRepository});

  FeesModel? feesModel;
  Future<void> getFeesList(int page) async {
    Response? response = await feesRepository.getFeesList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        feesModel = FeesModel.fromJson(response?.body);
      }else{
        feesModel?.data?.data?.addAll(FeesModel.fromJson(response?.body).data!.data!);
        feesModel?.data?.currentPage = FeesModel.fromJson(response?.body).data?.currentPage;
        feesModel?.data?.total = FeesModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  int feesTypeIndex = 0;
  void setSelectedFeesTypeIndex(int typeIndex){
    feesTypeIndex = typeIndex;
    update();
  }


  bool isLoading = false;
  Future<void> addNewFees(FeesBody feesBody) async {
    isLoading = true;
    update();
    Response? response = await feesRepository.addNewFees(feesBody);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getFeesList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }


  ApiResponse<AbsentFineItem>? absentFineModel;
  Future<void> getAbsentFineList(int page) async {
    Response? response = await feesRepository.getAbsentFineList(page);
    if(response?.statusCode == 200){
      final apiResponse = ApiResponse<AbsentFineItem>.fromJson(
          response?.body, (json) => AbsentFineItem.fromJson(json));
      if(page == 1){
        absentFineModel = apiResponse;
      }else{
        absentFineModel?.data?.data?.addAll(apiResponse.data?.data??[]);
        absentFineModel?.data?.currentPage = apiResponse.data?.currentPage;
        absentFineModel?.data?.total = apiResponse.data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> addNewAbsentFine(AbsentFineBody body) async {
    isLoading = true;
    update();
    Response? response = await feesRepository.addNewAbsentFine(body);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAbsentFineList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }
  Future<void> updateFeesDate(AbsentFineBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await feesRepository.updateFeesDate(body, id);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAbsentFineList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }
  Future<void> deleteFeesDate(int id) async {
    isLoading = true;
    update();
    Response? response = await feesRepository.deleteFeesDate(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAbsentFineList(1);
      isLoading = false;
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


}