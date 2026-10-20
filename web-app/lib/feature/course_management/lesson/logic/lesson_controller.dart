import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/course_management/course/domain/model/resource_type_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/lesson/domain/model/lesson_body.dart';
import 'package:class_compass/feature/course_management/lesson/domain/model/lesson_model.dart';
import 'package:class_compass/feature/course_management/lesson/domain/repository/lesson_repository.dart';

class LessonController extends GetxController implements GetxService {
  final LessonRepository lessonRepository;
  LessonController({required this.lessonRepository});


  bool isLoading = false;
  LessonModel? lessonModel;
  Future<void> getLesson(int page) async {
    Response? response = await lessonRepository.getLesson(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        lessonModel = LessonModel.fromJson(response?.body);
      }else{
        lessonModel?.data?.data?.addAll(LessonModel.fromJson(response?.body).data?.data??[]);
        lessonModel?.data?.total = LessonModel.fromJson(response?.body).data?.total;
        lessonModel?.data?.currentPage = LessonModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }



  List<String> typeList = ['video', 'text', 'assignment', 'quiz'];
  String? selectedType = "text";
  void changeType(String? value){
    selectedType = value;
    update();
  }


  Future<void> createLesson(LessonBody body) async {
    isLoading = true;
    update();
    Response? response = await lessonRepository.createLesson(body, Get.find<CourseController>().thumbnail, selectedResourceType == "document"? documentFile : Get.find<CourseController>().videoFile, exerciseFiles);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      Get.find<CourseController>().getCourseDetails(body.courseId!);
      clearExerciseFile();
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> editLesson(LessonBody body,int id, String courseId) async {
    isLoading = true;
    update();
    Response? response = await lessonRepository.editLesson(body, Get.find<CourseController>().thumbnail,selectedResourceType == "document"? documentFile : Get.find<CourseController>().videoFile,exerciseFiles, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      Get.find<CourseController>().getCourseDetails(courseId);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteLesson(int chapterId, int contentId, String courseId) async {
    Response? response = await lessonRepository.deleteLesson(chapterId, contentId);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      Get.find<CourseController>().getCourseDetails(courseId);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  List<String> passwordType  = ["None", "Password", "Public"];
  String selectedPasswordType = "None";
  void changePasswordType(String value, {bool notify = true}){
    selectedPasswordType = value;
    if(notify){
      update();
    }
  }
  bool isSchedule = false;
  void changeSchedule(bool value, {bool notify = true}){
    isSchedule = value;
    if(notify){
      update();
    }
  }

  List<ResourceTypeModel> resourceTypeList = [
    ResourceTypeModel(title : "Youtube Video".tr, type: "youtube"),
    ResourceTypeModel(title : "Vimeo Video".tr, type: "vimeo" ),
    ResourceTypeModel(title : "Video File".tr, type: "upload" ),
    ResourceTypeModel(title : "Video Url [.MP4]".tr , type: "url"),
    ResourceTypeModel(title : "Google Drive Video".tr, type: "google_drive"),
    ResourceTypeModel(title : "Document File".tr, type: "document"),
    ResourceTypeModel(title : "Text".tr, type: "text"),
    ResourceTypeModel(title : "Image".tr, type: "image"),
    ResourceTypeModel(title : "Iframe Embed".tr, type: "embed"),
    ResourceTypeModel(title : "Video Cipher".tr, type: "cipher"),

  ];

  String? selectedResourceType;
  String? selectedResourceTitle;

  void toggleResource(int index){
    selectedResourceType = resourceTypeList[index].type;
    selectedResourceTitle = resourceTypeList[index].title;
    for(int i = 0; i < resourceTypeList.length; i++){
      resourceTypeList[i].isSelected = false;
    }
    resourceTypeList[index].isSelected = !(resourceTypeList[index].isSelected??false);
    update();
  }

  updateResourceTypeSelection(String type, String title){
    selectedResourceType = type;
    selectedResourceTitle = title;
  }


  PlatformFile? objFile;
  List<MultipartDocument> exerciseFiles = [];
  Future<void> pickExerciseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      objFile = result.files.single;
      exerciseFiles.add(MultipartDocument('attachments', objFile));
    }
    log("-----exxxx---> ${exerciseFiles.length}");
    update();
  }
  void removeExerciseFile(int index){
    exerciseFiles.removeAt(index);
    update();
  }

  void clearExerciseFile(){
    exerciseFiles.clear();
    update();
  }


  MultipartDocument? documentFile;
  String? selectedDocument;
  PlatformFile? docFile;
  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      docFile = result.files.single;
      documentFile = MultipartDocument('document_file', docFile);
      if (docFile != null) {
        selectedDocument = docFile?.name;
      }
    }
    update();
  }
 }
