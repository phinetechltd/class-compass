import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_body.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_body.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_return_body.dart';
import 'package:class_compass/util/app_constants.dart';

class BookRepository{
  final ApiClient apiClient;
  BookRepository({required this.apiClient});

  Future<Response?> getBookList(int page) async {
    return await apiClient.getData("${AppConstants.books}?per_page=30&page=$page");
  }


  Future<Response?> addNewBook(BookBody body) async {
    return await apiClient.postData(AppConstants.books, body.toJson());
  }

  Future<Response?> bookDetails(int id) async {
    return await apiClient.getData("${AppConstants.books}/$id");
  }

  Future<Response?> bookEdit(BookBody body, int id) async {
    return await apiClient.postData("${AppConstants.books}/$id",
        body.toJson());
  }

  Future<Response?> bookDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.books}/$id");
  }

  Future<Response?> bookIssue(BookIssueBody body) async {
    return await apiClient.postData(AppConstants.bookIssue, body.toJson());
  }
  Future<Response?> getIssuedBook(int page, String? libraryId) async {
    if(libraryId == null){
      return await apiClient.getData("${AppConstants.bookIssue}?per_page=10&page=$page");
    }else {
      return await apiClient.getData("${AppConstants.bookIssue}?per_page=10&page=$page&library_id=$libraryId");
    }
  }

  Future<Response?> bookReturn(BookReturnBody body) async {
    return await apiClient.postData(AppConstants.bookReturn, body.toJson());
  }

  Future<Response?> bookIssueReport(int page, String statusId, String userId) async {
    return await apiClient.getData("${AppConstants.bookIssueReport}?per_page=20&page=$page&status_id=$statusId&user_id=$userId");
  }
}