import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/common/widget/image_picker_widget.dart';
import 'package:class_compass/common/widget/responsive_grid_widget.dart';
import 'package:class_compass/common/widget/select_blood_group_section_widget.dart';
import 'package:class_compass/common/widget/select_gender_section_widget.dart';
import 'package:class_compass/common/widget/select_religion_section_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_body.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_model.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class AddNewStudentWidget extends StatefulWidget {
  final StudentItem? studentItem;
  const AddNewStudentWidget({super.key, this.studentItem});

  @override
  State<AddNewStudentWidget> createState() => _AddNewStudentWidgetState();
}

class _AddNewStudentWidgetState extends State<AddNewStudentWidget> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //guardian

  TextEditingController guardianNameController = TextEditingController();
  TextEditingController guardianRelationController = TextEditingController();
  TextEditingController guardianPhoneController = TextEditingController();
  TextEditingController guardianEmailController = TextEditingController();

  TextEditingController qrCodeController = TextEditingController();



  bool update = false;

  @override
  void initState() {
    if(widget.studentItem != null){
      update = true;
      firstNameController.text = widget.studentItem?.firstName??'';
      lastNameController.text = widget.studentItem?.lastName??'';
      fathersNameController.text = widget.studentItem?.fatherName??'';
      mothersNameController.text = widget.studentItem?.motherName??'';
      registrationNumberController.text = widget.studentItem?.registerNo??'';
      rollNumberController.text = widget.studentItem?.roll??'';
      addressController.text = widget.studentItem?.address??'';
      emailController.text = widget.studentItem?.email??'';
      phoneNumberController.text = widget.studentItem?.phone??'';
      qrCodeController.text = widget.studentItem?.qrCode??'';

      //guardian
      guardianNameController.text = widget.studentItem?.informationSentToName??'';
      guardianRelationController.text = widget.studentItem?.informationSentToRelation??'';
      guardianPhoneController.text = widget.studentItem?.informationSentToPhone??'';
      guardianEmailController.text = widget.studentItem?.informationSentToEmail??'';

      WidgetsBinding.instance.addPostFrameCallback((_) {

        Get.find<ClassController>().setSelectClass(
          ClassItem(id: widget.studentItem?.classId,
            className: widget.studentItem?.className,
          ),
        );

        Get.find<GroupController>().setSelectedGroupItem(
          GroupItem(id: widget.studentItem?.groupId,
            groupName: widget.studentItem?.groupName,
          ),
        );

        Get.find<SectionController>().setSelectSectionItem(
          SectionItem(id: widget.studentItem?.sectionId,
            sectionName: widget.studentItem?.sectionName,
          ),
        );
      });

    }
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    fathersNameController.dispose();
    mothersNameController.dispose();
    registrationNumberController.dispose();
    rollNumberController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    guardianNameController.dispose();
    guardianRelationController.dispose();
    guardianPhoneController.dispose();
    guardianEmailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(builder: (studentController) {
      return Padding(padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: CustomContainer(
            child: Column(spacing: Dimensions.paddingSizeDefault,
              mainAxisSize: MainAxisSize.min, children: [


              ResponsiveMasonryGrid(width: 250, children: [
                CustomTextField(
                  inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: qrCodeController,
                      hintText: "admission_number".tr,
                      maxLength: 6,
                      title: "admission_number".tr,
                    ),

                    CustomTextField(hintText: "first_name".tr,
                        title: "first_name".tr,
                        controller: firstNameController),

                    CustomTextField(hintText: "last_name".tr,
                        title: "last_name".tr,
                        controller: lastNameController),

                    CustomTextField(hintText: "fathers_name".tr,
                        title: "fathers_name".tr,
                        controller: fathersNameController),

                    CustomTextField(hintText: "mothers_name".tr,
                        title: "mothers_name".tr,
                        controller: mothersNameController),

                    CustomTextField(hintText: "guardian_name".tr,
                        title: "guardian_name".tr,
                        controller: guardianNameController),

                    CustomTextField(hintText: "guardian_relation".tr,
                        title: "guardian_relation".tr,
                        controller: guardianRelationController),

                    CustomTextField(hintText: "guardian_phone".tr,
                        inputFormatters: [AppConstants.phoneNumberFormat],
                        inputType: TextInputType.phone,
                        title: "guardian_phone".tr,
                        controller: guardianPhoneController),

                    CustomTextField(hintText: "guardian_email".tr,
                        title: "guardian_email".tr,
                        controller: guardianEmailController),

                    const SelectClassWidget(),

                    const SelectGroupWidget(),
                    const SelectSectionWidget(),
                    const SelectGenderSectionWidget(),

                    CustomTextField(hintText: "registration_number".tr,
                        title: "registration_number".tr,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: registrationNumberController),

                    CustomTextField(hintText: "roll_number".tr, title: "roll_number".tr,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: rollNumberController),

                    const SelectBloodGroupSectionWidget(),
                    const SelectReligionSectionWidget(),
                    CustomTextField(hintText: "email".tr,
                        title: "email".tr,
                        controller: emailController),

                    CustomTextField(hintText: "phone_number".tr,
                        title: "phone_number".tr,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: phoneNumberController),

                    CustomTextField(hintText: "password".tr,
                        title: "password".tr,
                        controller: passwordController,
                        isPassword: true),

                    CustomTextField(hintText: "confirm_password".tr,
                        title: "confirm_password".tr,
                        controller: confirmPasswordController,
                        isPassword: true),

                    CustomTextField(hintText: "address".tr,
                        title: "address".tr,
                        controller: addressController),

                  ]),

                  Text("note: Guardian login credential will be email address and password: 12345678",
                      style: textRegular.copyWith(color: Theme.of(context).hintColor)),




                  const CustomTitle(title: "image",),
                  ImagePickerWidget(imageUrl: "${AppConstants.imageBaseUrl}/users/${widget.studentItem?.image??''}",
                      pickedFile: studentController.thumbnail,
                      onImagePicked: ()=> studentController.pickImage()),


                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  studentController.isLoading? const Center(child: CircularProgressIndicator()):
                  GetBuilder<ClassController>(builder: (classController) {
                    return GetBuilder<GroupController>(builder: (groupController) {
                      return GetBuilder<SectionController>(builder: (sectionController) {
                          return CustomButton(onTap: (){
                                String firstName = firstNameController.text.trim();
                                String lastName = lastNameController.text.trim();
                                String fathersName = fathersNameController.text.trim();
                                String mothersName = mothersNameController.text.trim();
                                String registrationNumber = registrationNumberController.text.trim();
                                String rollNumber = rollNumberController.text.trim();
                                String address = addressController.text.trim();
                                String email = emailController.text.trim();
                                String phoneNumber = phoneNumberController.text.trim();
                                String password = passwordController.text.trim();
                                String confirmPassword = confirmPasswordController.text.trim();
                                int? classId = classController.selectedClassItem?.id;
                                int? groupId = groupController.groupItem?.id;
                                int? sectionId = sectionController.selectedSectionItem?.id;
                                String gender = studentController.selectedGender;
                                String bloodGroup = studentController.selectedBloodGroup;
                                String religion = studentController.selectedReligion;


                                String guardianName = guardianNameController.text.trim();
                                String guardianRelation = guardianRelationController.text.trim();
                                String guardianPhone = guardianPhoneController.text.trim();
                                String guardianEmail = guardianEmailController.text.trim();





                                if(firstName.isEmpty){
                                  showCustomSnackBar("first_name_is_empty".tr);
                                }
                                else if(lastName.isEmpty){
                                  showCustomSnackBar("last_name_is_empty".tr);
                                }

                                else if(classId == null){
                                  showCustomSnackBar("class_id_is_empty".tr);
                                }

                                else if(sectionId == null){
                                  showCustomSnackBar("section_id_is_empty".tr);
                                }
                                else if(registrationNumber.isEmpty){
                                  showCustomSnackBar("registration_number_is_empty".tr);
                                }
                                else if(rollNumber.isEmpty){
                                  showCustomSnackBar("roll_number_is_empty".tr);
                                }

                                else if(email.isNotEmpty && !GetUtils.isEmail(email)){
                                  showCustomSnackBar("email_is_invalid".tr);
                                }
                                else if(phoneNumber.isEmpty){
                                  showCustomSnackBar("phone_number_is_empty".tr);
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
                                else if(!update && password != confirmPassword){
                                  showCustomSnackBar("password_and_confirm_password_not_match".tr);
                                }

                                else if(guardianName.isEmpty){
                                  showCustomSnackBar("guardian_name_is_empty".tr);
                                }
                                else if(guardianRelation.isEmpty){
                                  showCustomSnackBar("guardian_relation_is_empty".tr);
                                }
                                else if(guardianPhone.isEmpty){
                                  showCustomSnackBar("guardian_phone_is_empty".tr);
                                }

                                else{
                                  StudentBody studentBody =  StudentBody(
                                    firstName: firstName,
                                    lastName: lastName,
                                    qrCode: qrCodeController.text.trim(),
                                    fatherName: fathersName,
                                    motherName: mothersName,
                                    registerNo: registrationNumber,
                                    roll: rollNumber,
                                    address: address,
                                    email: email,
                                    phone: phoneNumber,
                                    password:  password,
                                    passwordConfirmation: confirmPassword,
                                    classId: classId.toString(),
                                    group: groupId.toString(),
                                    sectionId: sectionId.toString(),
                                    gender: gender,
                                    bloodGroup: bloodGroup,
                                    religion: religion,
                                    informationSentToName: guardianName,
                                    informationSentToRelation: guardianRelation,
                                    informationSentToPhone: guardianPhone,
                                    informationSentToEmail: guardianEmail,
                                    method: update? "put" : "post"
                                  );
                                  if(update){
                                    studentController.updateStudent(studentBody, widget.studentItem!.id!);
                                  }else {
                                    studentController.addNewStudent(studentBody);
                                  }
                                }

                              }, text: update? "update".tr : "add_new_student".tr);
                        }
                      );
                        }
                      );
                    }
                  )


                ],),
              ),
            ),
          );
        }
    );
  }
}
