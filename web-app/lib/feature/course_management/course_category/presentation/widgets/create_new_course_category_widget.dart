import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/course_management/course_category/domain/model/course_category_model.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/select_course_category_image_widget.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/select_course_category_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CreateNewCourseCategoryWidget extends StatefulWidget {
  final CourseCategoryItem? courseCategoryItem;
  const CreateNewCourseCategoryWidget({super.key, this.courseCategoryItem});

  @override
  State<CreateNewCourseCategoryWidget> createState() => _CreateNewCourseCategoryWidgetState();
}

class _CreateNewCourseCategoryWidgetState extends State<CreateNewCourseCategoryWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool update = false;
  @override
  void initState() {
    if(widget.courseCategoryItem != null){
      update = true;
      nameController.text = widget.courseCategoryItem?.name??'';
      slugController.text = widget.courseCategoryItem?.slug??'';
      descriptionController.text = widget.courseCategoryItem?.description??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseCategoryController>(
        builder: (courseCategoryController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomTextField(title: "name".tr,
                controller: nameController,
                onChanged: (val){
                  setState(() {
                    slugController.text = val;
                  });
                },
                hintText: "enter_name".tr,),

              courseCategoryController.slugEdit?
              Row(crossAxisAlignment: CrossAxisAlignment.end,
                spacing: Dimensions.paddingSizeSmall, children: [
                  Expanded(
                    child: CustomTextField(title: "slug".tr,
                      controller: slugController,
                      hintText: "/slug".tr,),
                  ),

                  InkWell(onTap: ()=> courseCategoryController.setSlugEdit(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                        child: Icon(Icons.check, size: Dimensions.iconSizeSmall, color: Theme.of(context).primaryColor, ),
                      ))
                ],
              ):
              (slugController.text.isNotEmpty)?
              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                child: Row(children: [
                  Expanded(child: Text("${"course_url".tr}: ${AppConstants.baseUrl}/course/${slugController.text.trim().replaceAll(" ", "-")} ", style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall),)),
                  InkWell(onTap: ()=> courseCategoryController.setSlugEdit(),
                      child: Icon(Icons.edit, size: Dimensions.iconSizeSmall, color: Theme.of(context).primaryColor, ))
                ],
                ),
              ):const SizedBox(),

              const SelectCourseCategoryWidget(title: "", hint: "parents"),

              CustomTextField(title: "description".tr,
                controller: descriptionController,
                maxLines: 5,
                minLines: 3,
                inputType: TextInputType.multiline,
                inputAction: TextInputAction.newline,
                hintText: "description".tr,),

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                  const SelectCourseCategoryImageWidget(),
                  Expanded(child: InkWell(onTap: ()=> courseCategoryController.pickImage(),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(5),
                      dashPattern: const [5  ,5],
                      strokeWidth: 0.25,
                      padding: const EdgeInsets.all(6),
                      child: Center(child: Padding(
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

                ]),
              ),




              courseCategoryController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    String description = descriptionController.text.trim();
                    int? categoryId = courseCategoryController.selectedCourseCategoryItem?.id;
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }


                    else{
                      Get.back();
                      if(update){
                        courseCategoryController.editCourseCategory(name,description, categoryId?.toString(), widget.courseCategoryItem!.id!).then((val){
                          if(val.statusCode == 200){
                            nameController.clear();
                            descriptionController.clear();
                            slugController.clear();
                            courseCategoryController.selectedCourseCategoryItem = null;

                          }
                        });
                      }else{
                        courseCategoryController.createCourseCategory(name,description, categoryId?.toString()).then((val){
                        if(val.statusCode == 200){
                          nameController.clear();
                          descriptionController.clear();
                          slugController.clear();
                          courseCategoryController.selectedCourseCategoryItem = null;
                        }
                        });
                      }

                    }
                  }, text: update? "update".tr : "save".tr, width: 100, height: 35, fontWeight: FontWeight.w400))

            ]),
          );
        }
    );
  }
}
