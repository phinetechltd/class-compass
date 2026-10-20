
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/common/widget/image_picker_widget.dart';
import 'package:class_compass/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:class_compass/feature/master_configuration/employee/domain/models/employee_body.dart';
import 'package:class_compass/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:class_compass/feature/master_configuration/role/controller/role_controller.dart';
import 'package:class_compass/feature/master_configuration/role/presentation/widgets/role_dropdown.dart';
import 'package:class_compass/helper/email_checker.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewEmployeeWidget extends StatefulWidget {
  final EmployeeItem? employeeItem;
  const CreateNewEmployeeWidget({super.key, this.employeeItem});

  @override
  State<CreateNewEmployeeWidget> createState() => _CreateNewEmployeeWidgetState();
}

class _CreateNewEmployeeWidgetState extends State<CreateNewEmployeeWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool update = false;
  @override
  void initState() {
    if(Get.find<RoleController>().roleModel == null){
      Get.find<RoleController>().getRoleList(1);
    }

    if(widget.employeeItem != null){
      update = true;
      nameController.text = widget.employeeItem?.name??'';
      emailController.text = widget.employeeItem?.email??'';
      phoneController.text = widget.employeeItem?.phone??'';

    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(builder: (employeeController) {
      return Column(mainAxisSize: MainAxisSize.min, children: [


        CustomTextField(title: "name".tr,
          controller: nameController,
          hintText: "enter_name".tr,),

        Row(spacing: Dimensions.paddingSizeDefault,children: [
          Expanded(
            child: CustomTextField(title: "email".tr,
              controller: emailController,
              hintText: "enter_email".tr)),

          Expanded(
            child: CustomTextField(title: "phone".tr,
              controller: phoneController,
              isAmount: true,
              hintText: "enter_phone".tr)),
            ]),

        Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: CustomTextField(title: "password".tr,
            controller: passwordController,
            isAmount: true,
            hintText: "password".tr)),


          Expanded(child: CustomTextField(title: "confirm_password".tr,
            controller: confirmPasswordController,
            isAmount: true,
            hintText: "confirm_password".tr)),
        ]),

        Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: Column(children: [
            const Padding(padding: EdgeInsets.only(top: 8.0),
                child: CustomTitle(title: "user_type")),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomDropdown(width: Get.width, title: "select".tr,
                items: employeeController.userType,
                selectedValue: employeeController.selectedUserType,
                onChanged: (val){
                employeeController.setSelectedUserType(val!);
                })),
          ])),

          Expanded(child: Column(children: [
            const CustomTitle(title: "role"),
            GetBuilder<RoleController>(builder: (roleController) {
              return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RoleDropdown(width: Get.width, title: "select".tr,
                      items: roleController.roleModel?.data?.data??[],
                      selectedValue: roleController.selectedRoleItem,
                      onChanged: (val){
                    roleController.setRoleItem(val!);
                  }));
            }),
          ]))
        ]),


        ImagePickerWidget(onImagePicked: () => employeeController.pickImage(),
            pickedFile: employeeController.thumbnail,imageUrl: widget.employeeItem?.avatar??'',
            title: "image".tr),


        employeeController.isLoading? const Padding(padding: EdgeInsets.all(8.0), child: Center(child: CircularProgressIndicator())):
        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomButton(onTap: (){
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  String phone = phoneController.text.trim();
                  String password = passwordController.text.trim();
                  String confirmPassword = confirmPasswordController.text.trim();
                  String? userType = employeeController.selectedUserType;
                  int? role = Get.find<RoleController>().selectedRoleItem?.id;
                  if(name.isEmpty){
                    showCustomSnackBar("name_is_empty".tr);
                  }else if(email.isEmpty){
                    showCustomSnackBar("email_is_empty".tr);
                  }
                  else if(EmailChecker.isNotValid(email)){
                    showCustomSnackBar("email_is_not_valid".tr);
                  }
                  else if(phone.isEmpty){
                    showCustomSnackBar("phone_is_empty".tr);
                  }
                  else if(password.isEmpty){
                    showCustomSnackBar("password_is_empty".tr);
                  }
                  else if(password.length < 6){
                    showCustomSnackBar("password_must_be_at_least_6_characters".tr);
                  }
                  else if(confirmPassword.isEmpty){
                    showCustomSnackBar("confirm_password_is_empty".tr);
                  }
                  else if(password != confirmPassword){
                    showCustomSnackBar("password_not_match".tr);
                  }

                  else if(userType == null){
                    showCustomSnackBar("user_type_is_empty".tr);
                  }
                  else if(role == null){
                    showCustomSnackBar("role_is_empty".tr);
                  }
                  else{
                    EmployeeBody employeeBody = EmployeeBody(
                        name: name,
                        email: email,
                        phone: phone,
                        userType: userType,
                        password: password,
                        passwordConfirmation: confirmPassword,
                        roleId: role);

                    if(update){
                      employeeController.updateEmployee(employeeBody, widget.employeeItem!.id!);
                    }else{
                      employeeController.createNewEmployee(employeeBody);
                    }

                  }
                }, text: update? "update".tr : "save".tr))
          ],);
        }
    );
  }
}
