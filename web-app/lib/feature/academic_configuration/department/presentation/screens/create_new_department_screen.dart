import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:class_compass/feature/academic_configuration/department/domain/models/department_model.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewDepartmentScreen extends StatefulWidget {
  final DepartmentItem? departmentItem;
  const CreateNewDepartmentScreen({super.key, this.departmentItem});

  @override
  State<CreateNewDepartmentScreen> createState() => _CreateNewDepartmentScreenState();
}

class _CreateNewDepartmentScreenState extends State<CreateNewDepartmentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.departmentItem != null){
      update = true;
      nameController.text = widget.departmentItem?.name??'';
      descriptionController.text = widget.departmentItem?.description??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepartmentController>(builder: (departmentController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [

          CustomTextField(title: "name".tr,
            controller: nameController,
            hintText: "enter_name".tr,),

          CustomTextField(title: "priority".tr,
            controller: descriptionController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            hintText: "enter_priority".tr,),


          departmentController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Center(child: CircularProgressIndicator())):

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomButton(onTap: (){
              String name = nameController.text.trim();
              String description = descriptionController.text.trim();
              if(name.isEmpty){
                showCustomSnackBar("name_is_empty");
              }else if(description.isEmpty){
                showCustomSnackBar("priority_is_empty");
              }else{
                if(update){
                  departmentController.updateDepartment(name, description, widget.departmentItem!.id!);
                }else{
                  departmentController.createNewDepartment(name, description);
                }

              }
            }, text: update? "update".tr : "save".tr))
        ],);
      }
    );
  }
}
