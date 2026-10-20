import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course_category/domain/model/course_category_model.dart';
import 'package:class_compass/feature/course_management/course_category/domain/repository/course_category_repository.dart';
import 'package:class_compass/helper/image_size_checker.dart';

class CourseCategoryController extends GetxController implements GetxService {
  final CourseCategoryRepository courseCategoryRepository;
  CourseCategoryController({required this.courseCategoryRepository});


  bool isLoading = false;
  ApiResponse<CourseCategoryItem>? courseCategoryModel;
  Future<void> getCourseCategory(int page) async {
    Response? response = await courseCategoryRepository.getCourseCategory(page);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<CourseCategoryItem>.fromJson(response?.body, (json) => CourseCategoryItem.fromJson(json));
      if(page == 1){
        courseCategoryModel = apiResponse;
      }else{
        courseCategoryModel?.data?.data?.addAll(apiResponse.data?.data??[]);
        courseCategoryModel?.data?.total = apiResponse.data?.total;
        courseCategoryModel?.data?.currentPage = apiResponse.data?.currentPage;
      }
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  CourseCategoryItem? selectedCourseCategoryItem;
  void setSelectCourseCategoryItem(CourseCategoryItem item, {bool notify = true}){
    selectedCourseCategoryItem = item;
    Get.find<CourseController>().getCourse(1, courseCategoryId: selectedCourseCategoryItem?.id);
    if(notify) {
      update();
    }
  }

  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage({bool parentIdProof = false}) async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }
    update();
  }

  Future<Response> createCourseCategory(String name, String? description, String? parentId) async {
    isLoading = true;
    update();
    Response? response = await courseCategoryRepository.createCourseCategory(name, description, parentId, thumbnail);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getCourseCategory(1);
      thumbnail = null;
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<Response> editCourseCategory(String name, String? description, String? parentId, int id) async {
    isLoading = true;
    update();
    Response? response = await courseCategoryRepository.editCourseCategory(name,description, parentId,thumbnail, id);
    if (response?.statusCode == 200) {
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getCourseCategory(1);
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
    return response!;
  }

  Future<void> deleteCourseCategory(int id) async {
    Response? response = await courseCategoryRepository.deleteCourseCategory(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getCourseCategory(1);
    } else {
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool slugEdit = false;
  void setSlugEdit(){
    slugEdit = !slugEdit;
    update();
  }

}
  