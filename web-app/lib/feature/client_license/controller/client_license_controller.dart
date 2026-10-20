import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/client_license/domain/models/client_license_model.dart';
import 'package:class_compass/feature/client_license/domain/repository/client_license_repository.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';

class ClientLicenseController extends GetxController implements GetxService {
  final ClientLicenseRepository clientLicenseRepository;
  ClientLicenseController({required this.clientLicenseRepository});

  bool isLoading = false;

  ApiResponse<ClientLicenseItem>? licenseModel;
  String selectedStatus = '';

  Future<void> getLicenseList(int offset) async {
    isLoading = true;
    Response? response = await clientLicenseRepository.getLicenseList(offset, status: selectedStatus);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<ClientLicenseItem>.fromJson(
          response?.body, (json) => ClientLicenseItem.fromJson(json));
      if (offset == 1) {
        licenseModel = apiResponse;
      } else {
        licenseModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
        licenseModel?.data?.currentPage = apiResponse.data?.currentPage;
        licenseModel?.data?.total = apiResponse.data?.total;
      }
      isLoading = false;
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  void filterByStatus(String? status) {
    selectedStatus = status ?? '';
    licenseModel = null;
    getLicenseList(1);
  }

  List<ClientLicenseItem> institutes = [];
  List<PackageItem> plans = [];

  Future<void> getDropdownData() async {
    final instituteResponse = await clientLicenseRepository.getInstituteList(1);
    if (instituteResponse?.statusCode == 200) {
      final list = instituteResponse?.body['data']?['data'] as List<dynamic>? ?? [];
      institutes = list
          .map((e) => ClientLicenseItem(
                id: e['id'],
                instituteName: e['name']?.toString(),
              ))
          .toList();
    }

    final planResponse = await clientLicenseRepository.getPlanList(1);
    if (planResponse?.statusCode == 200) {
      final list = planResponse?.body['data']?['data'] as List<dynamic>? ?? [];
      plans = list.map((e) => PackageItem.fromJson(e)).toList();
    }
    update();
  }

  String generatedKey = '';
  Future<String?> generateKey() async {
    Response? response = await clientLicenseRepository.generateLicenseKey();
    if (response?.statusCode == 200) {
      generatedKey = response?.body['data']?['license_key']?.toString() ?? '';
      update();
      return generatedKey;
    }
    ApiChecker.checkApi(response!);
    return null;
  }

  Future<void> createLicense(ClientLicenseBody body) async {
    isLoading = true;
    update();
    Response? response = await clientLicenseRepository.createLicense(body.toJson());
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getLicenseList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateLicense(ClientLicenseBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await clientLicenseRepository.updateLicense(body.toJson(), id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getLicenseList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteLicense(int id) async {
    isLoading = true;
    update();
    Response? response = await clientLicenseRepository.deleteLicense(id);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getLicenseList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> changeStatus(int id) async {
    isLoading = true;
    update();
    Response? response = await clientLicenseRepository.changeStatus(id);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("status_updated_successfully".tr, isError: false);
      getLicenseList(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
