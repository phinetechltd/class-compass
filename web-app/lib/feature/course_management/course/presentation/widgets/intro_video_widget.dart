import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/select_course_video_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class IntroVideoWidget extends StatelessWidget {
  const IntroVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Row(spacing: Dimensions.paddingSizeDefault,
          children: [
            SizedBox(width: 200, child: Column(spacing: Dimensions.paddingSizeSmall, children: [
              CustomTitle(title: "intro_video".tr),
              CustomDropdown(width: Get.width, title: "select".tr,
                items: courseController.videoTypeList,
                selectedValue: courseController.selectedVideoType,
                onChanged: (val){
                  courseController.setVideoType(val!);
                },
              ),
            ])),
            Expanded(
              child: courseController.selectedVideoType != "upload"?
              CustomTextField(controller: courseController.videoUrlController,
                  minLines: 1, maxLines: 5,
                  inputType: TextInputType.multiline,
                  inputAction: TextInputAction.newline,
                  title: courseController.selectedVideoType?.tr?? "url".tr,
                  hintText: "enter_video_url".tr):
              InkWell(onTap: ()=> courseController.pickVideo(),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                    child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                      const SelectCourseVideoWidget(),
                      Expanded(child: DottedBorder(borderType: BorderType.RRect,
                        radius: const Radius.circular(5), dashPattern: const [5  ,5], strokeWidth: 0.25,
                        padding: const EdgeInsets.all(6),
                        child: Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(mainAxisSize: MainAxisSize.min, children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(text: "click_to_upload".tr, style: textBold.copyWith(color: systemPrimaryColor())),
                              ])),
                              Text("video_file_info".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall))
                            ]))),
                      ))
                    ])),
              ),
            ),
          ],
        );
      }
    );
  }
}
