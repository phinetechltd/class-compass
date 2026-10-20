import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/course_management/course/domain/model/resource_type_model.dart';
import 'package:class_compass/feature/course_management/lesson/logic/lesson_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseActivityOrResourceTypeDialog extends StatelessWidget {
  final String title;
  const CourseActivityOrResourceTypeDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LessonController>(
      builder: (lessonController) {
        return CustomContainer(width: 400,child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("add_new_lesson".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
                    InkWell(onTap: ()=> Get.back(),
                        child: Icon(Icons.close_rounded, color: Theme.of(context).hintColor, size: 20,))
                  ],
                )),
            Divider(thickness: .125, color: Theme.of(context).textTheme.displayLarge?.color),

            Padding(padding: const EdgeInsets.all(8.0),
              child: CustomContainer(borderRadius: 5, showShadow: false,border: Border.all(width: .25, color: Theme.of(context).secondaryHeaderColor),
                  verticalPadding: 7, color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .15),
                  child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text( "select_lesson_type".tr, style: textSemiBold)),

            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: lessonController.resourceTypeList.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 5),
                  itemBuilder: (context, index){
                return ResourceTypeCardWidget(resourceTypeModel: lessonController.resourceTypeList[index],index: index);
                  }),
            ),
            Padding(padding: const EdgeInsets.all(8.0),
              child: CustomButton(onTap: (){
                Get.back();
                Get.toNamed(RouteHelper.getLessonRoute());
              }, width: 90, height: 40, fontWeight: FontWeight.w400,
                  text: "next".tr, iconPosition: IconPosition.right,
                  icon: const Icon(Icons.keyboard_arrow_right, color: Colors.white,size: 18)),
            )
          ],
        ),);
      }
    );
  }
}
class ResourceTypeCardWidget extends StatelessWidget {
  final ResourceTypeModel? resourceTypeModel;
  final int index;
  const ResourceTypeCardWidget({super.key, this.resourceTypeModel, required this.index});

  @override
  Widget build(BuildContext context) {
    bool selected = resourceTypeModel?.isSelected == true;
    return CustomContainer(showShadow: false, border: Border.all(width: .25, color: Theme.of(context).hintColor),
        borderRadius: 5,
        onTap: (){
      Get.find<LessonController>().toggleResource(index);
    },
        child: Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(child: Text(resourceTypeModel?.title??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
          Icon(selected? Icons.radio_button_checked : Icons.radio_button_unchecked, size: 16,
            color: selected? Theme.of(context).secondaryHeaderColor : Theme.of(context).hintColor,)
          ],
        ));
  }
}

