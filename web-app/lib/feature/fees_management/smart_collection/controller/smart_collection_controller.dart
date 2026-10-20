
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/calculation_body.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_body.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_details_model.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_model.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/sub_head_wise_collection_body.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/repository/smart_collection_repository.dart';
import 'package:class_compass/helper/route_helper.dart';

class SmartCollectionController extends GetxController implements GetxService{
  final SmartCollectionRepository smartCollectionRepository;
  SmartCollectionController({required this.smartCollectionRepository});


  bool isLoading = false;
  SmartCollectionModel? smartCollectionModel;
  Future<void> getStudentListForSmartCollection(int classId, int? sectionId, int page) async {
    isLoading = true;
    update();
    Response? response = await smartCollectionRepository.getStudentListForSmartCollection(classId, sectionId, page);
    if(response?.statusCode == 200){
      if(page == 1){
        smartCollectionModel = SmartCollectionModel.fromJson(response?.body);
      }else{
        smartCollectionModel?.data?.students?.data?.addAll(SmartCollectionModel.fromJson(response?.body).data!.students!.data!);
        smartCollectionModel?.data?.students?.currentPage = SmartCollectionModel.fromJson(response?.body).data?.students?.currentPage;
        smartCollectionModel?.data?.students?.total = SmartCollectionModel.fromJson(response?.body).data?.students?.total;

      }
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();

  }



  SmartCollectionDetailsModel? smartCollectionDetailsModel;
  Future<void> getSmartCollectionDetails(int id, int index) async {
    smartCollectionModel?.data?.students?.data?[index].loading = true;
    update();
    Response? response = await smartCollectionRepository.getSmartCollectionDetails(id);
    if(response?.statusCode == 200){
      smartCollectionDetailsModel = SmartCollectionDetailsModel.fromJson(response?.body);
      Get.toNamed(RouteHelper.getQuickCollectionDetailsRoute(id.toString()));

      smartCollectionModel?.data?.students?.data?[index].loading = false;
    }else{
      smartCollectionModel?.data?.students?.data?[index].loading = false;
      ApiChecker.checkApi(response!);
    }
    update();

  }



  List<CalculationModel> calculationModel = [];
  List<TextEditingController> paidControllers = [];
  Future<void> getSubHeadWiseCalculation(SubHeadWiseCollectionBody subHeadWiseBody) async {
    isLoading = true;
    update();
    Response? response = await smartCollectionRepository.getSubHeadWiseCalculation(subHeadWiseBody);

    if (response?.statusCode == 200) {
      calculationModel = [];
      paidControllers = [];
      response?.body.forEach((collection) {
        final model = CalculationModel.fromJson(collection);
        calculationModel.add(model);
        paidControllers.add(TextEditingController(text: (model.amounts?.totalPaid ?? 0).toString()));
      });

      isLoading = false;
    } else {
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  void updatePaidAmount(int index, String value) {
    double paid = double.tryParse(value) ?? 0;

    calculationModel[index].amounts?.totalPaid = paid;

    // Example recalculation
    double feePayable = calculationModel[index].amounts?.feePayable ?? 0;
    double finePayable = calculationModel[index].amounts?.finePayable ?? 0;
    double waiver = calculationModel[index].amounts?.waiver ?? 0;

    calculationModel[index].amounts?.totalPayable =
        feePayable + finePayable - waiver - paid;

    update();
  }

  List<String> academicYears = ["2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030"];
  String selectedYear = "2023";
  void setSelectedYear(String year){
    selectedYear = year;
    update();
  }

  void toggleSelectionFeeSubHead(int index, int subHeadIndex){
    smartCollectionDetailsModel!.data!.feeHeads![index].feeSubHeads![subHeadIndex].selected = !smartCollectionDetailsModel!.data!.feeHeads![index].feeSubHeads![subHeadIndex].selected!;
    update();
  }


  double attendanceFineAmount = 0;
  Future<void> getAttendanceFine(String id) async {
    Response? response = await smartCollectionRepository.getAttendanceFine(int.parse(id));
    if (response?.statusCode == 200) {
      attendanceFineAmount = response?.body["attendance_fine"];
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  double labFineAmount = 0;
  Future<void> getLabFine(String id) async {
    Response? response = await smartCollectionRepository.labFine(int.parse(id));
    if (response?.statusCode == 200) {
      labFineAmount = response?.body["lab_fine"];
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  double quizFineAmount = 0;
  Future<void> quizFile(String id) async {
    Response? response = await smartCollectionRepository.quizFile(int.parse(id));
    if (response?.statusCode == 200) {
      quizFineAmount = response?.body["quiz_fine"];
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  double tcChargeAmount = 0;
  Future<void> tcAmount() async {
    Response? response = await smartCollectionRepository.tcAmount();
    if (response?.statusCode == 200) {
      tcChargeAmount = response?.body["tc"];
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool attendanceFineChecked = false;
   toggleAttendanceFine(){
     attendanceFineChecked = !attendanceFineChecked;
     if(attendanceFineChecked){
       getAttendanceFine(smartCollectionDetailsModel!.data!.studentSession!.studentId!);
     }else{
       attendanceFineAmount = 0;
     }
     update();
  }

  bool labFineChecked = false;
   toggleLabFine(){
     labFineChecked = !labFineChecked;
     if(labFineChecked){
       getLabFine(smartCollectionDetailsModel!.data!.studentSession!.studentId!);
     }else{
       labFineAmount = 0;
     }
     update();
  }

  bool quizFineChecked = false;
   toggleQuizFine(){
     quizFineChecked = !quizFineChecked;
     if(quizFineChecked){
       quizFile(smartCollectionDetailsModel!.data!.studentSession!.studentId!);
     } else{
       quizFineAmount = 0;
     }
     update();
  }

  bool tcChargeChecked = false;
   toggleTCCharge(){
     tcChargeChecked = !tcChargeChecked;
     if(tcChargeChecked){
       tcAmount();
     } else{
       tcChargeAmount = 0;
     }
     update();
  }


  bool sendSms = false;
   toggleSendSms(){
     sendSms = !sendSms;
     update();
  }

  List<String> paymentMethodList = ["cash", "bank", "mfs"];
  String? selectedPaymentMethod;
  void setSelectedPaymentMethod(String method){
    selectedPaymentMethod = method;
    update();
  }

  Future<void> collectSmartCollection(SmartCollectionBody smartCollectionBody) async {
    isLoading = true;
    update();
    Response? response = await smartCollectionRepository.collectSmartCollection(smartCollectionBody);
    if (response?.statusCode == 200) {
      isLoading = false;
      showCustomSnackBar("successfully_collected".tr, isError: false);
      getSmartCollectionDetails(int.parse(smartCollectionBody.studentId!), 0);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

}