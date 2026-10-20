
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/paid_report_model.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/repository/paid_info_repository.dart';

class PaidInfoController extends GetxController implements GetxService{
  final PaidInfoRepository paidInfoRepository;
  PaidInfoController({required this.paidInfoRepository});


  bool isLoading = false;
  PaidReportModel? paidReportModel;
  Future<void> getPaidFeeInfoList(int classId, String from, String to) async {
    isLoading = true;
    update();
    Response? response = await paidInfoRepository.getPaidInfo(classId, from, to);
    if(response?.statusCode == 200){
      paidReportModel = PaidReportModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }

  UnPaidReportModel? unPaidReportModel;
  Future<void> getUnPaidReport(int classId, int? sectionId) async {
    isLoading = true;
    update();
    Response? response = await paidInfoRepository.getUnPaidInfo(classId, sectionId);
    if (response?.statusCode == 200) {
      isLoading = false;
      unPaidReportModel  = UnPaidReportModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
      isLoading = false;
    }
    update();
  }

}