import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/feature/exam_management/marksheet/domain/model/marksheet_config_body.dart';
import 'package:class_compass/util/app_constants.dart';

class MarkSheetRepository {
   final ApiClient apiClient;
   MarkSheetRepository({required this.apiClient});
   Future<Response?> getMarkSheetConfig(int page) async {
      return await apiClient.getData("${AppConstants.markSheetConfig}?page=$page&perPage=10");
   }

   Future<Response?> createNewMarkSheetConfig(MarksheetConfigBody body,
       XFile? headerLogo,
       XFile? schoolStamp,
       XFile? borderDesign,
       XFile? waterMark,
       ) async {
      Map<String, String> fields = <String, String> {
         'name': body.name??'',
         'signature_id': body.signatureId.toString(),
         'teacher_signature_id': body.teacherSignatureId.toString(),
         'status': "1",
      };
      return await apiClient.postMultipartData(AppConstants.markSheetConfig, fields, [
         MultipartBody("header_logo", headerLogo),
         MultipartBody("stamp_image", schoolStamp),
         MultipartBody("border_design", borderDesign),
         MultipartBody("watermark", waterMark),
      ],
          null, []);
   }

   Future<Response?> updateMarkSheetConfig(MarksheetConfigBody body, int id,
       XFile? headerLogo,
       XFile? schoolStamp,
       XFile? borderDesign,
       XFile? waterMark,
       ) async {
      Map<String, String> fields = <String, String> {
         'name': body.name??'',
         'signature_id': body.signatureId.toString(),
         'teacher_signature_id': body.teacherSignatureId.toString(),
         'status': "1",
         '_method':"put"
      };
      return await apiClient.postMultipartData("${AppConstants.markSheetConfig}/$id", fields, [
         MultipartBody("header_logo", headerLogo),
         MultipartBody("stamp_image", schoolStamp),
         MultipartBody("border_design", borderDesign),
         MultipartBody("watermark", waterMark),
      ],
          null, []);
   }

   Future<Response?> deleteMarkSheetConfig (int id) async {
      return await apiClient.deleteData("${AppConstants.markSheetConfig}/$id");
   }
}