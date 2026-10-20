import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class FeesReportsRepository {
  final ApiClient apiClient;

  FeesReportsRepository({required this.apiClient});

  Future<Response?> getMonthlyReport({String? year, String? month}) async {
    String query = "?";
    if (year != null) query += "year=$year&";
    if (month != null) query += "month=$month";
    return await apiClient.getData("${AppConstants.monthlyReport}$query");
  }


  Future<Response?> getPaymentFeesInfo({String? startDate, String? endDate, int? classId, int? sectionId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (classId != null) query += "class_id=$classId&";
    if (sectionId != null) query += "section_id=$sectionId&";
    return await apiClient.getData("${AppConstants.paymentFeesInfo}$query");
  }


  Future<Response?> getHeadWisePayment({String? startDate, String? endDate, int? feeHeadId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (feeHeadId != null) query += "fee_head_id=$feeHeadId&";
    return await apiClient.getData("${AppConstants.headWisePayment}$query");
  }


  Future<Response?> getHeadWiseDue({String? startDate, String? endDate, int? feeHeadId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (feeHeadId != null) query += "fee_head_id=$feeHeadId&";
    return await apiClient.getData("${AppConstants.headWiseDue}$query");
  }

  Future<Response?> getClassWisePaymentSummary({String? startDate, String? endDate, int? classId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (classId != null) query += "class_id=$classId&";
    return await apiClient.getData("${AppConstants.classWisePaymentSummary}$query");
  }


  Future<Response?> getUnpaidInfo({int? classId, int? sectionId}) async {
    String query = "?";
    if (classId != null) query += "class_id=$classId&";
    if (sectionId != null) query += "section_id=$sectionId";
    return await apiClient.getData("${AppConstants.unpaidInfo}$query");
  }


  Future<Response?> getPaymentRatioInfo(String year) async {
    String query = "?";
    query += "year=$year";
    return await apiClient.getData("${AppConstants.paymentRatioInfo}$query");
  }


  Future<Response?> getUnpaidSummary({int? classId, int? sectionId}) async {
    String query = "?";
    if (classId != null) query += "class_id=$classId&";
    if (sectionId != null) query += "section_id=$sectionId";
    return await apiClient.getData("${AppConstants.unpaidSummery}$query");
  }


  Future<Response?> getPaidInvoice({String? startDate, String? endDate, int? studentId}) async {
    String query = "?";
    if (startDate != null) query += "start_date=$startDate&";
    if (endDate != null) query += "end_date=$endDate&";
    if (studentId != null) query += "student_id=$studentId&";
    return await apiClient.getData("${AppConstants.paidInvoice}$query");
  }
}
  