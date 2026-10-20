import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/account_management/fund_transfer/domain/model/fund_transfer_body.dart';
import 'package:class_compass/feature/account_management/fund_transfer/domain/repository/fund_transfer_repository.dart';


class FundTransferController extends GetxController implements GetxService{
  final FundTransferRepository fundTransferRepository;
  FundTransferController({required this.fundTransferRepository});

  bool isLoading = false;
  Future<void> fundTransfer(FundTransferBody body) async {
    isLoading = true;
    update();
    Response? response = await fundTransferRepository.fundTransfer(body);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("transferred_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();
  }

}