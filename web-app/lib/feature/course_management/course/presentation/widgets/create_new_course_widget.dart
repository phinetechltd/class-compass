import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_rich_text_editor_widget/custom_rich_editor.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_body.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_category_section.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_faq_section.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_image_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/intro_video_widget.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CreateNewCourseWidget extends StatefulWidget {
  final CourseItem? courseItem;
  const CreateNewCourseWidget({super.key, this.courseItem});

  @override
  State<CreateNewCourseWidget> createState() => _CreateNewCourseWidgetState();
}



class _CreateNewCourseWidgetState extends State<CreateNewCourseWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController invoiceTitleController = TextEditingController();
  TextEditingController repeatCountController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController totalCycleController = TextEditingController();
  final HtmlEditorController descriptionHtmlController = HtmlEditorController();
  TextEditingController fakeStudentEnrollmentController = TextEditingController();
  TextEditingController classCountController = TextEditingController();
  TextEditingController noteCountController = TextEditingController();
  TextEditingController examCountController = TextEditingController();


  bool update = false;
  @override
  void initState() {
    if(widget.courseItem != null){
      update = true;
      titleController.text = widget.courseItem?.title??'';
      Get.find<CourseController>().videoUrlController.text = widget.courseItem?.videoUrl??'';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 2000), () async {
          descriptionHtmlController.setText(widget.courseItem?.description??'');
        });
      });
      priceController.text = widget.courseItem?.regularPrice?.toString()??'';
      offerPriceController.text = widget.courseItem?.offerPrice?.toString()??'';
      invoiceTitleController.text = widget.courseItem?.invoiceTitle??'';
      repeatCountController.text = widget.courseItem?.repeatCount?.toString()??'';
      durationController.text = widget.courseItem?.paymentDuration?.toString()??'';
      totalCycleController.text = widget.courseItem?.totalCycles?.toString()??'';
      fakeStudentEnrollmentController.text = widget.courseItem?.fakeEnrolledStudents?.toString()??'';
      classCountController.text = widget.courseItem?.totalClasses?.toString()??'';
      noteCountController.text = widget.courseItem?.totalNotes?.toString()??'';
      examCountController.text = widget.courseItem?.totalExams?.toString()??'';
      if(widget.courseItem?.videoType != null) {
        Get.find<CourseController>().setVideoType(
            widget.courseItem!.videoType!, notify: false);
      }
      if(widget.courseItem?.paymentType != null) {
        Get.find<CourseController>().setPaymentType(
            widget.courseItem!.paymentType!, notify: false);
      }
      log("hello ==> ${widget.courseItem?.status??''}");
      if(widget.courseItem?.status != null) {
        Get.find<CourseController>().setCourseStatus(
            widget.courseItem!.status!.toLowerCase(), notify: false);
      }
      if(widget.courseItem?.courseCategory != null){
        Get.find<CourseCategoryController>().setSelectCourseCategoryItem(
            widget.courseItem!.courseCategory!, notify: false);
      }
      if(widget.courseItem?.isAutoGenerateInvoice != null) {
        Get.find<CourseController>().toggleAutoGeneratingInvoice(
            widget.courseItem!.isAutoGenerateInvoice == 1, notify: false);
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(builder: (courseController) {

      return Column(children: [
        if(ResponsiveHelper.isDesktop(context))
          CustomRoutePathWidget(title: "course_management".tr, subWidget: Row(children: [
            PathItemWidget(title: "course".tr,onTap: ()=> Get.back()),
            PathItemWidget(title: "add_new_course".tr,color: Theme.of(context).primaryColor),
          ])),

        Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Dimensions.paddingSizeDefault, children: [


            CustomContainer(child: Column(spacing: Dimensions.paddingSizeDefault, children: [
              CustomTextField(title: "title".tr, controller: titleController,
                  maxLength: 150, hintText: "title".tr),

              CustomRichEditor(controller: descriptionHtmlController,
                  title: "description".tr, hintText: "description".tr, height: 300),
            ])),


            CustomContainer(child: Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault,  children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 8),
                  const CustomTitle(title: "status"),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomDropdown(width: Get.width, title: "select".tr,
                      items: courseController.courseStatusList,
                      selectedValue: courseController.selectedCourseStatus,
                      onChanged: (val){
                      courseController.setCourseStatus(val!);
                      if(val == "scheduled"){
                        courseController.showDateTimePicker(context: context);
                      }},
                    )),

                  if(courseController.selectedCourseStatus == "scheduled" &&
                      courseController.selectedDateTime != null)
                    Row(children: [
                      Text("${"scheduled_date_time_is".tr} : ",
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                      Text(courseController.formatedSelectedDateTime??"",
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    ]),
                ],)),

                Expanded(child: CustomTextField(
                    title: "fake_enrolled_student".tr,
                    controller: fakeStudentEnrollmentController,
                    inputFormatters: [AppConstants.numberFormat],
                    hintText: "enter_number".tr)),
                 ]),

              Row(spacing: Dimensions.paddingSizeDefault, children: [
                Expanded(child: CustomTextField(
                    inputFormatters: [AppConstants.numberFormat],
                    title: "total_notes".tr,
                    controller: noteCountController,
                    hintText: "note_count".tr)),

                Expanded(child: CustomTextField(
                    title: "total_exams".tr,
                    inputFormatters: [AppConstants.numberFormat],
                    controller: examCountController,
                    hintText: "exam_count".tr)),

                Expanded(child: CustomTextField(
                    inputFormatters: [AppConstants.numberFormat],
                    title: "total_classes".tr,
                    controller: classCountController,
                    hintText: "class_count".tr))
                 ]),
               ])),

            CustomContainer(child: Column(children: [
              CourseImageWidget(courseImage: widget.courseItem?.image),
              const IntroVideoWidget(),
            ])),

            const CourseCategorySection(),
            const CourseFaqSection(),

            CustomContainer(
              child: Column(spacing: Dimensions.paddingSizeDefault,
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                const CustomTitle(title: "payment_type"),
                Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdown(width: Get.width, title: "select".tr,
                    items: courseController.paymentTypeList,
                    selectedValue: courseController.selectedPaymentType,
                    onChanged: (val){
                    courseController.setPaymentType(val!);
                    })),

                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: CustomTextField(title: "invoice_title".tr,
                    controller: invoiceTitleController,
                    maxLength: 150,
                    hintText: "invoice_title".tr)),


                  if(courseController.selectedPaymentType != "free")
                    Expanded(child: CustomTextField(title: "regular_price".tr,
                      controller: priceController,
                      hintText: "enter_price".tr,
                      maxLength: 8,
                      inputFormatters: [AppConstants.numberFormat],
                      inputType: TextInputType.number,)),
                ]),


                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  if(courseController.selectedPaymentType != "free")
                    Expanded(child: CustomTextField(title: "offer_price".tr,
                      controller: offerPriceController,
                      inputFormatters: [AppConstants.numberFormat],
                      hintText: "enter_offer_price".tr,
                      maxLength: 8,
                      inputType: TextInputType.number)),


                  if(courseController.selectedPaymentType == "recurring_payment")
                    Expanded(child: CustomTextField(title: "repeat_count".tr,
                      controller: repeatCountController,
                      inputType: TextInputType.number,
                      inputFormatters: [AppConstants.numberFormat],
                      hintText: "enter_count".tr)),
                ]),


                if(courseController.selectedPaymentType == "recurring_payment")
                  Row(spacing: Dimensions.paddingSizeDefault, children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Dimensions.paddingSizeSmall, children: [
                        const SizedBox(height: 2),
                        const CustomTitle(title: "duration"),
                        CustomDropdown(width: Get.width, title: "select".tr,
                          items: courseController.paymentDurationList,
                          selectedValue: courseController.selectedPaymentDuration,
                          onChanged: (val){
                          courseController.setPaymentDuration(val!);
                          }),
                      ])),


                    Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Expanded(child: CustomTextField(title: "total_cycle".tr,
                        controller: totalCycleController,
                        isEnabled: !courseController.infinityCycle,
                        inputFormatters: [AppConstants.numberFormat],
                        hintText: "enter_cycle".tr,)),


                      SizedBox(width: 100,
                        child: Padding(padding: const EdgeInsets.only(bottom: 2.0),
                          child: CustomContainer(verticalPadding: 0,horizontalPadding: 5,
                              borderRadius: 3, width: 90,child: Row(children: [
                                Checkbox(value: courseController.infinityCycle, onChanged: (val){
                                  courseController.toggleInfinityCycle();
                                  totalCycleController.clear();
                                }),

                                Text("infinity".tr, style: textRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall))
                              ]))),
                      )
                    ])),
                  ]),


                Row(children: [
                  Checkbox(value: courseController.autoGeneratingInvoice,
                    onChanged: (val){
                  courseController.toggleAutoGeneratingInvoice(val!);
                }),

                  Text("i_want_auto_generate_invoice".tr,
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))])

              ]),
            ),


            courseController.isLoading? const Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):


            Align(alignment: Alignment.centerRight,
              child: Padding(padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeDefault),
                  child: SizedBox(width: 160,
                    child: CustomButton(onTap: () async {

                      int? courseCategoryId = Get.find<CourseCategoryController>().selectedCourseCategoryItem?.id;
                      String title = titleController.text.trim();
                      String slug = titleController.text.trim().replaceAll(" ", "");
                      String? description = await descriptionHtmlController.getText();
                      String? videoType = courseController.selectedVideoType;
                      String? videoUrl = courseController.videoUrlController.text.trim();
                      String? status = courseController.selectedCourseStatus;
                      String? publishedDate = courseController.formatedSelectedDateTime;
                      String? type = courseController.selectedCourserType;
                      String? paymentType = courseController.selectedPaymentType;
                      String invoiceTitle = invoiceTitleController.text.trim();
                      String price = priceController.text.trim();
                      String offerPrice = offerPriceController.text.trim();
                      String repeatCount = repeatCountController.text.trim();
                      String totalCycle = totalCycleController.text.trim();
                      int? isInfiniteCycle = courseController.infinityCycle? 1 : 0;
                      int? isAutoGenerateInvoice = courseController.autoGeneratingInvoice? 1 : 0;
                      String? fakeEnrolledStudent = fakeStudentEnrollmentController.text.trim();
                      String? totalClass = classCountController.text.trim();
                      String? noteCount = noteCountController.text.trim();
                      String? examCount = examCountController.text.trim();
                      List<FaqItem> faqs = [];

                      for(int i = 0; i < courseController.faqItemList.length; i++){
                        faqs.add(FaqItem(
                            question: courseController.faqItemList[i].questionController.text.trim(),
                            answer: courseController.faqItemList[i].answerController.text.trim()
                        ));
                      }

                      String? paymentDuration = courseController.selectedPaymentDuration;

                      if(title.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }

                      else if(courseCategoryId == null){
                        showCustomSnackBar("select_course_category".tr);
                      }

                      else if(courseController.selectedPaymentType != "free" && price.isEmpty){
                        showCustomSnackBar("price_is_empty".tr);
                      }

                      else{
                        CourseBody body = CourseBody(
                            courseCategoryId: courseCategoryId.toString(),
                            title: title,
                            slug: slug,
                            status: status,
                            publishDate: publishedDate,
                            type: type,
                            paymentType: paymentType,
                            invoiceTitle: invoiceTitle,
                            regularPrice: price,
                            offerPrice: offerPrice,
                            repeatCount: repeatCount,
                            totalCycles: totalCycle,
                            isInfinity: isInfiniteCycle.toString(),
                            isAutoGenerateInvoice: isAutoGenerateInvoice.toString(),
                            description: description,
                            faqs: jsonEncode(faqs),
                            paymentDuration: paymentDuration,
                            fakeEnrolledStudent: fakeEnrolledStudent,
                            totalClasses: totalClass,
                            totalNotes: noteCount,
                            totalExams: examCount,
                            videoType: videoType,
                            videoUrl: videoUrl,
                            sMethod: widget.courseItem != null? "PUT":"POST");

                        if(update){
                          courseController.editCourse(body, widget.courseItem!.id!);
                        }else{
                          courseController.createCourse(body);
                        }
                      }
                      }, text: update? "update".tr : "save_and_continue".tr,
                        fontWeight: FontWeight.w400,fontSize: Dimensions.fontSizeDefault),
                     )))
              ],),
            ],
          );
        }
    );
  }
}
