import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_body.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/repository/subject_repository.dart';

class SubjectController extends GetxController implements GetxService{
  final SubjectRepository subjectRepository;
  SubjectController({required this.subjectRepository});


  SubjectItem? selectedSubjectItem;
  void setSelectSubjectItem(SubjectItem? sectionItem){
    selectedSubjectItem = sectionItem;
    update();
  }

  SubjectModel? subjectModel;
  Future<void> getSubjectList(int page, {int? classId}) async {
    Response? response = await subjectRepository.getSubjectList(page, classId: classId);
    if(response?.statusCode == 200){
      if(page == 1){
        subjectModel = SubjectModel.fromJson(response?.body);
      }else{
        subjectModel?.data?.data?.addAll(SubjectModel.fromJson(response?.body).data!.data!);
        subjectModel?.data?.currentPage = SubjectModel.fromJson(response?.body).data?.currentPage;
        subjectModel?.data?.total = SubjectModel.fromJson(response?.body).data?.total;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  void toggleSelectSubject(int index){
    if(subjectModel?.data?.data![index].isSelected == true){
      subjectModel?.data?.data![index].isSelected = false;
    }else{
      subjectModel?.data?.data![index].isSelected = true;
    }
    update();
  }



  bool isLoading = false;
  Future<void> addNewSubject (SubjectBody subjectBody) async {
    isLoading = true;
    update();
    Response? response = await subjectRepository.addNewSubject(subjectBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSubjectList(1);
    }
    else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<void> updateSubject (int subjectId, SubjectBody subjectBody) async {
    Response? response = await subjectRepository.updateSubject(subjectBody, subjectId);
    if(response!.statusCode == 200){
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getSubjectList(1);
    }
    else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> deleteSubject (int subjectId) async {
    Response? response = await subjectRepository.deleteSubject(subjectId);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getSubjectList(1);
    }
    else{
      ApiChecker.checkApi(response);
    }
    update();
  }

  List<String> subjectTypes = ["Compulsory", "Optional"];
  String selectedType = "Compulsory";
  void setSubjectType(String type, {bool notify = true}){
    selectedType = type;
    if(notify) {
      update();
    }
  }

  List<String> subjectTypeForms = ["All Groups","Compulsory", "Elective", "Optional"];
  String selectedTypeForm = "All Groups";
  void setSubjectTypeForm(String type, {bool notify = true}){
    selectedTypeForm = type;
    if(notify) {
      update();
    }
  }

}