

import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_rich_text_editor_widget/custom_rich_editor.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/select_course_image_widget.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/select_course_video_widget.dart';
import 'package:class_compass/feature/course_management/lesson/domain/model/lesson_body.dart';
import 'package:class_compass/feature/course_management/lesson/logic/lesson_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CreateNewLessonWidget extends StatefulWidget {
  const CreateNewLessonWidget({super.key});

  @override
  State<CreateNewLessonWidget> createState() => _CreateNewLessonWidgetState();
}

class _CreateNewLessonWidgetState extends State<CreateNewLessonWidget> {
  // TextEditingController nameController = TextEditingController();
  TextEditingController hourEditingController = TextEditingController();
  TextEditingController minEditingController = TextEditingController();
  TextEditingController secEditingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController videoTextEditingController = TextEditingController();
  final HtmlEditorController descriptionHtmlController = HtmlEditorController();
  final HtmlEditorController titleHtmlController = HtmlEditorController();




  bool update = false;
  @override
  void initState() {

    var selectedContent = Get.find<CourseController>().selectedContent;
    if(selectedContent!= null){
      update = true;
      log("HTML set in editor: $selectedContent.description");
      // nameController.text = selectedContent.title??'';
      String type = selectedContent.videoType??'text';
      Get.find<LessonController>().updateResourceTypeSelection(type, type);
      videoTextEditingController.text = selectedContent.videoUrl??'';
      hourEditingController.text = selectedContent.playbackHours?.toString() ??'0';
      minEditingController.text = selectedContent.playbackMinutes?.toString() ??'0';
      secEditingController.text = selectedContent.playbackSeconds?.toString() ??'0';
      passwordController.text = selectedContent.password??'';
      String passwordType = selectedContent.visibility ?? 'none';
      Get.find<LessonController>().changePasswordType(passwordType, notify: false);
      Get.find<LessonController>().changeSchedule(selectedContent.isScheduled == 1? true : false, notify: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 2000), () async {
          descriptionHtmlController.setText(Get.find<CourseController>().lessonDescriptionModel?.data?.description??'');
          titleHtmlController.setText(selectedContent.title ?? '');
        });
      });

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonController>(
        builder: (lessonController) {
          return GetBuilder<CourseController>(
            builder: (courseController) {

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(children: [
                    CustomRoutePathWidget(title: "course_management".tr, subWidget: Row(children: [
                      PathItemWidget(title: "lesson".tr,color: Theme.of(context).primaryColor, onTap: (){
                        Get.back();
                      }),
                    ])),
                    CustomContainer(showShadow: false,
                      child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeSmall, children: [

                        ResponsiveHelper.isDesktop(context)?
                        Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                          Expanded(child: Column(children: [

                            CustomRichEditor(controller: titleHtmlController, title: "title".tr, hintText: "title".tr,),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            CustomRichEditor(controller: descriptionHtmlController, title: "description".tr, hintText: "description".tr, height: 500),
                          ])),

                          SizedBox(width: 400,
                            child: Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              if(lessonController.selectedResourceType != "text")
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(spacing: Dimensions.paddingSizeDefault, children: [
                                  Expanded(child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        (lessonController.selectedResourceType == "image")?
                                        Row(spacing: Dimensions.paddingSizeDefault, children: [
                                          SelectCourseImageWidget(imageUrl: "${AppConstants.baseUrl}/storage/lessons/${courseController.selectedContent?.thumbnailImage}"),
                                          Expanded(
                                            child: InkWell(onTap: ()=> courseController.pickImage(),
                                              child: DottedBorder(
                                                borderType: BorderType.RRect,
                                                radius: const Radius.circular(5),
                                                dashPattern: const [5  ,5],
                                                strokeWidth: 0.25,
                                                padding: const EdgeInsets.all(6),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                    child: Column(mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text.rich(TextSpan(children: [
                                                            TextSpan(text: "click_to_upload".tr, style: textBold.copyWith(color: Theme.of(context).primaryColor)),
                                                            TextSpan(text: " ${"or_drag_and_drop".tr}", style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),

                                                          ])),
                                                          Text("file_info".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall))
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )

                                        ]):
                                        (lessonController.selectedResourceType == "upload" || lessonController.selectedResourceType == "document")?
                                        Row(spacing: Dimensions.paddingSizeDefault, children: [
                                          Expanded(
                                            child: InkWell(onTap: ()=> lessonController.selectedResourceType == "upload"? courseController.pickVideo() : lessonController.pickDocument(),
                                              child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(spacing: Dimensions.paddingSizeDefault, children: [
                                                        lessonController.selectedResourceType == "upload"?
                                                        const SelectCourseVideoWidget() : const SelectLessonDocWidget(),
                                                        Expanded(child: DottedBorder(borderType: BorderType.RRect,
                                                          radius: const Radius.circular(5), dashPattern: const [5  ,5], strokeWidth: 0.25,
                                                          padding: const EdgeInsets.all(6),
                                                          child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              child: Column(mainAxisSize: MainAxisSize.min, children: [
                                                                Text.rich(TextSpan(children: [
                                                                  TextSpan(text: "click_to_upload".tr, style: textBold.copyWith(color: Theme.of(context).primaryColor)),
                                                                ])),
                                                                Text("video_file_info".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall))
                                                              ]))),
                                                        ))
                                                      ]),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top : 8.0),
                                                        child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                                                          children: [
                                                            Icon(CupertinoIcons.paperclip, size: 16, color: Theme.of(context).hintColor),
                                                            Text(courseController.selectedContent?.documentFile??courseController.selectedContent?.uploadedVideoPath??'',
                                                                style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault)),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ]):
                                        CustomTextField(controller: videoTextEditingController,
                                            minLines: 3, maxLines: 5,
                                            inputType: TextInputType.multiline,
                                            inputAction: TextInputAction.newline,
                                            title: lessonController.selectedResourceType == "cipher"? "${lessonController.selectedResourceTitle} (Copy ID)" : "${lessonController.selectedResourceTitle}",
                                            hintText: "enter_video_url".tr),
                                      ],
                                    ),
                                  ),),
                                ]),


                                if(lessonController.selectedResourceType != "image" && lessonController.selectedResourceType != "document")
                                  CustomTitle(title: "video_play_back_time".tr),
                                if(lessonController.selectedResourceType != "image" && lessonController.selectedResourceType != "document")
                                  Row(spacing : Dimensions.paddingSizeSmall, children: [
                                    Expanded(child: CustomTextField(hintText: '0    hour', controller: hourEditingController, inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number,)),
                                    Expanded(child: CustomTextField(hintText: '0    min', controller: minEditingController, inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number)),
                                    Expanded(child: CustomTextField(hintText: '0    sec', controller: secEditingController , inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number)),
                                  ]),
                              ]),


                              CustomTitle(title: "exercise_files".tr),
                              CustomContainer(showShadow: false, border: Border.all(width: .5, color: Theme.of(context).hintColor), borderRadius: 5,
                                child: Column(children: [

                                  if(courseController.selectedContent != null && courseController.selectedContent?.attachments != null && courseController.selectedContent!.attachments!.isNotEmpty)
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: courseController.selectedContent?.attachments?.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index){
                                        return Padding(padding: const EdgeInsets.all(8.0),
                                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                                            const Icon(CupertinoIcons.paperclip, size: 16),
                                            Expanded(child: Text(courseController.selectedContent?.attachments?[index].url??'')),
                                            IconButton(icon: Icon(Icons.clear,color: Theme.of(context).colorScheme.error),
                                              onPressed: ()=> lessonController.removeExerciseFile(index),)
                                          ]),
                                        );
                                      }),

                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: lessonController.exerciseFiles.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index){
                                    return Padding(padding: const EdgeInsets.all(8.0),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                                        const Icon(CupertinoIcons.paperclip, size: 16),
                                        Expanded(child: Text(lessonController.exerciseFiles[index].file?.name??'')),
                                        IconButton(icon: Icon(Icons.clear,color: Theme.of(context).colorScheme.error),
                                          onPressed: ()=> lessonController.removeExerciseFile(index),)
                                      ]),
                                    );
                                  }),
                                  CustomContainer(onTap: ()=> lessonController.pickExerciseFile(),
                                      color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .12),
                                  borderRadius: 5, showShadow: false,border: Border.all(width: .2, color: Theme.of(context).primaryColor),
                                  child: Row(spacing: Dimensions.paddingSizeSmall, mainAxisAlignment : MainAxisAlignment.center, children: [
                                    Icon(CupertinoIcons.paperclip, color: Theme.of(context).secondaryHeaderColor, size: 20),
                                    Text("upload_attachment".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith(color: Theme.of(context).primaryColor))
                                  ]))
                                ]),
                              ),



                              CustomContainer(verticalPadding: 0,borderRadius: 5,horizontalPadding: 0,
                                child: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                        child: Text("schedule".tr))),
                                    Switch(inactiveTrackColor: Theme.of(context).hintColor, hoverColor: Theme.of(context).secondaryHeaderColor,
                                        value: lessonController.isSchedule, onChanged: (val){
                                          lessonController.changeSchedule(val);
                                          if(val){
                                            courseController.showDateTimePicker(context: context);
                                          }
                                        })
                                  ]),

                                    Padding(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
                                      child: Row(children: [
                                        Text("${"scheduled_date_time_is".tr} : ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                        Text(courseController.formatedSelectedDateTime??courseController.selectedContent?.scheduledAt??"", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                      ],
                                      ),
                                    ),
                                ],
                                ),
                              ),

                              SizedBox(height: 40,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: lessonController.passwordType.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_, index){
                                      return Padding(
                                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                        child: CustomContainer( borderRadius: 5, showShadow: false,border: Border.all(color: lessonController.selectedPasswordType == lessonController.passwordType[index]?
                                        Theme.of(context).primaryColor : Theme.of(context).hintColor, width: lessonController.selectedPasswordType == lessonController.passwordType[index] ? 1 : .25 ),
                                            child: RadioGroup(
                                                groupValue: lessonController.selectedPasswordType.toLowerCase(),
                                                onChanged: (val){
                                                  passwordController.clear();
                                                  lessonController.changePasswordType(val!);
                                                }, child: Text(lessonController.passwordType[index]), )),
                                      );
                                    }),
                              ),

                              if(lessonController.selectedPasswordType.toLowerCase() == "password")
                                CustomTitle(title: "set_password".tr),
                              if(lessonController.selectedPasswordType.toLowerCase() == "password")
                                CustomTextField(hintText: "enter_number".tr, inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number,
                                  controller: passwordController)


                            ]),
                          ),
                        ]):
                        Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                        Column(children: [

                          CustomRichEditor(controller: titleHtmlController, title: "title".tr, hintText: "title".tr,),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          CustomRichEditor(controller: descriptionHtmlController, title: "description".tr, hintText: "description".tr, height: 250),
                        ]),

                        Column(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          if(lessonController.selectedResourceType != "text")
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(spacing: Dimensions.paddingSizeDefault, children: [
                                Expanded(child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      (lessonController.selectedResourceType == "image")?
                                      Row(spacing: Dimensions.paddingSizeDefault, children: [
                                        SelectCourseImageWidget(imageUrl: "${AppConstants.baseUrl}/storage/lessons/${courseController.selectedContent?.thumbnailImage}"),
                                        Expanded(
                                          child: InkWell(onTap: ()=> courseController.pickImage(),
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(5),
                                              dashPattern: const [5  ,5],
                                              strokeWidth: 0.25,
                                              padding: const EdgeInsets.all(6),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Column(mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text.rich(TextSpan(children: [
                                                          TextSpan(text: "click_to_upload".tr, style: textBold.copyWith(color: Theme.of(context).primaryColor)),
                                                          TextSpan(text: " ${"or_drag_and_drop".tr}", style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),
                        
                                                        ])),
                                                        Text("file_info".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall))
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                        
                                      ]):
                                      (lessonController.selectedResourceType == "upload" || lessonController.selectedResourceType == "document")?
                                      Row(spacing: Dimensions.paddingSizeDefault, children: [
                                        Expanded(
                                          child: InkWell(onTap: ()=> lessonController.selectedResourceType == "upload"? courseController.pickVideo() : lessonController.pickDocument(),
                                            child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(spacing: Dimensions.paddingSizeDefault, children: [
                                                      lessonController.selectedResourceType == "upload"?
                                                      const SelectCourseVideoWidget() : const SelectLessonDocWidget(),
                                                      Expanded(child: DottedBorder(borderType: BorderType.RRect,
                                                        radius: const Radius.circular(5), dashPattern: const [5  ,5], strokeWidth: 0.25,
                                                        padding: const EdgeInsets.all(6),
                                                        child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                                                              Text.rich(TextSpan(children: [
                                                                TextSpan(text: "click_to_upload".tr, style: textBold.copyWith(color: Theme.of(context).primaryColor)),
                                                              ])),
                                                              Text("video_file_info".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall))
                                                            ]))),
                                                      ))
                                                    ]),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top : 8.0),
                                                      child: Row(spacing: Dimensions.paddingSizeExtraSmall,
                                                        children: [
                                                          Icon(CupertinoIcons.paperclip, size: 16, color: Theme.of(context).hintColor),
                                                          Text(courseController.selectedContent?.documentFile??courseController.selectedContent?.uploadedVideoPath??'',
                                                              style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault)),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ]):
                                      CustomTextField(controller: videoTextEditingController,
                                          minLines: 3, maxLines: 5,
                                          inputType: TextInputType.multiline,
                                          inputAction: TextInputAction.newline,
                                          title: lessonController.selectedResourceType == "cipher"? "${lessonController.selectedResourceTitle} (Copy ID)" : "${lessonController.selectedResourceTitle}",
                                          hintText: "enter_video_url".tr),
                                    ],
                                  ),
                                ),),
                              ]),
                        
                        
                              if(lessonController.selectedResourceType != "image" && lessonController.selectedResourceType != "document")
                                CustomTitle(title: "video_play_back_time".tr),
                              if(lessonController.selectedResourceType != "image" && lessonController.selectedResourceType != "document")
                                Row(spacing : Dimensions.paddingSizeSmall, children: [
                                  Expanded(child: CustomTextField(hintText: '0    hour', controller: hourEditingController, inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number,)),
                                  Expanded(child: CustomTextField(hintText: '0    min', controller: minEditingController, inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number)),
                                  Expanded(child: CustomTextField(hintText: '0    sec', controller: secEditingController , inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number)),
                                ]),
                            ]),
                        
                        
                          CustomTitle(title: "exercise_files".tr),
                          CustomContainer(showShadow: false, border: Border.all(width: .5, color: Theme.of(context).hintColor), borderRadius: 5,
                            child: Column(children: [
                        
                              if(courseController.selectedContent != null && courseController.selectedContent?.attachments != null && courseController.selectedContent!.attachments!.isNotEmpty)
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: courseController.selectedContent?.attachments?.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return Padding(padding: const EdgeInsets.all(8.0),
                                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                                          const Icon(CupertinoIcons.paperclip, size: 16),
                                          Expanded(child: Text(courseController.selectedContent?.attachments?[index].url??'')),
                                          IconButton(icon: Icon(Icons.clear,color: Theme.of(context).colorScheme.error),
                                            onPressed: ()=> lessonController.removeExerciseFile(index),)
                                        ]),
                                      );
                                    }),
                        
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: lessonController.exerciseFiles.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index){
                                    return Padding(padding: const EdgeInsets.all(8.0),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                                        const Icon(CupertinoIcons.paperclip, size: 16),
                                        Expanded(child: Text(lessonController.exerciseFiles[index].file?.name??'')),
                                        IconButton(icon: Icon(Icons.clear,color: Theme.of(context).colorScheme.error),
                                          onPressed: ()=> lessonController.removeExerciseFile(index),)
                                      ]),
                                    );
                                  }),
                              CustomContainer(onTap: ()=> lessonController.pickExerciseFile(),
                                  color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .12),
                                  borderRadius: 5, showShadow: false,border: Border.all(width: .2, color: Theme.of(context).primaryColor),
                                  child: Row(spacing: Dimensions.paddingSizeSmall, mainAxisAlignment : MainAxisAlignment.center, children: [
                                    Icon(CupertinoIcons.paperclip, color: Theme.of(context).secondaryHeaderColor, size: 20),
                                    Text("upload_attachment".tr, maxLines: 1, overflow: TextOverflow.ellipsis, style: textRegular.copyWith(color: Theme.of(context).primaryColor))
                                  ]))
                            ]),
                          ),
                        
                        
                        
                          CustomContainer(verticalPadding: 0,borderRadius: 5,horizontalPadding: 0,
                            child: Column(children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                    child: Text("schedule".tr))),
                                Switch(inactiveTrackColor: Theme.of(context).hintColor, hoverColor: Theme.of(context).secondaryHeaderColor,
                                    value: lessonController.isSchedule, onChanged: (val){
                                      lessonController.changeSchedule(val);
                                      if(val){
                                        courseController.showDateTimePicker(context: context);
                                      }
                                    })
                              ]),
                        
                              Padding(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
                                child: Row(children: [
                                  Text("${"scheduled_date_time_is".tr} : ", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                  Text(courseController.formatedSelectedDateTime??courseController.selectedContent?.scheduledAt??"", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                ],
                                ),
                              ),
                            ],
                            ),
                          ),
                        
                          SizedBox(height: 40,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: lessonController.passwordType.length,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                itemBuilder: (_, index){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                    child: CustomContainer( borderRadius: 5, showShadow: false,border: Border.all(color: lessonController.selectedPasswordType == lessonController.passwordType[index]?
                                    Theme.of(context).primaryColor : Theme.of(context).hintColor, width: lessonController.selectedPasswordType == lessonController.passwordType[index] ? 1 : .25 ),
                                        child: RadioGroup(
                                            groupValue: lessonController.selectedPasswordType.toLowerCase(),
                                            onChanged: (val){
                                              passwordController.clear();
                                              lessonController.changePasswordType(val!);
                                            }, child: Text(lessonController.passwordType[index]),)),
                                  );
                                }),
                          ),
                        
                          if(lessonController.selectedPasswordType.toLowerCase() == "password")
                            CustomTitle(title: "set_password".tr),
                          if(lessonController.selectedPasswordType.toLowerCase() == "password")
                            CustomTextField(hintText: "enter_number".tr, inputFormatters: [AppConstants.numberFormat], inputType: TextInputType.number,
                                controller: passwordController)
                        
                        
                        ]),
                      ]),

                        lessonController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Center(child: CircularProgressIndicator())):

                        Align(alignment: Alignment.centerRight,
                          child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                              child: CustomButton(width: 130, onTap: () async {
                                bool isValidUrl(String url) {
                                  final uri = Uri.tryParse(url);
                                  return uri != null &&
                                      (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https')) &&
                                      uri.host.isNotEmpty;
                                }



                                String? name = await titleHtmlController.getText();
                                int? courseId = courseController.selectedCourseId;
                                int? chapterId = courseController.selectedChapterId;
                                String hour = hourEditingController.text.trim();
                                String min = minEditingController.text.trim();
                                String sec = secEditingController.text.trim();
                                String password = passwordController.text.trim();
                                String videoType = lessonController.selectedResourceType??'none';
                                String videoUrl = videoTextEditingController.text.trim();
                                String isSchedule = lessonController.isSchedule? "1" : "0";
                                String? scheduleAt = courseController.formatedDateTimeForDatabase;
                                String visibility = lessonController.selectedPasswordType.toLowerCase();
                                String? description = await descriptionHtmlController.getText();




                                if(name.isEmpty){
                                  showCustomSnackBar("name_is_empty".tr);
                                }

                                else if(lessonController.selectedResourceType != "cipher" && videoUrl.isNotEmpty && !isValidUrl(videoUrl)){
                                  showCustomSnackBar("invalid_url".tr);
                                }
                                else if(lessonController.selectedPasswordType == "Password" && password.isEmpty){
                                  showCustomSnackBar("password_is_empty".tr);
                                }

                                else{
                                  LessonBody body = LessonBody(
                                    courseId: courseId.toString(),
                                    chapterId: chapterId.toString(),
                                    title: name,
                                    description: description,
                                    playbackHours: hour,
                                    playbackMinutes: min,
                                    playbackSeconds: sec,
                                    password: password,
                                    videoType: videoType,
                                    videoUrl: videoUrl,
                                    isScheduled: isSchedule,
                                    scheduledAt: scheduleAt,
                                    visibility: visibility,
                                    sMethod: courseController.selectedContent != null? "PUT" : "POST",

                                  );

                                  if(update){
                                    lessonController.editLesson(body, courseController.selectedContent!.typeId!, courseController.selectedCourseId.toString());
                                  }
                                  else{
                                    lessonController.createLesson(body);
                                  }

                                }
                              }, text: update? "update".tr : "save".tr)),
                        )
                      ],),
                    ),
                  ],
                ),
              );
            }
          );
        }
    );
  }
}
