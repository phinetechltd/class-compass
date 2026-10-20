import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_body.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/domain/repository/hostel_meal_entries_repository.dart';

class HostelMealEntriesController extends GetxController implements GetxService {
  final HostelMealEntriesRepository hostelMealEntriesRepository;
  HostelMealEntriesController({required this.hostelMealEntriesRepository});

  ApiResponse<HostelMealEntryItem>? mealEntryModel;
  Future<void> getHostelMealEntries(int page) async {
    Response? response = await hostelMealEntriesRepository.getHostelMealEntriesList(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<HostelMealEntryItem>.fromJson(response?.body, (json) => HostelMealEntryItem.fromJson(json));
     if(page ==1) {
       mealEntryModel = apiResponse;
     }else{
       mealEntryModel?.data?.data?.addAll(apiResponse.data?.data??[]);
       mealEntryModel?.data?.total = apiResponse.data?.total;
       mealEntryModel?.data?.currentPage = apiResponse.data?.currentPage;
     }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  bool isLoading = false;

  Future<void> createHostelMealEntries(HostelMealEntryBody mealEntryBody) async {
      isLoading = true;
      update();
    Response? response = await hostelMealEntriesRepository.addNewHostelMealEntry(mealEntryBody);
    if (response?.statusCode == 200) {
      Get.back();
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getHostelMealEntries(1);
      
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editHostelMealEntries(int id, HostelMealEntryBody mealEntryBody) async {
      isLoading = true;
      update();
    Response? response = await hostelMealEntriesRepository.updateHostelMealEntry(id, mealEntryBody);
    if (response?.statusCode == 200) {
      Get.back();
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getHostelMealEntries(1);
      
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteHostelMealEntries(int id) async {
    isLoading = true;
    update();
    Response? response = await hostelMealEntriesRepository.deleteHostelMealEntry(id);
    if (response?.statusCode == 200) {
      Get.back();
      isLoading = false;
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getHostelMealEntries(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
  