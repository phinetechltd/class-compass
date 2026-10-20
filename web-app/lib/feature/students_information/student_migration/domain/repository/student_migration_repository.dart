import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/students_information/student_migration/domain/models/migration_body.dart';
import 'package:class_compass/util/app_constants.dart';

class StudentMigrationRepository{
  final ApiClient apiClient;
  StudentMigrationRepository({required this.apiClient});


  Future<Response?> getStudentForMigration(int classId, int sectionId) async {
    return await apiClient.getData("${AppConstants.getStudentForMigration}?class_id=$classId&section_id=$sectionId");
  }

  Future<Response?> getMigrationList(int classId, int? sectionId) async {
    return await apiClient.getData("${AppConstants.geMigrationList}?section_id=$sectionId&class_id=$classId");
  }

  Future<Response?> studentMigration(MigrationBody body) async {
    return await apiClient.postData(AppConstants.studentMigration, body.toJson());
  }

  Future<Response?> studentBranchMigration(int studentId, int branchId) async {
    return await apiClient.postData(AppConstants.studentBranchMigration, {
      "student_id": studentId,
      "branch_id": branchId
    });
  }

}