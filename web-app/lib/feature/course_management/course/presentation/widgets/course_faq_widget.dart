import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/cms_management/faq/domain/model/faq_model.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';
import 'package:class_compass/feature/course_management/course/logic/course_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseFaqWidget extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;
  const CourseFaqWidget({super.key, required this.courseDetailsModel});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      builder: (courseController) {
        return Center(
          child: SizedBox(width: Dimensions.webMaxWidth,
            child: Column(children: [
                Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeLarge),
                  child: Text("Frequently Asked Questions", style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).primaryColor))),
                ListView.builder(
                  itemCount: 1,//course?.courseFaqs?.length??0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return CourseFaqItemWidget(item: FaqItem());
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


class CourseFaqItemWidget extends StatefulWidget {
  final FaqItem? item;
  const CourseFaqItemWidget({super.key, required this.item});

  @override
  CourseFaqItemWidgetState createState() => CourseFaqItemWidgetState();
}

class CourseFaqItemWidgetState extends State<CourseFaqItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ExpansionTile(
        title: Text(widget.item?.question??'', style: textSemiBold.copyWith(color: isExpanded ? Colors.white : Colors.black)),
        onExpansionChanged: (value) {
          setState(() {
            isExpanded = value;
          });
        },

        backgroundColor: Theme.of(context).primaryColor,
        collapsedBackgroundColor: Theme.of(context).cardColor,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.grey.shade300)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        tilePadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium),
        trailing: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color:  isExpanded ? Colors.white : Colors.grey.shade600),
        children: [
          Container(decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
            border: Border.all(color: Theme.of(context).primaryColor),
          ), width: Dimensions.webMaxWidth,
              child: Padding(padding: const EdgeInsets.all(16.0),
                  child: Text(widget.item?.answer??'', style: textRegular.copyWith()))),
        ],
      ),
    );
  }
}