import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_body.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/repository/assignment_repository.dart';

class AssignmentController extends GetxController implements GetxService{
  final AssignmentRepository attachmentRepository;
  AssignmentController({required this.attachmentRepository});




  bool isLoading = false;
  AssignmentModel? assignmentModel;
  Future<void> getAssignmentList(int offset) async {
    Response? response = await attachmentRepository.getAssignmentList(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        assignmentModel = AssignmentModel.fromJson(response?.body);
      }else{
        assignmentModel?.data?.data?.addAll(AssignmentModel.fromJson(response?.body).data!.data!);
        assignmentModel?.data?.currentPage = AssignmentModel.fromJson(response?.body).data?.currentPage;
        assignmentModel?.data?.total = AssignmentModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }




  List<MultipartDocument> documents = [];
  FilePickerResult? _otherFile;
  FilePickerResult? get otherFile => _otherFile;
  List<FilePickerResult> listOfDocuments = [];
  File? _file;
  PlatformFile? objFile;
  File? get file=> _file;

  Future<bool> pickOtherFile(bool isRemove) async {
    if(isRemove){
      _otherFile=null;
      _file = null;
    }else{
      _otherFile = (await FilePicker.platform.pickFiles(withData: true))!;
      if (_otherFile != null) {
        listOfDocuments.add(_otherFile!);
        manageFile();

      }
    }
    update();
    return true;
  }

  void manageFile(){
    documents = [];
    for(int i=0; i<listOfDocuments.length; i++){
      objFile = listOfDocuments[i].files.single;
      if(i==0){
        documents.add(MultipartDocument('file', objFile));
      }else{
        documents.add(MultipartDocument('file_${i + 1}', objFile));
      }

    }
  }


  clearFile (){
    _otherFile = null;
    _file = null;
    listOfDocuments = [];
    documents = [];
    update();
  }




  void removeFile(int index) async {
    listOfDocuments.removeAt(index);
    documents.removeAt(index);
    update();
  }





  Future<void> createNewAssignment(AssignmentBody assignmentBody) async {
    isLoading = true;
    update();
    Response? response = await attachmentRepository.createNewAssignment(
        assignmentBody, documents);
    if(response?.statusCode == 200){
      clearFile();
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getAssignmentList(1);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();

  }

  Future<void> updateAssignment( AssignmentBody assignmentBody, int id) async {
    isLoading = true;
    update();
    Response? response = await attachmentRepository.updateAssignment(assignmentBody, documents, id);
    if(response!.statusCode == 200){
      clearFile();
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getAssignmentList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    isLoading = false;
    update();

  }


  Future<void> deleteAssignment(int id) async {
    isLoading = true;
    Response? response = await attachmentRepository.deleteAssignment(id);
    if (response?.statusCode == 200) {
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getAssignmentList(1);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }


  
}