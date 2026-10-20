
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/branch/domain/models/branch_model.dart';
import 'package:class_compass/feature/branch/domain/repository/branch_repository.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/app_constants.dart';

class BranchController extends GetxController implements GetxService{
  final BranchRepository branchRepository;
  BranchController({required this.branchRepository});




  bool isLoading = false;
  BranchModel? branchModel;
  Future<void> getBranchList(int offset) async {
    Response? response = await branchRepository.getBranchList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        branchModel = BranchModel.fromJson(response?.body);
      }else{
        branchModel?.data?.data?.addAll(BranchModel.fromJson(response?.body).data!.data!);
        branchModel?.data?.currentPage = BranchModel.fromJson(response?.body).data?.currentPage;
        branchModel?.data?.total = BranchModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
      if (branchModel != null && Get.find<ProfileController>().currentBranch != null) {
        getBranchNameFromId(int.parse(Get.find<ProfileController>().currentBranch!));
      }
    }else{
      isLoading = false;
      // ApiChecker.checkApi(response!);
    }
    update();
  }

  // need to return the session name from the session id

  String? branchName;
  getBranchNameFromId(int id) {
    if (branchModel != null) {
      final branch = branchModel!.data!.data!.firstWhere((element) => element.id == id, orElse: () => BranchItem(id: -1, name: "Unknown"));
      branchName = branch.name;
    } else {
      branchName = "Unknown";
    }
    update();
  }





  Future<void> createNewBranch( String name) async {
    isLoading = true;
    update();
    Response? response = await branchRepository.createNewBranch(name );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getBranchList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateBranch( String name, int id) async {
    isLoading = true;
    update();
    Response? response = await branchRepository.updateBranch(name,  id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getBranchList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteBranch(int id) async {
    isLoading = true;
    Response? response = await branchRepository.deleteBranch(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getBranchList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> changeBranch(int id) async {
    isLoading = true;
    Response? response = await branchRepository.changeBranch(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("updated_successfully".tr, isError: false);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  BranchItem? selectedBranchItem;
  void selectBranch(BranchItem item, {bool change = false}){
    if(AppConstants.demo && change){
      showCustomSnackBar("Changes are disabled in the demo version.");
    }else{
      selectedBranchItem = item;
      if(change){
        changeBranch(item.id!);
      }
    }

    update();
  }


}