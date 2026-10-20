import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/sms/phone_book/controller/phone_book_controller.dart';
import 'package:class_compass/feature/sms/phone_book/domain/models/phone_book_body.dart';
import 'package:class_compass/feature/sms/phone_book/domain/models/phone_book_model.dart';
import 'package:class_compass/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:class_compass/feature/sms/phone_book_category/domain/models/phone_book_category_model.dart';
import 'package:class_compass/feature/sms/phone_book_category/presentation/widgets/select_phone_book_category_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewPhoneBookScreen extends StatefulWidget {
  final PhoneBookItem? phoneBookItem;
  const CreateNewPhoneBookScreen({super.key, this.phoneBookItem});

  @override
  State<CreateNewPhoneBookScreen> createState() => _CreateNewPhoneBookScreenState();
}

class _CreateNewPhoneBookScreenState extends State<CreateNewPhoneBookScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.phoneBookItem != null){
      update = true;
      nameController.text = widget.phoneBookItem?.name??'';
      phoneController.text = widget.phoneBookItem?.phone??'';
      descriptionController.text = widget.phoneBookItem?.note??'';
      Get.find<PhoneBookCategoryController>().selectPhoneBookCategory(PhoneBookCategoryItem(
          name: widget.phoneBookItem?.category?.name??'',
          description: widget.phoneBookItem?.category?.description??'',
          id: int.parse(widget.phoneBookItem!.categoryId!)), notify: false);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneBookController>(builder: (phoneBookController) {
        return Column(mainAxisSize: MainAxisSize.min, children: [

          const SelectPhoneBookCategoryWidget(),

          CustomTextField(title: "name".tr,
            controller: nameController,
            hintText: "enter_name".tr,),

          CustomTextField(title: "phone".tr,
            inputType: TextInputType.phone,
            inputFormatters: [AppConstants.phoneNumberFormat],
            controller: phoneController,
            hintText: "enter_phone".tr,),

          CustomTextField(title: "notes".tr,
            controller: descriptionController,
            hintText: "notes".tr,),


          phoneBookController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Center(child: CircularProgressIndicator())):

          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: CustomButton(onTap: (){
              String name = nameController.text.trim();
              int? categoryId = Get.find<PhoneBookCategoryController>().selectedPhoneBookCategoryItem?.id;
              String phone = phoneController.text.trim();
              String description = descriptionController.text.trim();
              if(categoryId == null){
                showCustomSnackBar("select_category".tr);
              }
              else if(name.isEmpty){
                showCustomSnackBar("name_is_empty".tr);
              }else if(phone.isEmpty){
                showCustomSnackBar("phone_is_empty".tr);
              }else{
                PhoneBookBody body = PhoneBookBody(
                  name: name,
                  phone: phone,
                  categoryId: categoryId,
                  note: description,
                );
                if(update){
                  phoneBookController.updatePhoneBook(body, widget.phoneBookItem!.id!);
                }else{
                  phoneBookController.createPhoneBook(body);
                }

              }
            }, text: update? "update".tr : "save".tr))
        ],);
      }
    );
  }
}
