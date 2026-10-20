import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/add_new_resource_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/select_course_category_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class CourseCategorySection extends StatefulWidget {
  const CourseCategorySection({super.key});

  @override
  State<CourseCategorySection> createState() => _CourseCategorySectionState();
}

class _CourseCategorySectionState extends State<CourseCategorySection> {
  TextEditingController courseCategoryControllerController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(builder: (courseController) {
        return CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SelectCourseCategoryWidget(),
              AddNewResourceWidget(title: "add_category".tr, onTap: (){
                courseController.setAddNewCategoryEnabled(true);
              }),

              if(courseController.addNewCategoryEnabled)
                GetBuilder<CourseCategoryController>(builder: (courseCategoryController) {
                      return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Expanded(child: Column(
                            children: [
                              CustomTextField(title: "category_name".tr,
                                  controller: courseCategoryControllerController,
                                  hintText: "category_name".tr),
                              const SizedBox(height: 8,)
                            ],
                          )),
                          Expanded(child: SelectCourseCategoryWidget(title: "select_parent".tr)),

                        ]),
                        SizedBox(width: 220,
                          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                            Expanded(child: CustomButton(height: 30,fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,
                                borderColor: Theme.of(context).hintColor,
                                showBorderOnly: true, textColor: Theme.of(context).textTheme.bodyLarge!.color!,
                                text: "cancel".tr, onTap: (){
                                  courseController.setAddNewCategoryEnabled(false);
                                  courseCategoryControllerController.clear();
                                })),
                            Expanded(child: CustomButton(text: "save".tr, onTap: (){
                              if(courseCategoryControllerController.text.isEmpty){
                                showCustomSnackBar("category_name_is_empty".tr);
                              }else{
                                courseCategoryController.createCourseCategory(courseCategoryControllerController.text.trim(), "", courseCategoryController.selectedCourseCategoryItem?.id?.toString());
                                courseController.setAddNewCategoryEnabled(false);
                                courseCategoryControllerController.clear();
                              }
                            }, height: 32,fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,)),
                          ]),
                        ),
                      ]);
                    }
                )
            ],
          ),
        );
      }
    );
  }
}
