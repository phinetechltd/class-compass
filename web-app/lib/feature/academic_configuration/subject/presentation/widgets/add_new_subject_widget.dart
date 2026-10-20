import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_body.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/select_subject_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewSubjectWidget extends StatefulWidget {
  final SubjectItem? subjectItem;
  const AddNewSubjectWidget({super.key, this.subjectItem});

  @override
  State<AddNewSubjectWidget> createState() => _AddNewSubjectWidgetState();
}

class _AddNewSubjectWidgetState extends State<AddNewSubjectWidget> {
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController subjectCodeController = TextEditingController();
  TextEditingController subjectShortFormController = TextEditingController();
  TextEditingController serialNoController = TextEditingController();


  @override
  void initState() {
    if(widget.subjectItem != null){
      subjectNameController.text = widget.subjectItem?.subjectName??'';
      subjectCodeController.text = widget.subjectItem?.subjectCode??'';
      subjectShortFormController.text = widget.subjectItem?.subjectCode??'';
      serialNoController.text = widget.subjectItem?.slNo??'';
      Get.find<ClassController>().setSelectClass(ClassItem(
        id: int.parse(widget.subjectItem!.classId.toString()),
        className: widget.subjectItem?.className,
      ), notify: false);

      Get.find<SubjectController>().setSubjectType(widget.subjectItem?.subjectType??'', notify: false);
      // Get.find<SubjectController>().setSubjectTypeForm(widget.subjectItem?.subjectTypeForm??'', notify: false);

    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
        builder: (subjectController) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall,
              children: [

              const Row(spacing: Dimensions.paddingSizeDefault, children: [
                Expanded(child: SelectClassWidget()),
                Expanded(child: SelectGroupWidget()),
              ],),


              Row(spacing : Dimensions.paddingSizeSmall, children: [
                const Expanded(child: SelectSubjectTypeWidget()),

                Expanded(child: Column(children: [
                  const CustomTitle(title: "subject_type_form"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: subjectController.subjectTypeForms,
                      selectedValue: subjectController.selectedTypeForm,
                      onChanged: (val){
                        subjectController.setSubjectTypeForm(val!);
                      },
                    ),),
                ],)),
              ],),

              Row(spacing: Dimensions.paddingSizeSmall,
                children: [
                  Expanded(
                    child: CustomTextField(hintText: "subject_name".tr, title: "subject_name".tr,
                        controller: subjectNameController),
                  ),

                  Expanded(
                    child:  CustomTextField(hintText: "subject_code".tr, title: "subject_code".tr,
                        controller: subjectCodeController),
                  ),
                ],
              ),




              Row(children: [
                Expanded(
                    child: CustomTextField(hintText: "subject_short_form".tr, title: "subject_short_form".tr,
                        controller: subjectShortFormController),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: CustomTextField(hintText: "serial_no".tr, title: "serial_no".tr,
                        controller: serialNoController),
                  ),

              ],),






              const SizedBox(height: Dimensions.paddingSizeDefault),

              subjectController.isLoading? const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){

                String subjectName = subjectNameController.text.trim();
                String subjectCode = subjectCodeController.text.trim();
                String subjectShortForm = subjectShortFormController.text.trim();
                String serialNumber = serialNoController.text.trim();
                int? classId = Get.find<ClassController>().selectedClassItem?.id;
                int? groupId = Get.find<GroupController>().groupItem?.id;
                String subjectType = subjectController.selectedType;
                String subjectShortFormValue = subjectController.selectedTypeForm;





                if(subjectName.isEmpty){
                  showCustomSnackBar("subject_name_is_empty".tr);
                }
                else if(subjectCode.isEmpty){
                  showCustomSnackBar("subject_code_should_not_be_empty".tr);
                }
                else if(subjectShortForm.isEmpty){
                  showCustomSnackBar("subject_short_form_is_empty".tr);
                }
                else if(serialNumber.isEmpty){
                  showCustomSnackBar("serial_no_is_empty".tr);
                }
                else if(classId == null){
                  showCustomSnackBar("class_id_is_empty".tr);
                }
                else if(groupId == null){
                  showCustomSnackBar("group_id_is_empty".tr);
                }
                else{
                  SubjectBody subjectBody =  SubjectBody(
                    classId: classId,
                    groupId: groupId,
                    subjectName: subjectName,
                    subjectCode: subjectCode,
                    subjectShortForm: subjectShortForm,
                    subjectTypeForm: subjectShortFormValue,
                    subjectType: subjectType,
                    serialNo: serialNumber,
                    method: widget.subjectItem != null? "put":"post"
                  );
                  if(widget.subjectItem != null){
                    subjectController.updateSubject(widget.subjectItem!.id!, subjectBody);
                  }else{
                    subjectController.addNewSubject(subjectBody);
                  }

                }

              }, text: "confirm".tr)


            ],),
          );
        }
    );
  }
}
