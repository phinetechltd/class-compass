import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/course_management/course/domain/model/cipher_model.dart';
import 'package:class_compass/feature/course_management/course/domain/model/lesson_description_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/frontend_course_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_result_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_start_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_submit_body.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/quiz_submit_response_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/repository/frontend_course_repository.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';

class FrontendCourseController extends GetxController implements GetxService {
  final FrontendCourseRepository courseRepository;
  FrontendCourseController({required this.courseRepository});

  ApiResponse<CourseItem>? courseModel;
  Future<void> getCourse(int page) async {
      Response? response = await courseRepository.getCourse(page);
      if (response?.statusCode == 200) {
        final apiResponse = ApiResponse<CourseItem>.fromJson(
            response!.body, (json) => CourseItem.fromJson(json));

        if(page == 1) {
          courseModel = apiResponse;
        }else{
          courseModel?.data?.data?.addAll(apiResponse.data?.data ?? []);
          courseModel?.data?.currentPage = apiResponse.data?.currentPage;
          courseModel?.data?.total = apiResponse.data?.total;

        }
      } else {
        ApiChecker.checkApi(response!);
      }

    update();
  }


  MyCourseModel? myCourseModel;
  Future <void> getMyCourse() async {
      Response? response = await courseRepository.getMyCourse();
      if (response?.statusCode == 200) {
        myCourseModel = MyCourseModel.fromJson(response!.body);
        log("my course ===> ${response.body}");
      } else {
        ApiChecker.checkApi(response!);
      }
    update();
  }

  MyCourseDetailsModel? myCourseDetailsModel;
  Future<void> getMyCourseDetails(String slug) async {
      Response? response = await courseRepository.getMyCourseDetails(slug);
      if (response?.statusCode == 200) {
        myCourseDetailsModel = MyCourseDetailsModel.fromJson(response!.body);
      } else {
        ApiChecker.checkApi(response!);
      }
    update();
  }



