import 'dart:developer';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/course_management/chapter/domain/model/chapter_body.dart';
import 'package:class_compass/feature/course_management/chapter/domain/model/chapter_model.dart';
import 'package:class_compass/feature/course_management/chapter/domain/repository/chapter_repository.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/helper/image_size_checker.dart';

class ChapterController extends GetxController implements GetxService {
  final ChapterRepository chapterRepository;
  ChapterController({required this.chapterRepository});


  bool isLoading = false;
  ChapterModel? chapterModel;
  Future<void> getChapter(int page, {int? subjectId}) async {
    Response? response = await chapterRepository.getChapter(page, subjectId: subjectId);
    if (response?.statusCode == 200) {
      if(page == 1){
        chapterModel = ChapterModel.fromJson(response?.body);
      }else{
        chapterModel?.data?.data?.addAll(ChapterModel.fromJson(response?.body).data?.data??[]);
        chapterModel?.data?.total = ChapterModel.fromJson(response?.body).data?.total;
        chapterModel?.data?.currentPage = ChapterModel.fromJson(response?.body).data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }


  ChapterItem? selectedChapterItem;
  void setSelectChapterItem(ChapterItem? item){
    selectedChapterItem = item;
    update();
  }


  XFile? thumbnail;
  XFile? parentIdProofImage;
  XFile? pickedImage;
  void pickImage() async {
    log("message you are in pick image");
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    log("message you are in pick image");
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    log("Here is image size ==> $imageSizeIs");
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;

    }
    update();
  }


  Future<Response> createChapter(ChapterBody body, String courseId) async {
    isLoading = true;
    update();
    Response? response = await chapterRepository.createChapter(body);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      Get.find<CourseController>().getCourseDetails(courseId);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<Response> editChapter(ChapterBody body,int id, String courseId) async {
    isLoading = true;
    update();
    Response? response = await chapterRepository.editChapter(body, id);
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
    return response!;
  }

  Future<void> deleteChapter(int id, String courseId) async {
    Response? response = await chapterRepository.deleteChapter(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      Get.find<CourseController>().getCourseDetails(courseId);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

}
  