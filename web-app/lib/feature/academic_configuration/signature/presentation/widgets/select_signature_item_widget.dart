import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/dropdown_with_search_widget.dart';
import 'package:class_compass/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:class_compass/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:class_compass/feature/academic_configuration/signature/presentation/widgets/signature_list_widget.dart';


class SelectCustomerWithSearchWidget extends StatefulWidget {
  final String? title;
  final bool isTeacher;
  const SelectCustomerWithSearchWidget({super.key, this.title,
    this.isTeacher = false});

  @override
  State<SelectCustomerWithSearchWidget> createState() => _SelectCustomerWithSearchWidgetState();
}

class _SelectCustomerWithSearchWidgetState extends State<SelectCustomerWithSearchWidget> {

  final searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if(Get.find<SignatureController>().signatureModel == null){
      Get.find<SignatureController>().getSignatureList(1);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignatureController>(builder: (signatureController) {
          return DropdownSearch<SignatureItem>(
            sectionTitle: widget.title,
            selectedItem: widget.isTeacher? signatureController.selectedTeacherSignatureItem:
            signatureController.selectedSignatureItem,
            itemLabel: (item) => item.title ?? "",
            searchController: searchController,
            onSearch: (val) {
              signatureController.getSignatureList(1);
            },
            listWidgetBuilder: () => SingleChildScrollView(
              child: SignatureListWidget(fromSelection: true,
              fromTeacherSelection: widget.isTeacher,
              scrollController: scrollController),
            ),
          );
        }
    );
  }
}
