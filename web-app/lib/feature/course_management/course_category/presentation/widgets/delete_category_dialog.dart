import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course_category/logic/course_category_controller.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/select_course_category_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class CategoryDeleteDialog extends StatelessWidget {
  const CategoryDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseCategoryController>(
        builder: (courseCategoryController) {
          return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),child: SizedBox(width: 600,
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, 0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("transfer_all_course".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                          IconButton(onPressed: (){
                            Get.back();
                          }, icon: Icon(Icons.close_rounded, color: Theme.of(context).hintColor, size: 20,)),
                        ],
                      )),
                  Divider(thickness: .125, color: Theme.of(context).textTheme.displayLarge?.color),

                  Padding(padding: const EdgeInsets.only(top: 8.0, bottom: Dimensions.paddingSizeDefault),
                    child: CustomContainer(borderRadius: 5,verticalPadding: Dimensions.paddingSizeMedium,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeDefault, children: [
                        const SelectCourseCategoryWidget(),


                        CustomContainer(showShadow: false, verticalPadding: Dimensions.paddingSizeLarge,color: const Color(0xFFF4EDBB),
                            child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                          const CustomImage(image: Images.warningIconPng,width: 50, localAsset: true),
                          Expanded(child: Text.rich(TextSpan(children: [
                            TextSpan(text: "After select any category this file will Auto Delete".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                            TextSpan(text: " Please choose ".tr, style: textRegular.copyWith()),
                            TextSpan(text: "Transfer button".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor, decoration: TextDecoration.underline)),
                            TextSpan(text: " to continue the action.".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                          ])))
                        ])),


                        Row(spacing: Dimensions.paddingSizeSmall, children: [
                            Expanded(child: CustomButton(onTap: ()=> Get.back(),
                                text: "cancel".tr, buttonColor: Theme.of(context).highlightColor,
                                  borderColor: Theme.of(context).hintColor, borderWidth: .125, fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,
                                  textColor: Theme.of(context).textTheme.displayLarge!.color!)),
                            Expanded(child: CustomButton(onTap: ()=> Get.back(),
                              text: "transfer".tr, fontWeight: FontWeight.w400, fontSize: Dimensions.fontSizeDefault,)),
                          ],
                        )
                      ]),
                    ),
                  ),
                ]),
              ),
            ),
          ));
        }
    );
  }
}

