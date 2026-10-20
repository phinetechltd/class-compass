
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:class_compass/feature/academic_configuration/class/domain/repository/class_repository.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';

class ClassController extends GetxController implements GetxService{
  final ClassRepository classRepository;
  ClassController({required this.classRepository});

  ClassModel? classModel;
  Future<void> getClassList({int perPage = 10, int page =1}) async {
    Response? response = await classRepository.getClassList(perPage: perPage, page: page);
    if(response?.statusCode == 200){
      if(page == 1){
        classModel = ClassModel.fromJson(response?.body);
      }else{
        classModel?.data?.data?.addAll(ClassModel.fromJson(response?.body).data!.data!);
        classModel?.data?.currentPage = ClassModel.fromJson(response?.body).data?.currentPage;
        classModel?.data?.total = ClassModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  ClassItem? selectedClassItem;
  ClassItem? selectedClassItemToMigration;

  void setSelectClass(ClassItem? classItem, {bool fromMigration = false, bool notify = true}) {
    if(fromMigration){
      selectedClassItemToMigration = classItem;
    }else {
      selectedClassItem = classItem;
    }
    if (notify) update();
  }

  Future<void> loadClassDependencies(int classId, {bool fromMigration = false}) async {

    await Get.find<SectionController>().getSectionList(1, fromMigration: fromMigration);
    await Get.find<GroupController>().getGroupList(1, classId: classId);
    await Get.find<SubjectController>().getSubjectList(1, classId: classId);
    if (!fromMigration) {
      await Get.find<StudentController>().getStudentList(classId);
    }
  }

  bool isLoading = false;

  Future<void> addNewClassList(String name) async {
    isLoading = true;
    update();
    Response? response = await classRepository.addNewClassList(name);
    if(response!.statusCode == 200){
      Get.back();
      isLoading = false;
      showCustomSnackBar("class_added_successfully".tr, isError: false);
      getClassList();

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateClassList(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await classRepository.classEdit(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("class_updated_successfully".tr.tr, isError: false);
      getClassList();

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<void> deleteClass(int id) async {
    Response? response = await classRepository.classDelete(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("class_deleted_successfully".tr, isError: false);
      getClassList();
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}