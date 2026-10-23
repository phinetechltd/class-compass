
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/error_response.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/authentication/presentation/screen/login_screen.dart';


class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthenticationController>().clearSharedData();
      Get.offAll(()=> const LoginScreen());
    }else if(response.statusCode == 403){
      // A screen loading data the user's role may not see (a dashboard widget, a header list)
      // should not interrupt them; only a refused action they took (save, delete...) is shown.
      final method = response.request?.method.toUpperCase();
      if (method == null || method == 'GET' || method == 'HEAD') {
        debugPrint('Not permitted for this role: ${response.request?.url.path ?? ''}');
        return;
      }
      ErrorResponse errorResponse;
      errorResponse = ErrorResponse.fromJson(response.body);
      if(errorResponse.errors != null && errorResponse.errors!.isNotEmpty){
        showCustomSnackBar(errorResponse.errors![0].message!);
      }else{
        showCustomSnackBar(_message(response));
      }
    }else {
      showCustomSnackBar(_message(response));
    }
  }

  /// Network failures and timeouts come back without a JSON body.
  static String _message(Response response) {
    final body = response.body;
    if (body is Map && body['message'] != null) return '${body['message']}';
    return response.statusText?.isNotEmpty == true ? response.statusText! : 'Could not reach the server. Check your connection and try again.';
  }
}
