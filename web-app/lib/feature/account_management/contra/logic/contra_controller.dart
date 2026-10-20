import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/account_management/contra/domain/model/contra_model.dart';
import 'package:class_compass/feature/account_management/contra/domain/repository/contra_repository.dart';


class ContraController extends GetxController implements GetxService{
  final ContraRepository contraRepository;
  ContraController({required this.contraRepository});

  bool isLoading = false;
  Future<void> contraTransfer(ContraBody body) async {
    isLoading = true;
    update();
    Response? response = await contraRepository.contraTransfer(body);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("${response.body["message"]}", isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
  }

}