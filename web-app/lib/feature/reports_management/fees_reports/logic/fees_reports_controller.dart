import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/fees_monthly_report_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/fees_payment_info_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/fees_head_wise_report_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/payment_ratio_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/unpaid_summery_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/repository/fees_reports_repository.dart';

class FeesReportsController extends GetxController implements GetxService {
  final FeesReportsRepository feesReportsRepository;
  FeesReportsController({required this.feesReportsRepository});


  bool _isLoading = false;
  bool get isLoading => _isLoading;


  FeesMonthlyReportModel? feesMonthlyReportModel;
  FeesPaymentInfoReportModel? feesPaymentInfoModel;
  FeesHeadWiseReportModel? feesHeadWiseModel;
  FeesPaymentInfoReportModel? unpaidFeesModel;


  Future<void> getMonthlyReport({String? year, String? month}) async {
    Response? response = await feesReportsRepository.getMonthlyReport(year: year, month: month);
    if (response?.statusCode == 200) {
      feesMonthlyReportModel = FeesMonthlyReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Payment Fees Info
  Future<void> getPaymentFeesInfo({String? startDate, String? endDate, int? classId, int? sectionId}) async {
    Response? response = await feesReportsRepository.getPaymentFeesInfo(
      startDate: startDate, endDate: endDate, classId: classId, sectionId: sectionId);
    if (response?.statusCode == 200) {
      feesPaymentInfoModel = FeesPaymentInfoReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  // Head Wise Payment
  Future<void> getHeadWisePayment({String? startDate, String? endDate, int? feeHeadId}) async {
    _isLoading = true;
    update();

    Response? response = await feesReportsRepository.getHeadWisePayment(
      startDate: startDate,
      endDate: endDate,
      feeHeadId: feeHeadId,
    );

    if (response?.statusCode == 200) {
      feesHeadWiseModel = FeesHeadWiseReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }

    _isLoading = false;
    update();
  }

  // Head Wise Due
  Future<void> getHeadWiseDue({String? startDate, String? endDate, int? feeHeadId}) async {
    _isLoading = true;
    update();

    Response? response = await feesReportsRepository.getHeadWiseDue(
      startDate: startDate,
      endDate: endDate,
      feeHeadId: feeHeadId,
    );

    if (response?.statusCode == 200) {

    } else {
      ApiChecker.checkApi(response!);
    }

    _isLoading = false;
    update();
  }

  // Class Wise Payment Summary
  Future<void> getClassWisePaymentSummary({String? startDate, String? endDate, int? classId}) async {
    _isLoading = true;
    update();

    Response? response = await feesReportsRepository.getClassWisePaymentSummary(
      startDate: startDate,
      endDate: endDate,
      classId: classId,
    );

    if (response?.statusCode == 200) {
      //classWisePaymentSummaryModel = ClassWisePaymentSummaryModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }

    _isLoading = false;
    update();
  }


  Future<void> getUnpaidInfo({int? classId, int? sectionId, int? feeHeadId}) async {
    Response? response = await feesReportsRepository.getUnpaidInfo(classId: classId, sectionId: sectionId);
    if (response?.statusCode == 200) {
      unpaidFeesModel = FeesPaymentInfoReportModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  PaymentRatioModel? paymentRatioModel;
  Future<void> getPaymentRatioInfo(String ration) async {
    _isLoading = true;
    update();
    Response? response = await feesReportsRepository.getPaymentRatioInfo(ration);
    if (response?.statusCode == 200) {
      paymentRatioModel = PaymentRatioModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    _isLoading = false;
    update();
  }


  UnPaidSummeryModel? unpaidSummeryModel;
  Future<void> getUnpaidSummary({int? classId, int? sectionId}) async {
    _isLoading = true;
    update();
    Response? response = await feesReportsRepository.getUnpaidSummary(classId: classId, sectionId: sectionId);
    if (response?.statusCode == 200) {
      unpaidSummeryModel = UnPaidSummeryModel.fromJson(response?.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    _isLoading = false;
    update();
  }


  Future<void> getPaidInvoice({String? startDate, String? endDate, int? studentId}) async {
    _isLoading = true;
    update();
    Response? response = await feesReportsRepository.getPaidInvoice(
      startDate: startDate,
      endDate: endDate,
      studentId: studentId,
    );
    if (response?.statusCode == 200) {
    } else {
      ApiChecker.checkApi(response!);
    }
    _isLoading = false;
    update();
  }

  void clearAllData() {
    update();
  }
}
  