import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/feature/layout_and_certificate/domain/models/layout_and_certificate_model.dart';
import 'package:class_compass/feature/layout_and_certificate/domain/repository/layout_and_certificate_repository.dart';

class LayoutAndCertificateController extends GetxController implements GetxService{
  final LayoutAndCertificateRepository layoutAndCertificateRepository;
  LayoutAndCertificateController({required this.layoutAndCertificateRepository});

  bool isLoading = false;
  LayoutAndCertificateModel? layoutAndCertificateModel;
  Future<void> getLayoutAndCertificate(String type, int classId, int sectionId, String roll) async {
    Response? response = await layoutAndCertificateRepository.getLayoutAndCertificate("general-certificate", classId, sectionId, roll);
    if (response.statusCode == 200) {
      layoutAndCertificateModel = LayoutAndCertificateModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}