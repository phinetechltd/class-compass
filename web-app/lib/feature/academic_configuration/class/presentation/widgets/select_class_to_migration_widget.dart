import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/class_dropdown.dart';

class SelectClassWidgetToMigrationWidget extends StatefulWidget {
  final String? title;
  const SelectClassWidgetToMigrationWidget({super.key, this.title,});

  @override
  State<SelectClassWidgetToMigrationWidget> createState() => _SelectClassWidgetToMigrationWidgetState();
}

class _SelectClassWidgetToMigrationWidgetState extends State<SelectClassWidgetToMigrationWidget> {
  @override
  void initState() {
    if(Get.find<ClassController>().classModel == null){
      Get.find<ClassController>().getClassList(perPage: 100);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(widget.title != "empty")
       CustomTitle(title: widget.title?? "class"),
      GetBuilder<ClassController>(
          builder: (classController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ClassDropdown(width: Get.width, title: "select_class".tr,
                items: classController.classModel?.data?.data??[],
                selectedValue: classController.selectedClassItemToMigration ,
                onChanged: (val) async {
                  classController.setSelectClass(val!, fromMigration: true);
                  await classController.loadClassDependencies(val.id!, fromMigration: true);
                },
              ),);
          }
      ),
    ],);
  }
}
