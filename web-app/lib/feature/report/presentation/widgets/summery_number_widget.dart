import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/report/domain/model/dashboard_report_model.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class SummeryNumberWidget extends StatelessWidget {
  const SummeryNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        DashboardReportModel? reportModel = reportController.dashboardReportModel;
        return ResponsiveHelper.isDesktop(context)?
        Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_admin',
                color: systemSidebarColor(),
                count: reportModel?.data?.admins ?? 0)),
            Expanded(child: CountingItemWidget(title: 'total_students', color: Theme.of(context).colorScheme.tertiaryContainer, count: reportModel?.data?.students ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_teacher', color: Theme.of(context).colorScheme.secondary, count: reportModel?.data?.teachers ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_staff', color: Theme.of(context).colorScheme.surfaceContainer, count: reportModel?.data?.staffs ?? 0,)),

          ],
        ):Column(spacing: Dimensions.paddingSizeDefault, children: [
          Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_admin', color: Theme.of(context).primaryColor, count: reportModel?.data?.admins ?? 0)),
            Expanded(child: CountingItemWidget(title: 'total_students', color: Theme.of(context).colorScheme.tertiaryContainer, count: reportModel?.data?.students ?? 0,),),

          ]),
          Row(spacing: Dimensions.paddingSizeDefault, children: [
            Expanded(child: CountingItemWidget(title: 'total_teacher', color: Theme.of(context).colorScheme.secondary, count: reportModel?.data?.teachers ?? 0,),),
            Expanded(child: CountingItemWidget(title: 'total_staff', color: Theme.of(context).colorScheme.surfaceContainer, count: reportModel?.data?.staffs ?? 0,)),
          ],
          )
        ]);
      },
    );
  }
}
class CountingItemWidget extends StatelessWidget {
  final String title;
  final int count;
  final Color? color;
  final double? increaseNumber;
  const CountingItemWidget({super.key, required this.title, required this.count, this.color, this.increaseNumber});

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(color: color,
      horizontalPadding: 20,verticalPadding: 20,borderRadius: 10,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeExtraSmall, children: [
        const CustomImage(image : Images.group, width: 25, localAsset: true),
        Text(count.toString(), style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Colors.white)),

        Text(title.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white)),
    ]),);
  }
}

