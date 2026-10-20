import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/controller/pick_image_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_pick_image_widget.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/common/widget/select_blood_group_section_widget.dart';
import 'package:class_compass/common/widget/select_gender_section_widget.dart';
import 'package:class_compass/common/widget/select_religion_section_widget.dart';
import 'package:class_compass/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:class_compass/feature/academic_configuration/department/presentation/widgets/department_selection_widget.dart';
import 'package:class_compass/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:class_compass/feature/academic_configuration/picklist/domain/models/pick_list_model.dart';
import 'package:class_compass/feature/academic_configuration/picklist/presentation/widgets/picklist_selection_widget.dart';
import 'package:class_compass/feature/master_configuration/employee/presentation/widgets/select_role_widget.dart';
import 'package:class_compass/feature/master_configuration/role/controller/role_controller.dart';
import 'package:class_compass/feature/staff_information/staff/controller/staff_controller.dart';
import 'package:class_compass/feature/staff_information/staff/domain/models/staff_model.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:class_compass/feature/staff_information/teacher/domain/model/teacher_body.dart';
import 'package:class_compass/helper/email_checker.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AddNewTeacherWidget extends StatefulWidget {
  final bool fromStaff;
  final StaffItem? teacherItem;
  const AddNewTeacherWidget({super.key, required this.fromStaff, this.teacherItem});

  @override
  State<AddNewTeacherWidget> createState() => _AddNewTeacherWidgetState();
}

class _AddNewTeacherWidgetState extends State<AddNewTeacherWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController serialController = TextEditingController();


  bool update = false;

  @override
  void initState() {
    if(widget.teacherItem != null){
      update = true;
      nameController.text = widget.teacherItem?.name ?? '';
      emailController.text = widget.teacherItem?.email ?? '';
      phoneNumberController.text = widget.teacherItem?.phone ?? '';
      serialController.text = widget.teacherItem?.sl??'1';
      Get.find<PickListController>().selectPicklistItem(PickListItem(
        id: 1,
        value: widget.teacherItem?.designation,
      ), notify: false);

    }

    Get.find<PickImageController>().removeImage(isUpdate: false);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherController>(builder: (teacherController) {
      return GetBuilder<StudentController>(builder: (commonController) {
        return GetBuilder<StaffController>(builder: (staffController) {
          return CustomContainer(
            child: SingleChildScrollView(
              child: Column(spacing: Dimensions.paddingSizeSmall, children: [

                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: CustomTextField(hintText: "name".tr, title: "name".tr,
                      controller: nameController)),

                  Expanded(child: CustomTextField(hintText: "serial".tr,
                      title: "serial".tr,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      inputType: TextInputType.number,
                      controller: serialController))
                ]),

                const Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectPicklistWidget()),
                  Expanded(child: SelectDepartmentWidget()),
                  Expanded(child: SelectRoleWidget()),
                ]),


                const Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectGenderSectionWidget()),
                  Expanded(child: SelectBloodGroupSectionWidget()),
                  Expanded(child: SelectReligionSectionWidget()),
                ]),

                 Row(spacing: Dimensions.paddingSizeDefault, children: [
                  const Expanded(child: DateSelectionWidget()),
                  Expanded(child: CustomTextField(hintText: "phone_number".tr, title: "phone_number".tr,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      inputType: TextInputType.phone,
                      controller: phoneNumberController),)
                ]),


                CustomContainer(showShadow: false,
                    border: Border.all(color: Theme.of(context).hintColor),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("login_info".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  CustomTextField(hintText: "email".tr, title: "email".tr,
                      controller: emailController),
                  Row(spacing: Dimensions.paddingSizeDefault, children: [
                    Expanded(child: CustomTextField(hintText: "password".tr, title: "password".tr,
                        controller: passwordController, isPassword: true)),

                    Expanded(child:  CustomTextField(hintText: "confirm_password".tr, title: "confirm_password".tr,
                        controller: confirmPasswordController, isPassword: true),)
                  ]),
                ])),






                const CustomTitle(title: "image",),
                 CustomPickImageWidget(
                   imageUrl: "${AppConstants.baseUrl}/storage/users/${widget.teacherItem?.image}",),
                // const SelectProfileImageWidget(),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                (teacherController.isLoading || staffController.isLoading)? const Center(child: CircularProgressIndicator()):
                CustomButton(onTap: (){
                  String name = nameController.text.trim();
                  String? designation = Get.find<PickListController>().selectedPicklistItem?.value;
                  int? role = Get.find<RoleController>().selectedRoleItem?.id;
                  String email = emailController.text.trim();
                  String phoneNumber = phoneNumberController.text.trim();
                  String password = passwordController.text.trim();
                  String confirmPassword = confirmPasswordController.text.trim();
                  String gender = commonController.selectedGender;
                  String bloodGroup = commonController.selectedBloodGroup;
                  String religion = commonController.selectedReligion;
                  String serial = serialController.text.trim();
                  String joiningDate = Get.find<DatePickerController>().formatedDate;
                  int? departmentId = Get.find<DepartmentController>().selectedDepartmentItem?.id;


                  if(name.isEmpty){
                    showCustomSnackBar("name_is_empty".tr);
                  }else if(designation == null){
                    showCustomSnackBar("select_designation".tr);
                  }else if(departmentId == null){
                    showCustomSnackBar("select_department".tr);
                  }
                  else if(role == null){
                    showCustomSnackBar("select_role".tr);
                  }
                  else if(phoneNumber.isEmpty){
                    showCustomSnackBar("phone_number_is_empty".tr);
                  }
                  else if(email.isEmpty){
                    showCustomSnackBar("email_is_empty".tr);
                  }
                  else if(EmailChecker.isNotValid(email)){
                    showCustomSnackBar("invalid_email".tr);
                  }
                  else if(!update && password.isEmpty){
                    showCustomSnackBar("password_is_empty".tr);
                  }
                  else if(!update && password.length < 8){
                    showCustomSnackBar("password_should_be_at_least_8_characters".tr);
                  }
                  else if(!update && confirmPassword.isEmpty){
                    showCustomSnackBar("confirm_password_is_empty".tr);
                  }
                  else if(!update && password!= confirmPassword){
                    showCustomSnackBar("password_and_confirm_password_not_match".tr);
                  }
                  else{
                    TeacherBody teacherBody =  TeacherBody(
                      name: name,
                      roleId: role,
                      designation: designation.toString(),
                      departmentId: departmentId.toString(),
                      gender: gender,
                      religion: religion,
                      blood: bloodGroup,
                      joiningDate: joiningDate,
                      sl: serial,
                      email: email,
                      phone: phoneNumber,
                      userType: widget.fromStaff? "staff" : "teacher",
                      password:  password,
                      passwordConfirmation: confirmPassword,
                      sMethod: widget.teacherItem != null? "put":"post"
                    );
                    if(widget.fromStaff){
                      if(widget.teacherItem != null){
                        Get.find<StaffController>().updateStaff(teacherBody, widget.teacherItem!.id!);
                      }else{
                        Get.find<StaffController>().addNewStaff(teacherBody);
                      }

                    }else{
                      if(widget.teacherItem != null){
                        teacherController.updateTeacher(teacherBody, widget.teacherItem!.id!);
                      }else {
                        teacherController.addNewTeacher(teacherBody);
                      }
                    }
                  }
                }, text: widget.teacherItem != null? "update".tr : "add".tr)
              ],),
            ),
          );
        }
        );
      }
      );
    });
  }
}
