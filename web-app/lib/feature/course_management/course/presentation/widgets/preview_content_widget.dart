import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class PreviewCourseContentWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  const PreviewCourseContentWidget({super.key, required this.courseDetailsModel});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(builder: (courseController) {
        return Center(child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeOver, bottom: Dimensions.paddingSizeLarge),
                  child: Text("preview_content".tr, style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).primaryColor))),
                ListView.builder(
                  itemCount: courseDetailsModel.data?.courseChapters?.length??0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return ContentItemWidget(item: courseDetailsModel.data?.courseChapters?[index]);
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ExpansionTile(
        title: Text(widget.item?.chapterTitle??'', style: textBold.copyWith(color: isExpanded ? Colors.white : Theme.of(context).primaryColor, fontSize: Dimensions.paddingSizeDefault)),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        collapsedBackgroundColor: Theme.of(context).cardColor,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.grey.shade300)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color:  isExpanded ? Colors.white : Colors.grey.shade600),
        children: [
          Container( width: Dimensions.webMaxWidth,
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: Padding(padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.item?.contents?.length??0,
                  itemBuilder: (context, index){
                  Contents? lesson = widget.item!.contents?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Column(spacing: Dimensions.paddingSizeSmall,
                    children: [
                      Row(spacing: Dimensions.paddingSizeSmall, children: [
                          CustomImage(image: lesson?.type == "video"? Images.video : Images.quiz,
                              width: 20, height: 20,localAsset: true),
                          Expanded(child: Text(lesson?.title??'', style: textRegular.copyWith())),
                        Icon(Icons.lock_open, size: 15, color: Colors.grey.shade600),
                        ],
                      ),
                      if(index != widget.item!.contents!.length - 1)
                      const CustomDivider()
                    ],
                  ),
                );
              }))),
        ],
      ),
    );
  }
}


