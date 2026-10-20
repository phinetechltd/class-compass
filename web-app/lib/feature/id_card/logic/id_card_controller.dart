import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';

class IdCardController extends GetxController implements GetxService{

  int idTypeIndex = 0;
  void setSelectedIdTypeIndex(int typeIndex){
    idTypeIndex = typeIndex;
    update();
  }

  bool isLoading = false;

  /// Asks the API for a short-lived signed link to a print page and opens it.
  /// [type] is one of: student_id_card, teacher_id_card, staff_id_card, student_vital.
  /// Institute and branch are taken from the logged-in user on the server.
  Future<void> openPrintLink(String type, {Map<String, dynamic>? params}) async {
    isLoading = true;
    update();
    Response response = await Get.find<ApiClient>().postData(AppConstants.printLinks, {"type": type, ...?params});
    isLoading = false;
    update();
    if (response.statusCode == 200 && response.body['data']?['url'] != null) {
      await AppConstants.openUrl(response.body['data']['url']);
    } else {
      ApiChecker.checkApi(response);
    }
  }

}
