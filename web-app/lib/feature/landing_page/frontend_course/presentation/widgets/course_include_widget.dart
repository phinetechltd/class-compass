import 'package:flutter/material.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/course_details_information_details_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:get/get.dart';

class CourseIncludeWidget extends StatelessWidget {
  const CourseIncludeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("${'this_course_includes'.tr} : ",
            style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),


        const Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: IconRowWidget(icon: Icons.person,
              text: "1 Role Play")),
          Expanded(child: IconRowWidget(icon: Icons.sim_card_download_outlined,
              text: "143 downloadable resources")),
        ]),
        const Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: IconRowWidget(icon: Icons.video_collection_outlined,
              text: "29.5 hours on-demand video")),
          Expanded(child: IconRowWidget(icon: Icons.phone_iphone_sharp,
              text: "Access on mobile and TV")),
        ]),
        const Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: IconRowWidget(icon: Icons.code,
              text: "107 coding exercises")),
          Expanded(child: IconRowWidget(icon: Icons.closed_caption,
              text: "Closed captions")),
        ]),
        const Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: IconRowWidget(icon: Icons.article_outlined,
              text: "22 articles")),
          Expanded(child: IconRowWidget(icon: Icons.wine_bar_outlined,
              text: "Certificate of completion")),
        ]),

      ],);
  }
}
