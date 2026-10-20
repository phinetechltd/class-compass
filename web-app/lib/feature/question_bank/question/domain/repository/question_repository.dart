import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_body.dart';
import 'package:class_compass/util/app_constants.dart';

class QuestionRepository {
  final ApiClient apiClient;

  QuestionRepository({required this.apiClient});

  Future<Response?> getQuestion(
      int page, {
        int? categoryId,
        int? classId,
        int? groupId,
        int? subjectId,
        int? chapterId,
        int? topicId,
        String? type,
        List<int>? types,
        List<int>? levels,
        List<int>? topics,
        List<int>? tags,
        List<int>? sources,
        List<int>? subSources,
        String? search,
        List<int>? questionIds,
      }) async {
    final Map<String, String> queryParams = {
      'page': page.toString(),
      'per_page': '10',
    };

    void addParam(String key, dynamic value) {
      if (value == null) return;

      if (value is List<int>) {
        if (value.isNotEmpty) {
          queryParams[key] = '[${value.join(',')}]';
        }
      } else {
        queryParams[key] = value.toString();
      }
    }

    addParam("question_category_id", categoryId);
    addParam("question_bank_class_id", classId);
    addParam("question_bank_group_id", groupId);
    addParam("question_bank_subject_id", subjectId);
    addParam("question_bank_chapter_id", chapterId);
    addParam("question_bank_topic_id", topicId);
    addParam("type", type);
    addParam("types", types);
    addParam("levels", levels);
    addParam("topics", topics);
    addParam("tags", tags);
    addParam("sources", sources);
    addParam("sub_sources", subSources);
    addParam("search", search);
    addParam("question_ids", questionIds);

    final uri = Uri.parse(AppConstants.questions).replace(queryParameters: queryParams);

    return await apiClient.getData(uri.toString());
  }



  Future<Response?> createQuestion(QuestionBody body, ) async {
    return await apiClient.postData(AppConstants.questions, body.toJson());
  }

  Future<Response?> editQuestion(QuestionBody body, int id) async {
    return await apiClient.postData("${AppConstants.questions}/$id",body.toJson());
  }

  Future<Response?> deleteQuestion(int id) async {
    return await apiClient.deleteData("${AppConstants.questions}/$id");
  }

}
  