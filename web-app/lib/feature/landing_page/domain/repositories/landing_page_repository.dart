import 'package:get/get_connect/http/src/response/response.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LandingPageRepository({required this.apiClient, required this.sharedPreferences});

  Future<Response> getLandingPageData() async {
    return await apiClient.getData(AppConstants.frontendBanner);
  }

  Future<Response> getAboutPageData() async {
    return await apiClient.getData(AppConstants.frontendAboutUs);
  }
  Future<Response> getWhyChooseUSData() async {
    return await apiClient.getData(AppConstants.frontendWhyChooseUs);
  }

  Future<Response> getAdmissionPageData() async {
    return await apiClient.getData(AppConstants.frontendReadyToJoinUs);
  }

  Future<Response> getTeachersPageData() async {
    return await apiClient.getData(AppConstants.frontendTeachers);
  }


  Future<Response> getTestimonialPageData() async {
    return await apiClient.getData(AppConstants.frontendTestimonial);
  }
  Future<Response> getMobileAppPageData() async {
    return await apiClient.getData(AppConstants.frontendMobileApp);
  }

  Future<Response> getEventInfoPageData() async {
    return await apiClient.getData(AppConstants.frontendEventsApi);
  }
  Future<Response> getFaqData() async {
    return await apiClient.getData(AppConstants.frontendFaq);
  }

  Future<Response> newsLetter(String email) async {
    return await apiClient.postData(AppConstants.frontendContactUs, {"email": email});
  }
  Future<Response> privacyPolicy() async {
    return await apiClient.getData(AppConstants.frontendPrivacyPolicy);
  }

  Future<Response> termsAndCondition() async {
    return await apiClient.getData(AppConstants.frontendTermsCondition);
  }

  Future<Response> cookiePolicy() async {
    return await apiClient.getData(AppConstants.frontendCookiePolicy);
  }

  Future<bool> setInstituteType(String type) async {
    return await sharedPreferences.setString(AppConstants.instituteType, type);
  }
  String getInstituteType() {
    return sharedPreferences.getString(AppConstants.instituteType) ?? 'Institute.genericSchool';
  }

  Future<Response> getLandingPageGallery() async {
    return await apiClient.getData(AppConstants.frontendGallery);
  }

}
