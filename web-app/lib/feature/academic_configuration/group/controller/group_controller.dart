import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:class_compass/feature/academic_configuration/group/domain/repository/group_repository.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';

class GroupController extends GetxController implements GetxService{
  final GroupRepository groupRepository;
  GroupController({required this.groupRepository});


  GroupModel? groupModel;
  Future<void> getGroupList(int page, {int? classId}) async {
    Response? response = await groupRepository.getGroupList(page, classId: classId);
    if(response?.statusCode == 200){

      if(page == 1){
        groupModel = GroupModel.fromJson(response?.body);
      }else{
        groupModel?.data?.data?.addAll(GroupModel.fromJson(response?.body).data!.data!);
        groupModel?.data?.currentPage = GroupModel.fromJson(response?.body).data?.currentPage;
        groupModel?.data?.total = GroupModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }
  GroupItem? groupItem;
  void setSelectedGroupItem(GroupItem item, {bool callStudentApi = false, bool notify = true}) {
    groupItem = item;
    if(callStudentApi){
      Get.find<StudentController>().getStudentList(
          Get.find<ClassController>().selectedClassItem!.id!, groupId:groupItem?.id);
    }
    if(notify) {
      update();
    }
  }

  bool isLoading = false;
  Future<void> addNewGroup(String groupName) async {
    isLoading = true;
    update();
    Response? response = await groupRepository.addNewGroup(groupName);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getGroupList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> updateGroup(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await groupRepository.groupEdit(name, id);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getGroupList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  Future<void> deleteGroup(int id) async {
    Response? response = await groupRepository.deleteGroup(id);
    if(response?.statusCode == 200){
      getGroupList(1);
      showCustomSnackBar("deleted_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


}