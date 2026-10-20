import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/title_row.dart';
import 'package:class_compass/feature/parent_module/parent_subject/controller/parent_subject_controller.dart';
import 'package:class_compass/feature/parent_module/parent_subject/domain/model/children_subject_model.dart';
import 'package:class_compass/feature/parent_module/parent_subject/presentation/widgets/parent_subject_item_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class ParentSubjectListWidget extends StatelessWidget {
  final bool isHome;
   const ParentSubjectListWidget({super.key,  this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentSubjectController>(
      initState: (val){
        if(Get.find<ParentSubjectController>().childrenSubjectsModel == null){
          Get.find<ParentSubjectController>().getChildrenSubjects();
        }
      },
      builder: (subjectController) {
        ChildrenSubjectsModel? childrenSubjectsModel = subjectController.childrenSubjectsModel;
        var subjects = childrenSubjectsModel?.data;
        return (childrenSubjectsModel != null && subjects != null && subjects.isNotEmpty)?
        Column(spacing: Dimensions.paddingSizeSmall, children: [
          if(isHome)
            TitleRowWidget(title: "subject_progress".tr, onTap: (){
              //Get.toNamed(RouteHelper.getSubjectRoute());
            }, padding: 0, ),
            CustomContainer(showShadow: false,borderColor: Theme.of(context).hintColor.withValues(alpha: .25),
              horizontalPadding: Dimensions.paddingSizeDefault, verticalPadding: Dimensions.paddingSizeDefault,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: (isHome && subjects.length>3)? 3 : subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return ParentSubjectItemWidget(subject: subject);
                },
              ),
            ),
          ],
        ):const SizedBox();
      }
    );
  }
}