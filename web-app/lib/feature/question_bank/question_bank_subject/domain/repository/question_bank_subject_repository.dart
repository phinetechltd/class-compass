import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_body.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionBankSubjectRepository {
  final ApiClient apiClient;

  QuestionBankSubjectRepository({required this.apiClient});
  
  Future<Response?> getQuestionBankSubject(int page) async {
    return await apiClient.getData("${AppConstants.questionBankSubject}?perPage=10&page=$page");
  }

  Future<Response?> createQuestionBankSubject(QuestionBankSubjectBody body) async {
    return await apiClient.postData(AppConstants.questionBankSubject, body.toJson());
  }

  Future<Response?> editQuestionBankSubject(QuestionBankSubjectBody body, int id) async {
    return await apiClient.postData("${AppConstants.questionBankSubject}/$id", body.toJson());
  }

  Future<Response?> deleteQuestionBankSubject(int id) async {
    return await apiClient.deleteData("${AppConstants.questionBankSubject}/$id");
  }
}
  