import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/course_management/course/domain/model/chapter_reorder_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/cipher_model.dart';
import 'package:class_compass/feature/course_management/course/domain/model/content_reorder_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/domain/model/faq_item_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/lesson_description_model.dart';
import 'package:class_compass/feature/course_management/course/domain/repository/course_repository.dart';
import 'package:class_compass/helper/image_size_checker.dart';
import 'package:vdocipher_flutter/vdocipher_flutter.dart';



class CourseController extends GetxController implements GetxService {
  final CourseRepository courseRepository;
  CourseController({required this.courseRepository});


  bool isLoading = false;
  CourseModel? courseModel;
  Future<void> getCourse(int page, {int? courseCategoryId}) async {
    Response? response = await courseRepository.getCourseList(page, categoryId : courseCategoryId);
    if (response?.statusCode == 200) {
      if(page == 1){
        courseModel = CourseModel.fromJson(response?.body);
      }else{
        courseModel?.data?.data?.addAll(CourseModel.fromJson(response?.body).data?.data??[]);
        courseModel?.data?.total = CourseModel.fromJson(response?.body).data?.total;
        courseModel?.data?.currentPage = CourseModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  CourseDetailsModel? courseDetailsModel;
  Future<void> getCourseDetails(String id) async {
    Response? response = await courseRepository.getCourseDetails(id);
    if (response?.statusCode == 200) {
      courseDetailsModel = CourseDetailsModel.fromJson(response?.body);
      if(courseDetailsModel != null) {
        Get.find<CourseController>().initializeTopicExpansion(courseDetailsModel?.data?.courseChapters?.length??0);
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool selectedAllCourse = false;
  void selectAllCourse(){
    selectedAllCourse = !selectedAllCourse;
    courseModel?.data?.data?.forEach((element) {
      element.isSelected = selectedAllCourse;
    });
    update();
  }

  void selectCourse(int index){
    courseModel?.data?.data?[index].isSelected = !(courseModel?.data?.data?[index].isSelected??false);
    update();
  }

  CourseItem? selectedCourseItem;
  void setSelectCourseItem(CourseItem item){
    selectedCourseItem = item;
    selectCourseItem(selectedCourseItem!);
    update();
  }

  List<CourseItem> selectedCourseItems = [];
  void selectCourseItem(CourseItem item){
    if(selectedCourseItems.contains(item)){
      showCustomSnackBar("already_added".tr);
    }else{
      selectedCourseItems.add(item);
    }
    update();
  }
  void removeCourseItem(CourseItem item){
    selectedCourseItems.remove(item);
    update();
  }
  void removeAllSelectedCourseItems(){
    selectedCourseItems.clear();
    update();
  }



  bool addTopicEnabled = false;
  void setAddTopicEnabled(bool enabled){
    addTopicEnabled = enabled;
    update();
  }

  List<String> courseTypeList = ["all", "single", "bundle"];
  String courseType = "all";
  void setCourseType(String type){
    courseType = type;
    update();
  }


  bool displayDescriptionOnCourse = false;
  void toggleDisplayDescriptionOnCourse({bool remember = false, bool notify = true}) {
    displayDescriptionOnCourse = remember;
    if(notify){
      update();
    }
  }

  bool hasTimeLimit = false;
  void toggleHasTimeLimit({bool remember = false, bool notify = true}) {
    hasTimeLimit = remember;
    if (notify) {
      update();
    }
  }

  bool openQuizEnabled = false;
  void toggleOpenQuizEnabled(bool enabled){
    openQuizEnabled = enabled;
    if(!openQuizEnabled){
      clearSelectedFromDate();
    }
    update();
  }
  bool closeQuizEnabled = false;
  void toggleCloseQuizEnabled(bool enabled){
    closeQuizEnabled = enabled;
    if(!closeQuizEnabled){
      clearSelectedToDate();
    }
    update();
  }


  List<String> courseStatusCategoryList = ["all", "mine", "published", "draft", "scheduled", "private", "trash"];
  int selectedCourseStatusCategoryIndex = 0;
  void setCourseStatusCategory(int index){
    selectedCourseStatusCategoryIndex = index;
    update();
  }

  List<String> courseStatusList = ["published", "draft", "schedule", "private"];
  String? selectedCourseStatus;
  void setCourseStatus(String type, {bool notify = true}){
    selectedCourseStatus = type;
    if(notify) {
      update();
    }
  }


  List<String> paymentTypeList = ["recurring_payment", "one_time", "free"];
  String? selectedPaymentType;
  void setPaymentType(String type, {bool notify = true}){
    selectedPaymentType = type;
    if(notify) {
      update();
    }
  }




  XFile? thumbnail;
  XFile? parentIdProofImage;
  XFile? pickedImage;
  void pickImage({bool parentIdProof = false}) async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      if(parentIdProof){
        parentIdProofImage = pickedImage;
      }else {
        thumbnail = pickedImage;
      }
    }
    update();
  }


  String? selectedVideoPath;
  PlatformFile? objFile;

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      objFile = result.files.single;
      videoFile = MultipartDocument('uploaded_video_path', objFile);
      if (objFile != null) {
        selectedVideoPath = objFile?.name;
        log("Picked video file: $selectedVideoPath");
      }
    }
    update();
  }

  List<String> videoTypeList = ["youtube", "vimeo", "upload", "embed", "vdocipher"];
  String? selectedVideoType;
  void setVideoType(String type, {bool notify = true}){
    selectedVideoType = type;
    if(notify) {
      update();
    }
  }

  List<FaqItemBody> faqItemList = [];
  void addFaqItem(){
    faqItemList.add(FaqItemBody(questionController: TextEditingController(), answerController: TextEditingController()));
    update();
  }
  void removeFaqItem(int index){
    faqItemList.removeAt(index);
    update();
  }

  bool addNewCategoryEnabled = false;
  void setAddNewCategoryEnabled(bool enabled){
    addNewCategoryEnabled = enabled;
    update();
  }

  TextEditingController videoUrlController = TextEditingController();

  MultipartDocument? videoFile;
  Future<void> createCourse(CourseBody body) async {
    isLoading = true;
    update();

    Response? response = await courseRepository.createCourse(body, thumbnail, videoFile);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      // Get.toNamed(RouteHelper.getCourseRoute());
      showCustomSnackBar("added_successfully".tr, isError: false);
      getCourse(1);
      thumbnail = null;
      videoFile = null;
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editCourse(CourseBody body, int id) async {
    isLoading = true;
    update();
    Response? response = await courseRepository.editCourse(body, thumbnail, videoFile, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getCourse(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteCourse(int id) async {
    Response? response = await courseRepository.deleteCourse(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getCourse(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  DateTime? selectedDateTime;
  DateTime? toSelectedDateTime;
  String? formatedSelectedDateTime;
  String? formatedToSelectedDateTime;
  String? formatedDateTimeForDatabase;
  String? formatedToDateTimeForDatabase;

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool quizClose = false,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate;
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    // Select Date
    final DateTime? pickedDate = await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);

    if (pickedDate == null) return null;
    if (!context.mounted) return pickedDate;

    final TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

    final DateTime finalDateTime = pickedTime == null ? pickedDate : DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);

    final String formatted = DateFormat('dd MMM, yyyy - hh:mm a').format(finalDateTime);

    if (quizClose) {
      toSelectedDateTime = finalDateTime;
      formatedToSelectedDateTime = formatted;
      formatedToDateTimeForDatabase = DateFormat('yyyy-MM-dd hh:mm:ss').format(finalDateTime);
    } else {
      selectedDateTime = finalDateTime;
      formatedSelectedDateTime = formatted;
      formatedDateTimeForDatabase = DateFormat('yyyy-MM-dd hh:mm:ss').format(finalDateTime);
    }

    update();
    return finalDateTime;
  }

  clearSelectedFromDate(){
    selectedDateTime = null;
    formatedSelectedDateTime = null;
    formatedDateTimeForDatabase = null;
    update();
  }

  clearSelectedToDate(){
    toSelectedDateTime = null;
    formatedToSelectedDateTime = null;
    formatedToDateTimeForDatabase = null;
    update();
  }


  bool isSettingExpanded = false;
  bool isTimeExpanded = false;
  bool isGradeExpanded = false;
  bool isLayoutExpanded = false;
  bool isSecurityExpanded = false;

  void toggleSetting(bool val){
    isSettingExpanded = val;
   update();
  }
  void toggleTime(bool val){
    isTimeExpanded = val;
   update();
  }
  void toggleGrade(bool val){
    isGradeExpanded = val;
   update();
  }
  void toggleLayout(bool val){
    isLayoutExpanded = val;
   update();
  }
  void toggleSecurity(bool val){
    isSecurityExpanded = val;
    update();
  }

  List<String> timeLimitTypeList = ["minutes", "hours", "days", "weeks"];
  String? selectedTimeLimitType;
  void setTimeLimitType(String type){
    selectedTimeLimitType = type;
    update();
  }

  List<String> timeExpiredTypeList = ["Open attempts are submitted automatically", "There is a grace period when open attempts can be submitted, but no more questions answered", "Attempts must be submitted before time expires, or they are not counted"];
  String? selectedTimeExpiredType;
  String? selectedExpiryTimeTypeForDatabase;
  void setTimeExpiredType(String type){
    selectedTimeExpiredType = type;
    if(type == timeExpiredTypeList[0]) {
      selectedExpiryTimeTypeForDatabase = "auto_submit";
    }
    if(type == timeExpiredTypeList[1]) {
      selectedExpiryTimeTypeForDatabase = "prevent_submit";
    }
    if(type == timeExpiredTypeList[2]) {
      selectedExpiryTimeTypeForDatabase = "grace_time";
    }

    update();
  }


  List<String> resultShowListType = ["Immediately after the submit", "Immediately after the selection", "After the quiz is closed"];
  String? selectedResultShowType;
  String? selectedResultShowTypeForDatabase;
  void setResultShowType(String type){
    selectedResultShowType = type;
    if(type == resultShowListType[0]) {
      selectedResultShowTypeForDatabase = "immediate";
    }
    if(type == resultShowListType[1]) {
      selectedResultShowTypeForDatabase = "after_review";
    }
    if(type == resultShowListType[2]) {
      selectedResultShowTypeForDatabase = "never";
    }
    update();
  }


  List<String> attemptType = ["unlimited", "custom"];
  String? selectedAttemptType;
  void setAttemptType(String type) {
    selectedAttemptType = type;
    update();
  }

  bool showWholePage = false;
  void toggleShowWholePage({bool toggleOff = false}){
    if(toggleOff){
      showWholePage = toggleOff;
    }else {
      showWholePage = !showWholePage;
    }
    update();
  }


  List<bool> topicExpanded = [];
  bool areAllExpanded = false;

  void initializeTopicExpansion(int count) {
    topicExpanded = List.generate(count, (_) => areAllExpanded);
  }

  void toggleAllExpansion() {
    areAllExpanded = !areAllExpanded;
    for (int i = 0; i < topicExpanded.length; i++) {
      topicExpanded[i] = areAllExpanded;
    }
    update();
  }
  List<String> securityTypeList = ["none", "password", "public"];
  String? selectedSecurityType;
  void setSecurityType(String type){
    selectedSecurityType = type;
    update();
  }
  bool infinityCycle = false;
  void toggleInfinityCycle(){
    infinityCycle = !infinityCycle;
    update();
  }
  bool autoGeneratingInvoice = false;
  void toggleAutoGeneratingInvoice(bool toggleOff, {bool notify = true}){
    autoGeneratingInvoice = toggleOff;
    if(notify) {
      update();
    }
  }

  List<String> paymentDurationList = [
    "Every month",
    "Every 2 months",
    "Every 3 months",
    "Every 4 months",
    "Every 5 months",
    "Every 6 months",
    "Every 7 months",
    "Every 8 months",
    "Every 9 months",
    "Every 10 months",
    "Every 11 months",
    "Every 12 months"];
  String? selectedPaymentDuration;
  void setPaymentDuration(String type){
    selectedPaymentDuration = type;
    update();
  }

  bool slugEdit = false;
  void setSlugEdit(){
    slugEdit = !slugEdit;
    update();
  }
  String selectedCourserType = "single";
  void setSelectedCourserType(String type){
    selectedCourserType = type;
    update();
  }
  bool showCourseOverView = false;
  void toggleShowCourseOverView(){
    showCourseOverView = !showCourseOverView;
    update();
  }

  int? selectedCourseId;
  int? selectedChapterId;
  void setSelectedChapterAndCourseId(int courseId, int chapterId){
    selectedCourseId = courseId;
    selectedChapterId = chapterId;
    update();
  }

  Contents? selectedContent;
  void setSelectedContent(Contents content) {
    selectedContent = content;
    update();

  }
  resetSelectedContent() {
    selectedContent = null;
    update();
  }


  List<String> enrollmentTypeList = ["unlimited", "fixed_time"];
  String enrollmentType = "unlimited";
  void setEnrollmentType(String type){
    enrollmentType = type;
    update();
  }


  List<String> layoutTypes = ["All on one page", "Input Question" ];
  String? selectedLayoutType;
  void setLayoutType(String type){
    selectedLayoutType = type;
    update();
  }




  List<String> questionShuffleTypeList = ["Yes", "No"];
  String? selectedQuestionShuffleType;
  void setQuestionShuffleType(String type){
    selectedQuestionShuffleType = type;
    update();

  }

  List<String> shuffleQuestionOption = ["Yes", "No"];
  String? selectedShuffleQuestionOption;
  void setShuffleQuestionOption(String type){
    selectedShuffleQuestionOption = type;
    update();
  }


  double videoWidth = MediaQuery.sizeOf(Get.context!).width - 400;
  double videoHeight = (MediaQuery.sizeOf(Get.context!).width - 400) * 0.5;
  bool fullScreen = false;
  void toggleVideoSize() {
    fullScreen = !fullScreen;
    if(fullScreen){
      videoWidth = MediaQuery.sizeOf(Get.context!).width - 400;
      videoHeight = (MediaQuery.sizeOf(Get.context!).width - 400) * 0.5;
    } else {
      videoWidth = MediaQuery.sizeOf(Get.context!).width;
      videoHeight = MediaQuery.sizeOf(Get.context!).height;
    }
    update();
  }
  int summeryTypeIndex = 0;
  void setSummeryTypeIndex(int index){
    summeryTypeIndex = index;
    update();
  }

  Future<void> reOrderChapter(ChapterReorderBody body) async{
    Response? response = await courseRepository.chapterReorder(body);
    if (response?.statusCode == 200) {
     log("reorder Chapter");
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> reOrderContent(ContentReorderBody body) async{
    Response? response = await courseRepository.contentReorder(body);
    if (response?.statusCode == 200) {
      log("reorder Content");
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

  bool showLiveClass = false;
  void toggleLiveClass(bool show, {bool notify = true}) {
    showLiveClass = show;
    selectedContent = null;
    if( notify) {
      update();
    }
  }

  LessonDescriptionModel? lessonDescriptionModel;
  Future<void> getMyCourseLessonDetails(String type, String typeId) async {
    lessonDescriptionModel = null;
    selectedContent == null;
    update();
    Response? response = await courseRepository.getCourseLessonDetails(type, typeId);
    if (response?.statusCode == 200) {
      lessonDescriptionModel = LessonDescriptionModel.fromJson(response!.body);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

}
  