import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/add_new_resource_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class CourseFaqSection extends StatefulWidget {
  const CourseFaqSection({super.key});

  @override
  State<CourseFaqSection> createState() => _CourseFaqSectionState();
}

class _CourseFaqSectionState extends State<CourseFaqSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return CustomContainer(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(title: "faq".tr),
              ListView.builder(
                  itemCount: courseController.faqItemList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index){
                    return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                      child: Stack(
                        children: [
                          CustomContainer(borderRadius: 5, showShadow: false,
                            border: Border.all(width: .25, color: Theme.of(context).hintColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(spacing: Dimensions.paddingSizeSmall, children: [
                                CustomTextField(hintText: "enter_question".tr,
                                    controller: courseController.faqItemList[index].questionController),
                                CustomTextField(hintText: "enter_answer".tr,
                                    controller: courseController.faqItemList[index].answerController),
                              ]),
                            ),
                          ),
                          Positioned(top: 0,right: 0,
                            child: IconButton(onPressed: (){
                              courseController.removeFaqItem(index);
                            }, icon: const Icon(Icons.cancel)),
                          )
                        ],
                      ),
                    );
                  }),
              AddNewResourceWidget(width: 150, title: "add_another_faq".tr,onTap: (){
                courseController.addFaqItem();
              }),
            ],
          ),
        );
      }
    );
  }
}
