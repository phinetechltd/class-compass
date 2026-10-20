import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/feature/cms_management/cms_settings/controller/frontend_settings_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class PreviewCourseContentWidget extends StatelessWidget {
  final MyCourseDetailsModel courseDetailsModel;
  const PreviewCourseContentWidget({super.key, required this.courseDetailsModel});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<FrontendCourseController>(builder: (courseController) {
        Courses? course = courseDetailsModel.data;
        return Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeOver, bottom: Dimensions.paddingSizeLarge),
                  child: Text("preview_content".tr,
                      style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge))),
                ListView.builder(
                  itemCount: course?.courseChapters?.length??0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return ContentItemWidget(item: course?.courseChapters?[index]);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class ContentItemWidget extends StatefulWidget {
  final CourseChapters? item;
  const ContentItemWidget({super.key, required this.item});

  @override
  ContentItemWidgetState createState() => ContentItemWidgetState();
}

class ContentItemWidgetState extends State<ContentItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(showShadow: false,verticalPadding: 0,horizontalPadding: 0,
      border: Border.all(width: .0125, color: Theme.of(context).hintColor),
      child: ExpansionTile(
        title: Text(widget.item?.chapterTitle??'',
            style: textBold.copyWith(fontSize: Dimensions.paddingSizeDefault)),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        backgroundColor: Get.find<FrontendSettingsController>().primaryColor,
        collapsedBackgroundColor: Theme.of(context).cardColor,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.grey.shade300, width: .25)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color:  isExpanded ? Theme.of(context).hintColor : Colors.grey.shade600),
        children: [
          Container( width: Dimensions.webMaxWidth,
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: Get.find<FrontendSettingsController>().primaryColor)),
            child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.item?.contents?.length??0,
                  itemBuilder: (context, index){
                  Contents? lesson = widget.item!.contents?[index];
                return Column(spacing: Dimensions.paddingSizeSmall, children: [
                    Row(spacing: Dimensions.paddingSizeSmall, children: [
                        CustomImage(image: lesson?.type == "video"?
                        Images.video : Images.quiz, width: 20, height: 20,localAsset: true,
                          localAssetColor: Theme.of(context).hintColor,),
                        Expanded(child: HtmlViewer(htmlText: lesson?.title??'')),
                      Text("6:15", style: textRegular.copyWith(color: Theme.of(context).hintColor,
                      fontSize: Dimensions.fontSizeSmall),),
                      ],
                    ),
                    if(index != widget.item!.contents!.length - 1)
                    const CustomDivider()
                  ],
                );
              }))),
        ],
      ),
    );
  }
}


