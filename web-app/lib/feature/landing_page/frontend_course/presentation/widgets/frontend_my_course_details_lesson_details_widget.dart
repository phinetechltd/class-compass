
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FrontendMyCourseDetailsLessonDetailsWidget extends StatelessWidget {
  const FrontendMyCourseDetailsLessonDetailsWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(
      builder: (courseController) {

        return courseController.lessonDescriptionModel !=null?
        Padding(padding: const EdgeInsets.only(top : Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeExtraSmall,crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(spacing: Dimensions.paddingSizeExtraLarge, children: [
              InkWell(onTap: ()=> courseController.setSummeryTypeIndex(0),
                  child: Padding(padding: const EdgeInsets.all( 8.0),
                    child: Text("about_lesson".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)))),

              if(courseController.lessonDescriptionModel?.data?.attachments != null && courseController.lessonDescriptionModel?.data?.attachments!.isNotEmpty == true)
              InkWell(onTap: ()=> courseController.setSummeryTypeIndex(1),
                  child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Text("exercise_file".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)))),
            ]),

            Stack(children: [
              const CustomDivider(),
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 3),
                child: Row(spacing: 50, children: [

                  Container(width: 95, height: 2,color: courseController.summeryTypeIndex == 0? Theme.of(context).primaryColor : Colors.transparent),
                  Container(width: 90, height: 2,color: courseController.summeryTypeIndex == 1? Theme.of(context).primaryColor : Colors.transparent),
                ]),
              ),
            ],
            ),

            if(courseController.summeryTypeIndex == 0 && courseController.lessonDescriptionModel?.data?.description != null)
            Padding(padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
              child:  HtmlViewer(htmlText: courseController.lessonDescriptionModel?.data?.description ?? "")),

            if(courseController.summeryTypeIndex == 1 && courseController.lessonDescriptionModel?.data?.attachments != null && courseController.lessonDescriptionModel?.data?.attachments!.isNotEmpty == true)
              GridView.builder(
                shrinkWrap: true,
                itemCount: courseController.lessonDescriptionModel?.data?.attachments?.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (_, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomContainer(onTap: (){
                    AppConstants.openUrl("${courseController.lessonDescriptionModel?.data?.attachments?[index].url}");
                  }, borderRadius: 5,
                      child: Row(children: [
                          Expanded(child: Text("${courseController.lessonDescriptionModel?.data?.attachments?[index].url}", overflow: TextOverflow.ellipsis, maxLines: 1)),
                          Icon(Icons.file_download, size: 16, color: Theme.of(context).hintColor)
                        ],
                      )),
                );
              }, gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400, childAspectRatio: 6),)
          ],
          ),
        ):Padding(padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height/2),
          child: const Center(child: CircularProgressIndicator()),
        );
      }
    );
  }
}
