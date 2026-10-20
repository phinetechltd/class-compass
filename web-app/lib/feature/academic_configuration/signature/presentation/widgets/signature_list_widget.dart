import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:class_compass/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:class_compass/feature/academic_configuration/signature/presentation/screens/create_new_signature_screen.dart';
import 'package:class_compass/feature/academic_configuration/signature/presentation/widgets/signature_item_widget.dart';

class SignatureListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final bool fromSelection;
  final bool fromTeacherSelection;
  const SignatureListWidget({super.key, required this.scrollController,
    this.fromSelection = false, this.fromTeacherSelection = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignatureController>(
      initState: (val) => Get.find<SignatureController>().getSignatureList(1),
      builder: (signatureController) {
        final signatureModel = signatureController.signatureModel;
        final signatureData = signatureModel?.data;

        return GenericListSection<SignatureItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["signature_list".tr],
          addNewTitle: "add_new_signature".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "signature".tr,
              child: const CreateNewSignatureScreen())),
          headings: const ["image", "name","position", ],

          scrollController: scrollController,
          isLoading: signatureModel == null,
          totalSize: signatureData?.total ?? 0,
          offset: signatureData?.currentPage ?? 0,
          onPaginate: (offset) async => await signatureController.getSignatureList(offset ?? 1),
          items: signatureData?.data ?? [],
          itemBuilder: (item, index) => InkWell(
            onTap: (){
              if(fromSelection) {
                Get.back();
                if (fromTeacherSelection) {
                  Get.find<SignatureController>().setSelectedSignatureItem(
                      item, notify: true, teacher: true);
                }else{
                  Get.find<SignatureController>().setSelectedSignatureItem(
                      item, notify: true);
                }
              }
              },
              child: SignatureItemWidget(index: index, signatureItem: item)),
        );
      },
    );
  }
}