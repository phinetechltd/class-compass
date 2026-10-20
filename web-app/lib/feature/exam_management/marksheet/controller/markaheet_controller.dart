

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/exam_management/marksheet/domain/model/marksheet_config_body.dart';
import 'package:class_compass/feature/exam_management/marksheet/domain/model/marksheet_config_model.dart';
import 'package:class_compass/feature/exam_management/marksheet/domain/repository/mark_sheet_repository.dart';
import 'package:class_compass/helper/image_size_checker.dart';

class MarkSheetController extends GetxController implements GetxService{
  final MarkSheetRepository marksheetRepository;
  MarkSheetController({required this.marksheetRepository});


  bool isLoading = false;
  ApiResponse<MarkSheetConfigItem>? marksheetConfigModel;
  Future<void> getMarkSheetConfigList(int offset) async {
    Response? response = await marksheetRepository.getMarkSheetConfig(offset);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<MarkSheetConfigItem>.fromJson(response?.body, (json)=>
      MarkSheetConfigItem.fromJson(json));
      if(offset == 1){
        marksheetConfigModel = apiResponse;
      }else{
        marksheetConfigModel?.data?.data?.addAll(apiResponse.data?.data??[]);
        marksheetConfigModel?.data?.currentPage = apiResponse.data?.currentPage;
        marksheetConfigModel?.data?.total = apiResponse.data?.total;
      }
      if(marksheetConfigModel != null && marksheetConfigModel?.data != null
          && marksheetConfigModel?.data?.data != null && marksheetConfigModel!.data!.data!.isNotEmpty){
        setSelectedMarkSheetConfigItem(marksheetConfigModel?.data?.data?.first);
      }

      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  MarkSheetConfigItem? selectedMarkSheetConfigItem;
  void setSelectedMarkSheetConfigItem(MarkSheetConfigItem? item){
    selectedMarkSheetConfigItem = item;
    update();
  }




  Future<void> createNewMarkSheetConfig(MarksheetConfigBody body,) async {
    isLoading = true;
    update();
    Response? response = await marksheetRepository.createNewMarkSheetConfig(body,
        headerLogo, stampImage, borderDesign, watermark);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getMarkSheetConfigList(1);

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateMarkSheetConfig(MarksheetConfigBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await marksheetRepository.updateMarkSheetConfig(body, id,
        headerLogo, stampImage, borderDesign, watermark);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getMarkSheetConfigList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteMarkSheetConfig(int id) async {
    isLoading = true;
    Response? response = await marksheetRepository.deleteMarkSheetConfig(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getMarkSheetConfigList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  XFile? headerLogo, borderDesign, watermark, stampImage;
  XFile? pickedImage;
  void pickImage(String type) async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      if(type == "header"){
      headerLogo = pickedImage;
      }else if(type == "border"){
        borderDesign = pickedImage;
      }else if(type == "watermark"){
        watermark = pickedImage;
      }else if(type == "stampImage"){
        stampImage = pickedImage;
      }
    }
    update();
  }
}