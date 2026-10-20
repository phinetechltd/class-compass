import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/sent_sms_body.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/user_list_for_sms_model.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/user_list_for_sms_widget.dart';
import 'package:class_compass/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:class_compass/feature/sms/sms_template/presentation/widgets/select_sms_template_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class SentNewSmsWidget extends StatefulWidget {
  const SentNewSmsWidget({super.key});

  @override
  State<SentNewSmsWidget> createState() => _SentNewSmsWidgetState();
}

class _SentNewSmsWidgetState extends State<SentNewSmsWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.find<SentSmsController>().getUserListFoeSms("Student");
    if(Get.find<SentSmsController>().userListForSmsModel == null){
      Get.find<SentSmsController>().getUserListFoeSms("Student");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SentSmsController>(builder: (smsController) {
      return SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault),
          child: Column(children: [

            const SelectSmsTemplateWidget(),

            CustomTextField(title: "sms_content".tr,
                controller: smsController.smsContentController,
                minLines: 3,
                maxLength: 150,
                maxLines: 5,
                inputType: TextInputType.multiline,
                inputAction: TextInputAction.newline,
                hintText: "sms_content".tr),


            const SizedBox(height: Dimensions.paddingSizeDefault),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(child: Column(children: [
                const CustomTitle(title: "user_type"),

                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdown(width: Get.width, title: "select".tr,
                    items: smsController.userTypesForSms,
                    selectedValue: smsController.selectedUserType,
                    onChanged: (val){
                    smsController.changeUserType(val!);
                    },
                  )),
              ],)),


              if(smsController.userListForSmsModel != null)
                const SizedBox(width: Dimensions.paddingSizeSmall),
              if(smsController.userListForSmsModel != null)
                Padding(padding: const EdgeInsets.only(bottom: 5),
                  child: CustomContainer(width: 40, height: 40, borderRadius: 5,
                    child: Checkbox(value: smsController.isAllSelected,
                        onChanged: (val){
                      smsController.toggleAllUser();
                    }),
                  ),
                )
            ],),

            UserListForSmsWidget(scrollController: scrollController, showRouteSection: false),

            const SizedBox(height: Dimensions.paddingSizeDefault,),

            smsController.isLoading? const Center(child: CircularProgressIndicator()):
            CustomButton(text: "confirm".tr, onTap: () {

              List<Users> selected = [];

              for(UserItemForSms user in smsController.userListForSmsModel?.data??[]){
                if(user.selected?? false){
                  selected.add(Users(userId: user.id, mobileNumber: user.phone));
                }
              }



              int? templateId = Get.find<SmsTemplateController>().selectedSmsTemplateItem?.id;
              String details = smsController.smsContentController.text.trim();
              String type = smsController.selectedUserType;

              if(templateId == null){
                showCustomSnackBar("select_sms_template".tr);
              }
              else if(details.isEmpty){
                showCustomSnackBar("description_is_empty".tr);
              }
              else if(selected.isEmpty){
                showCustomSnackBar("select_at_least_one_user".tr);
              }
              else{

                SentSmsBody body = SentSmsBody(
                  userType: type,
                  body: details,
                  users: selected);

                Get.dialog(ConfirmationDialog(action: true,
                    title: "are_you_sure_to_send_sms".tr,
                    content: "can_not_be_undone".tr, onTap: (){
                  Get.back();
                  smsController.sentSms(body);
                }));
              }
            })
          ]),
        ));
        }
    );
  }
}