  QuizDetailsModel? quizDetailsModel;
  Future<void> getQuizDetails(int typeId) async {
    Response? response = await courseRepository.getQuizDetails(typeId);
    if (response?.statusCode == 200) {
      quizDetailsModel = QuizDetailsModel.fromJson(response!.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuizStartModel? quizStartModel;
  Future<Response> quizAttempt(int quizId) async {
    Response? response = await courseRepository.quizAttempt(quizId);
    if (response?.statusCode == 200) {
      quizStartModel = QuizStartModel.fromJson(response!.body);
      toggleLeftMenu(hide: true);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
    return response;
  }

  bool loading = false;
  QuizSubmitResponseModel? quizSubmitResponseModel;
  Future<void> quizAnswerSubmit(QuizSubmitBody body) async {
    loading = true;
    update();
    Response? response = await courseRepository.quizAnswerSubmit(body);
    if (response?.statusCode == 200) {
      loading = false;
      quizSubmitResponseModel = QuizSubmitResponseModel.fromJson(response!.body);
      showCustomSnackBar("submitted_successfully".tr,isError: false);
      if(quizSubmitResponseModel != null){
        if(quizSubmitResponseModel?.data?.resultVisibility != "never"){
          quizResults(quizSubmitResponseModel!.data!.quizId!, quizSubmitResponseModel!.data!.attemptId!);
        }else{
          Get.dialog(ConfirmationDialog(
            title: "quiz_results".tr,
            content: "${quizSubmitResponseModel?.data?.message}",
              onTap: (){
            // Get.toNamed(RouteHelper.getMyCoursesRoute());
          }));
        }

      }
    } else {
      loading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  QuizResultModel? quizResultModel;
  Future<void> quizResults(int quizId, int attemptId) async {
    Response? response = await courseRepository.quizResults(quizId, attemptId);
    if (response?.statusCode == 200) {
      quizResultModel = QuizResultModel.fromJson(response!.body);
      // Get.toNamed(RouteHelper.getQuizResultRoute(slug: myCourseDetailsModel!.data!.courseSlug!));
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  EmbedInfo? embedInfo;
  CipherModel? cipherModel;
  Future<void> getVideoCipherOtp(String name, String email, String videoId) async {
    embedInfo = null;
    update();
    Response? response = await courseRepository.videoCipher(name, email, videoId);
    if (response?.statusCode == 200) {
      cipherModel = CipherModel.fromJson(response!.body);
         embedInfo = EmbedInfo.streaming(otp: '${cipherModel?.data?.otp}',
          playbackInfo: '${cipherModel?.data?.playbackInfo}',
          embedInfoOptions: const EmbedInfoOptions(autoplay: true, customPlayerId: "vGCyKgVdiENnE5f5"));


    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  void toggleQuestionItemSelection(int index){
    if(quizResultModel?.data?.questions?[index].isSelected == true){
      quizResultModel?.data?.questions?[index].isSelected = false;
    } else {
      quizResultModel?.data?.questions?[index].isSelected = true;
    }
    update();
  }

  void togglePractiseModeResult(int index){
    quizDetailsModel?.data?.questions?[index].isSelected =
    !(quizDetailsModel?.data?.questions?[index].isSelected ?? false);
    update();

  }




  FrontendCourseModel? categoryWiseCourseModel;
  Future<void> getCategoryWiseCourse() async {
    Response? response = await courseRepository.getCategoryWiseCourse();
    if (response?.statusCode == 200) {
      categoryWiseCourseModel = FrontendCourseModel.fromJson(response!.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  MyCourseDetailsModel? courseDetailsModel;
  Future<void> getCourseDetails(String tag) async {
    Response? response = await courseRepository.frontendCourseDetails(tag);
    if (response?.statusCode == 200) {
      courseDetailsModel = MyCourseDetailsModel.fromJson(response!.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  int summeryTypeIndex = 0;
  void setSummeryTypeIndex(int index){
    summeryTypeIndex = index;
    update();
  }
  bool showLiveClass = false;
  void toggleLiveClass(bool show, {bool notify = true}) {
    showLiveClass = show;
    selectedContent = null;
    if( notify) {
      update();
    }
  }

  bool hideLeftMenu = false;
  void toggleLeftMenu({bool? hide, bool notify = true}) {
    hideLeftMenu = hide?? !hideLeftMenu;
    if(notify) {
      update();
    }
  }

  String? selectedContentType;
  Contents? selectedContent;
  void setSelectedContent(Contents content){
    selectedContent = content;
    selectedContentType = content.type;
    if(myCourseDetailsModel?.data?.courseChapters != null){
      for (var chapter in myCourseDetailsModel!.data!.courseChapters ?? []) {
        for (var content in chapter.contents ?? []) {
          content.isSelected = false;
        }
      }
    }
    selectedContent?.isSelected = true;
    update();
  }

  void resetSelectedContent(){
    selectedContent = null;
    selectedContentType = null;
  }

  void toggleAnswerSelection(int questionIndex, int optionIndex) {
    if(quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isCorrect == true){
      quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isCorrect = false;
    }
    quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isSelected =
        !(quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isSelected ?? false);

    update();
  }

  void toggleFalseAnswerSelection(int questionIndex, int optionIndex) {
    if(quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isSelected == true){
      quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isSelected = false;
    }
    quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isCorrect =
    !(quizDetailsModel?.data?.questions?[questionIndex].options?[optionIndex].isCorrect ?? false);

    update();
  }

  double videoWidth = MediaQuery.sizeOf(Get.context!).width - 400;
  double videoHeight = (MediaQuery.sizeOf(Get.context!).width - 400) / 2.75;
  bool fullScreen = false;
  void toggleVideoSize() {
    fullScreen = !fullScreen;
    if(fullScreen){
      videoWidth = MediaQuery.sizeOf(Get.context!).width - 400;
      videoHeight = (MediaQuery.sizeOf(Get.context!).width - 400) / 2.75;
    } else {
      videoWidth = MediaQuery.sizeOf(Get.context!).width;
      videoHeight = MediaQuery.sizeOf(Get.context!).height;
    }
    update();
  }

  LessonDescriptionModel? lessonDescriptionModel;
  Future<void> getMyCourseLessonDetails(String type, String typeId) async {
    lessonDescriptionModel = null;
    selectedContent == null;
    update();
    Response? response = await courseRepository.getMyCourseLessonDetails(type, typeId);
    if (response?.statusCode == 200) {
      lessonDescriptionModel = LessonDescriptionModel.fromJson(response!.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


}
  