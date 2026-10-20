import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/course_management/chapter/domain/model/chapter_body.dart';
import 'package:class_compass/feature/course_management/chapter/logic/chapter_controller.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewTopicWidget extends StatefulWidget {
  final int courseId;
  final int? chapterId;
  final String? title;
  final String? description;
  const AddNewTopicWidget({super.key, required this.courseId, this.title, this.description, this.chapterId});

  @override
  State<AddNewTopicWidget> createState() => _AddNewTopicWidgetState();
}

class _AddNewTopicWidgetState extends State<AddNewTopicWidget> {
  TextEditingController topicController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.chapterId != null){
      topicController.text = widget.title??'';
      descriptionController.text = widget.description??'';
    }

  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Padding(padding: widget.chapterId != null? const EdgeInsets.all(Dimensions.paddingSizeExtraLarge) : const EdgeInsets.fromLTRB( 53, 15, 25, 30),
          child: CustomContainer(borderRadius: 5, showShadow: false,
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(width: .25, color: Theme.of(context).hintColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(spacing: Dimensions.paddingSizeSmall, crossAxisAlignment: CrossAxisAlignment.end,mainAxisSize: MainAxisSize.min, children: [
                CustomTextField(hintText: "topic".tr, fillColor: Theme.of(context).cardColor,
                    filled: true,
                    controller: topicController),
                CustomTextField(hintText: "description".tr,
                    minLines: 3, maxLines: 5,
                    inputType: TextInputType.multiline,
                    inputAction: TextInputAction.newline,
                    fillColor: Theme.of(context).cardColor,
                    filled: true,
                    controller: descriptionController),

                SizedBox(width: 220,
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: CustomButton(height: 30,fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,
                        borderColor: Theme.of(context).hintColor,
                        showBorderOnly: true, textColor: Theme.of(context).textTheme.bodyLarge!.color!,
                        text: "cancel".tr, onTap: (){
                      Get.back();
                          courseController.setAddTopicEnabled(false);
                          topicController.clear();
                          descriptionController.clear();
                        })),
                    Expanded(child: GetBuilder<ChapterController>(
                        builder: (chapterController) {
                          return chapterController.isLoading?
                          const Center(child: CircularProgressIndicator()) :
                          CustomButton(text: widget.chapterId != null? "update".tr : "save".tr, onTap: (){
                            String title = topicController.text.trim();
                            String description = descriptionController.text.trim();
                            if(title.isEmpty){
                              showCustomSnackBar("topic_is_empty".tr);
                            }else{
                              ChapterBody body = ChapterBody(
                                courseId: widget.courseId.toString(),
                                title: title,
                                description: description,
                                sMethod: widget.chapterId != null? "PUT":"POST"
                              );
                              if(widget.chapterId != null){
                                chapterController.editChapter(body, widget.chapterId!, widget.courseId.toString()).then((val){
                                  if(val.statusCode == 200){
                                    courseController.setAddTopicEnabled(false);
                                    topicController.clear();
                                    descriptionController.clear();
                                  }
                                });
                              }else {
                                chapterController.createChapter(body, widget.courseId.toString()).then((val){
                                if(val.statusCode == 200){
                                  courseController.setAddTopicEnabled(false);
                                  topicController.clear();
                                  descriptionController.clear();
                                }
                              });
                              }


                            }
                          }, height: 32,fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,);
                        }
                    )),
                  ]),
                ),
              ]),
            ),
          ),
        );
      }
    );
  }
}
