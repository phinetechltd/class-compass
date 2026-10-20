import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';
import 'package:class_compass/feature/sms/sms_template/domain/models/sms_template_model.dart';
import 'package:class_compass/feature/sms/sms_template/domain/repository/sms_template_repository.dart';

class SmsTemplateController extends GetxController implements GetxService{
  final SmsTemplateRepository smsTemplateRepository;
  SmsTemplateController({required this.smsTemplateRepository});




  bool isLoading = false;
  SmsTemplateModel? smsTemplateModel;
  Future<void> getSmsTemplateList() async {
    Response? response = await smsTemplateRepository.getSmsTemplateList();
    if (response?.statusCode == 200) {
      smsTemplateModel = SmsTemplateModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  SmsTemplateItem? selectedSmsTemplateItem;
  void setSelectedItem(SmsTemplateItem item) {
    selectedSmsTemplateItem = item;
    Get.find<SentSmsController>().setPredefinedTemplate();
    update();
  }


  Future<void> createNewSmsTemplate( String name, String description,) async {
    isLoading = true;
    update();
    Response? response = await smsTemplateRepository.createSmsTemplate(name, description );
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSmsTemplateList();

    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }

  Future<void> updateSmsTemplate( String name, String description, int id) async {
    isLoading = true;
    update();
    Response? response = await smsTemplateRepository.updateSmsTemplate(name, description, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getSmsTemplateList();
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteSmsTemplate(int id) async {
    isLoading = true;
    Response? response = await smsTemplateRepository.deleteDepartment(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getSmsTemplateList();
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }
}