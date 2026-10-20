import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/side_sheet_widget.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/feature/zoom_class/presentation/widgets/create_new_zoom_class_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseZoomWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  const CourseZoomWidget({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row( crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: InkWell(onTap: (){
              courseController.toggleShowWholePage();
            },
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [const Icon(Icons.menu),
                Flexible(child: Text(courseDetailsModel.data?.courseTitle??'', style: textRegular.copyWith())),
                CustomContainer(color: Theme.of(context).secondaryHeaderColor,
                  onTap: (){
                    showModalSideSheet(context,
                        barrierDismissible: true,
                        addBackIconButton: false,
                        addActions: false,
                        addDivider: false,
                        body: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                            child: CreateNewZoomClassWidget(courseId: courseDetailsModel.data?.courseId,)),
                        header: "zoom_class".tr);
                  },
                  verticalPadding: 5,borderRadius: 5,child: Text("add_new_live_class".tr, style: textRegular.copyWith(color: Colors.white),),)]),
            )),

            InkWell(onTap: (){
              courseController.toggleAllExpansion();
            },
                child: Text(courseController.areAllExpanded ? "collapse_all".tr : "expand_all".tr,
                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor, decoration: TextDecoration.underline))),
          ]),
        );
      }
    );
  }
}
