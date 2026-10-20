import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/controller/pick_image_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_pick_image_widget.dart';
import 'package:class_compass/common/widget/custom_rich_text_editor_widget/custom_rich_editor.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/administrator/event/controller/event_controller.dart';
import 'package:class_compass/feature/administrator/event/domain/models/event_body.dart';
import 'package:class_compass/feature/administrator/event/domain/models/event_model.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewEventWidget extends StatefulWidget {
  final EventItem? eventItem;
  const CreateNewEventWidget({super.key, this.eventItem});

  @override
  State<CreateNewEventWidget> createState() => _CreateNewEventWidgetState();
}

class _CreateNewEventWidgetState extends State<CreateNewEventWidget> {
  TextEditingController eventStartDareController = TextEditingController();
  TextEditingController eventEndDareController = TextEditingController();
  TextEditingController eventTitleController = TextEditingController();
  final HtmlEditorController eventDetailsController = HtmlEditorController();
  TextEditingController eventLocationController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.eventItem != null){
      update = true;
      eventTitleController.text = widget.eventItem?.name??'';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 2000), () async {
          eventDetailsController.setText(widget.eventItem?.details??'');
        });
      });

      eventLocationController.text = widget.eventItem?.location??'';
      eventStartDareController.text = widget.eventItem?.startDate??'';
      eventEndDareController.text = widget.eventItem?.endDate??'';
    }
    Get.find<PickImageController>().removeImage(isUpdate: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: GetBuilder<EventController>(
          builder: (eventController) {
            return SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                Row(spacing: Dimensions.paddingSizeDefault,
                  crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Expanded(
                      child: Column(spacing: Dimensions.paddingSizeDefault, children: [

                        CustomPickImageWidget(imageUrl: "${AppConstants.imageBaseUrl}/events/${widget.eventItem?.image}",),


                        Row(children: [
                          Expanded(child: DateSelectionWidget( title: "start_date".tr,)),
                          const SizedBox(width: Dimensions.paddingSizeSmall),
                          Expanded(child:  DateSelectionWidget( title: "end_date".tr, end: true,))
                        ],
                        ),




                        Row(spacing: Dimensions.paddingSizeDefault,
                          children: [
                            Expanded(
                              child: CustomTextField(title: "title".tr,
                                controller: eventTitleController,
                                hintText: "title".tr,),
                            ),
                            Expanded(child: CustomTextField(title: "location".tr,
                              controller: eventLocationController,
                              hintText: "location".tr,),)
                          ],
                        ),

                        CustomRichEditor(controller: eventDetailsController,
                            title: "description".tr, hintText: "description".tr,
                            height: 250),



                      ]),
                    ),

                  ],
                ),





                eventController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomButton(onTap: () async {

                      String title = eventTitleController.text.trim();
                      String? details = await eventDetailsController.getText();
                      // String details = eventDetailsController.text.trim();
                      String location = eventLocationController.text.trim();
                      String start = Get.find<DatePickerController>().formatedDate;
                      String end = Get.find<DatePickerController>().formatedEndDate;
                      if(title.isEmpty){
                        showCustomSnackBar("title_is_empty".tr);
                      }
                      else if(details.isEmpty){
                        showCustomSnackBar("details_is_empty".tr);
                      }
                      else if(location.isEmpty){
                        showCustomSnackBar("location_is_empty".tr);
                      }
                      else if(start.isEmpty){
                        showCustomSnackBar("start_date_is_empty".tr);
                      }
                      else if(end.isEmpty){
                        showCustomSnackBar("end_date_is_empty".tr);
                      }
                      else{
                        EventBody eventBody = EventBody(
                          name: title,
                          details: details,
                          location: location,
                          startDate: start,
                          endDate: end,
                          sMethod: update? "put":"post"
                        );
                        if(update){
                          eventController.updateEvent(eventBody, widget.eventItem!.id!);
                        }else{
                          eventController.createNewEvent(eventBody);
                        }

                      }
                    }, text: "confirm".tr))
              ],),
            );
          }
      ),
    );
  }
}
