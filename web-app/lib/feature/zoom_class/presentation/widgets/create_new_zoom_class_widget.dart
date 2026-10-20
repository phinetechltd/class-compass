import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/zoom_class/domain/model/zoom_body.dart';
import 'package:class_compass/feature/zoom_class/domain/model/zoom_class_model.dart';
import 'package:class_compass/feature/zoom_class/logic/zoom_class_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewZoomClassWidget extends StatefulWidget {
  final ZoomItem? zoomItem;
  final int? courseId;
  const CreateNewZoomClassWidget({super.key, this.zoomItem, this.courseId});

  @override
  State<CreateNewZoomClassWidget> createState() => _CreateNewZoomClassWidgetState();
}

class _CreateNewZoomClassWidgetState extends State<CreateNewZoomClassWidget> {
  TextEditingController topicController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController agendaController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.zoomItem != null){
      update = true;
      topicController.text = widget.zoomItem?.topic??'';
      durationController.text = widget.zoomItem?.duration.toString()??'';
      passwordController.text = widget.zoomItem?.password??'';
      agendaController.text = widget.zoomItem?.agenda??'';

      
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomClassController>(builder: (zoomClassController) {
      return Column(mainAxisSize: MainAxisSize.min,
        spacing: Dimensions.paddingSizeDefault, children: [

          CustomTextField(title: "topic".tr,
            controller: topicController,
            hintText: "topic".tr,),

          const DateSelectionWidget(),

          CustomTextField(title: "duration".tr,
              controller: durationController,
              inputType: TextInputType.number,
              inputFormatters: [AppConstants.numberFormat],
              hintText: "duration_in_a_minute".tr,),

          CustomTextField(title: "password".tr,
              controller: passwordController,
              hintText: "password".tr,),

          CustomTextField(title: "agenda".tr,
              controller: agendaController,
              hintText: "agenda".tr),


          zoomClassController.isLoading?
          const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):

          Padding(padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault),
                child: CustomButton(onTap: (){

                  String topic = topicController.text.trim();
                  String? startTime = Get.find<DatePickerController>().isoTime;
                  String duration = durationController.text.trim();
                  String password = passwordController.text.trim();
                  String agenda = agendaController.text.trim();
                  if(topic.isEmpty){
                    showCustomSnackBar("topic".tr);
                  }else if(startTime == null){
                    showCustomSnackBar("start_time".tr);
                  }else if(duration.isEmpty){
                    showCustomSnackBar("duration".tr);
                  }
                  else if(password.isEmpty){
                    showCustomSnackBar("password".tr);
                  }
                  else if(agenda.isEmpty){
                    showCustomSnackBar("agenda".tr);
                  }
                  else{
                    ZoomBody body = ZoomBody(
                      topic: topic,
                      startTime: startTime,
                      duration: int.parse(duration),
                      password: password,
                      agenda: agenda,
                    );
                    if(update){
                      zoomClassController.editZoomClass(body, widget.zoomItem!.id!);
                    }else{
                      zoomClassController.createZoomClass(body);
                    }
                  }
                }, text: "confirm".tr))
          ],);
        }
    );
  }
}
