import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/staff_attendance_body.dart';
import 'package:class_compass/util/app_constants.dart';

class StaffAttendanceRepository{
  final ApiClient apiClient;
  StaffAttendanceRepository({required this.apiClient});



  Future<Response?> getStaffListForAttendance(String type) async {
    return await apiClient.getData("${AppConstants.typeWiseUserList}$type");
  }

  Future<Response?> getStaffAttendanceList(int page) async {
    return await apiClient.getData("${AppConstants.staffAttendance}?page=$page&per_page=10");
  }

  Future<Response?> createStaffAttendance(StaffAttendanceBody attendanceBody) async {
    return await apiClient.postData(AppConstants.staffAttendance, attendanceBody.toJson());
  }

  Future<Response?> updateStaffAttendance(StaffAttendanceBody attendanceBody, int id) async {
    return await apiClient.putData("${AppConstants.staffAttendance}/$id", attendanceBody.toJson());
  }

  Future<Response?> deleteStaffAttendance (int id) async {
    return await apiClient.deleteData("${AppConstants.staffAttendance}/$id");
  }

  Future<Response?> staffAttendanceReport({ String? fromDate,
    String? toDate}) async {
    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'from_date': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to_date': toDate,
    };
    final uri = Uri.parse(AppConstants.staffAttendanceReport).replace(queryParameters: queryParams);
    return await apiClient.getData(uri.toString());
  }
}