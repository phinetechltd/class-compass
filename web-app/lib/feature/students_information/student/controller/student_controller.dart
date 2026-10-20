
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/api_handle/file_download_client.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/students_information/student/domain/model/all_student_model.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_body.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_details_model.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_model.dart';
import 'package:class_compass/feature/students_information/student/domain/repository/student_repository.dart';
import 'package:class_compass/helper/image_size_checker.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';

class StudentController extends GetxController implements GetxService{
  final StudentRepository studentRepository;
  StudentController({required this.studentRepository});

  ApiResponse<StudentItem>? studentModel;
  Future<void> getStudentList(int classId, {int? groupId, int? periodId, int? sectionId, String? date, }) async {
    isLoading = true;
    update();
    Response? response = await studentRepository.getStudentList(classId,
        period: periodId,
        groupId: groupId, sectionId:sectionId, date:date);
    if(response?.statusCode == 200){
      final apiResponse = ApiResponse<StudentItem>.fromJson(response?.body, (data) => StudentItem.fromJson(data));
      isLoading = false;
        studentModel = apiResponse;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  AllStudentModel? allStudentModel;
  Future<void> getAllStudentList(int page) async {
    Response? response = await studentRepository.getAllStudent(page);
    if(response?.statusCode == 200){
      if(page == 1){
        allStudentModel = AllStudentModel.fromJson(response?.body);
      }else{
        allStudentModel?.data?.data?.addAll(AllStudentModel.fromJson(response?.body).data!.data!);
        allStudentModel?.data?.total = AllStudentModel.fromJson(response?.body).data!.total;
        allStudentModel?.data?.currentPage = AllStudentModel.fromJson(response?.body).data!.currentPage;
      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }




  List<String> genderList =["Male", "Female"];
  String selectedGender = "Male";
  void setSelectedGender(String gender){
    selectedGender = gender;
    update();
  }

  XFile? thumbnail;
  XFile? pickedImage;
  void pickImage() async {
    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    double imageSizeIs = await ImageSize.getImageSize(pickedImage!);
    if(imageSizeIs > 1){
      showCustomSnackBar("please_choose_image_size_less_than_2_mb".tr);
    }else{
      thumbnail = pickedImage;
    }
    update();
  }


  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String selectedBloodGroup = 'A+';
  void setSelectedBloodGroup(String bloodGroup){
    selectedBloodGroup = bloodGroup;
    update();
  }

  final List<String> religions = [
    'Islam',
    'Christianity',
    'Hinduism',
    'Buddhism',
    'Judaism',
    'Sikhism',
    'Atheism',
    'Other'
  ];

  String selectedReligion = 'Islam';
  void setSelectedReligion(String religion){
    selectedReligion = religion;
    update();
  }



  bool isLoading = false;
  Future<void> addNewStudent(StudentBody studentBody) async {
    isLoading = true;
    update();
    Response? response = await studentRepository.addNewStudent(studentBody, thumbnail);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.toNamed(RouteHelper.getStudentListRoute());
      showCustomSnackBar("student_added_successfully".tr, isError: false);
      thumbnail = null;
      getStudentList(
          Get.find<ClassController>().selectedClassItem!.id!,
          groupId :Get.find<GroupController>().groupItem?.id,
          sectionId: Get.find<SectionController>().selectedSectionItem?.id);
      getAllStudentList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> updateStudent(StudentBody studentBody, int id) async {
    isLoading = true;
    update();
    Response? response = await studentRepository.updateStudent(studentBody, thumbnail, id);
    if(response?.statusCode == 200){
      isLoading = false;
      thumbnail = null;
      Get.toNamed(RouteHelper.getStudentListRoute());
      Get.back();
      showCustomSnackBar("updated_successfully".tr, isError: false);
      getStudentList(
          Get.find<ClassController>().selectedClassItem!.id!,
          groupId :Get.find<GroupController>().groupItem?.id,
          sectionId: Get.find<SectionController>().selectedSectionItem?.id);
      getAllStudentList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }

  StudentDetailsModel? studentDetailsModel;
  Future<void> studentDetails(int id) async {
    Response? response = await studentRepository.studentDetails(id);
    if(response?.statusCode == 200){
      studentDetailsModel = StudentDetailsModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> deleteStudent(int id) async {
    Response? response = await studentRepository.deleteStudent(id);
    if(response?.statusCode == 200){
      Get.back();
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getStudentList(Get.find<ClassController>().selectedClassItem?.id??0);
      getAllStudentList(1);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  Future<void> updateStudentStatus(int id, String type) async {
    Response? response = await studentRepository.updateStatus(id, type);
    if(response?.statusCode == 200){
      getStudentList(
          Get.find<ClassController>().selectedClassItem!.id!,
          groupId :Get.find<GroupController>().groupItem?.id,
          sectionId: Get.find<SectionController>().selectedSectionItem?.id);
      getAllStudentList(1);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }


  Future<void> downloadSampleFileForBulkStudent() async {
    ReportDownloader.downloadReport(
      endpoint: AppConstants.bulkStudentImportSampleFileDownload,
      fileNamePrefix: 'sample_student_import',
      fileExtension: 'csv',
      mimeType: 'text/csv',
    );
  }

  Future<void> uploadBulkStudent(int sessionId, int classId, int groupId, int sectionId) async {
    isLoading = true;
    update();
    Response? response = await studentRepository.bulkStudentImport(sessionId, classId, groupId, sectionId, documentFile!);
    if(response?.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("student_bulk_imported_successfully".tr, isError: false);
      getStudentList(classId, groupId: groupId, sectionId: sectionId);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  MultipartDocument? documentFile;
  String? selectedDocument;
  PlatformFile? docFile;
  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if (result != null) {
      docFile = result.files.single;
      documentFile = MultipartDocument('file', docFile);
      if (docFile != null) {
        selectedDocument = docFile?.name;
      }
    }
    update();
  }

  void updateSelection(int index){
    studentModel?.data?.data?[index].isSelected = !studentModel!.data!.data![index].isSelected!;
    update();
  }


  StudentItem? selectedStudentItem;
  void setSelectedStudent(StudentItem student) {
    selectedStudentItem = student;
    update();
  }

}