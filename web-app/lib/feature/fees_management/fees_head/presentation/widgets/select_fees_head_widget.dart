import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/dropdown_with_search_widget.dart';
import 'package:class_compass/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_head/domain/model/fees_head_model.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/widgets/fees_head_list_widget.dart';


class SelectFeesHeadWidget extends StatefulWidget {
  final String? title;
  const SelectFeesHeadWidget({super.key, this.title});

  @override
  State<SelectFeesHeadWidget> createState() => _SelectFeesHeadWidgetState();
}

class _SelectFeesHeadWidgetState extends State<SelectFeesHeadWidget> {

  final searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if(Get.find<FeesHeadController>().feesHeadModel == null){
      Get.find<FeesHeadController>().getFeesHeadList(1);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesHeadController>(builder: (signatureController) {
      return DropdownSearch<FeesHeadItem>(
        sectionTitle: widget.title,
        selectedItem: signatureController.selectedFeesHeadItem,
        itemLabel: (item) => item.name ?? "",
        searchController: searchController,
        onSearch: (val) {
          signatureController.getFeesHeadList(1);
        },
        listWidgetBuilder: () => SingleChildScrollView(
          child: FeesHeadListWidget(fromSelection: true,
              scrollController: scrollController),
        ),
      );
    }
    );
  }
}
