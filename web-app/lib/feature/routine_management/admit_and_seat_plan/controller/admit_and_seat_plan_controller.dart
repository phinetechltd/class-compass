
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/model/admit_card_model.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/domain/repository/admit_and_seat_plan_repository.dart';

class AdmitAndSeatPlanController extends GetxController implements GetxService{
  final AdmitAndSeatPlanRepository admitAndSeatPlanRepository;
  AdmitAndSeatPlanController({required this.admitAndSeatPlanRepository});

  bool isLoading = false;
  AdmitCardModel? admitCardModel;
  Future<void> getAdmitAndSeatPlan(int classId, int examId, int sectionId, String type) async {

    isLoading = true;
    update();

    Response? response = await admitAndSeatPlanRepository.getSeatPlatAndAdmit(classId, examId, sectionId, type);
    if(response?.statusCode == 200){
      admitCardModel = AdmitCardModel.fromJson(response?.body);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();

  }

  int selectedType = 0;
  void selectType(int index){
    selectedType = index;
    update();
  }


}