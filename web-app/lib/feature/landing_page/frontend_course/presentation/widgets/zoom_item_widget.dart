import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class ZoomItemWidget extends StatelessWidget {
  final ZoomMeetings? zoomItem;
  final int index;
  const ZoomItemWidget({super.key, this.zoomItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Column(children: [
        Row(spacing: Dimensions.paddingSizeSmall, children: [
         Expanded(child: Text("${zoomItem?.topic}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(child: Text(DateConverter.dateTimeStringToMonthAndYear(zoomItem?.startTime??''), style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(child: Text("${zoomItem?.duration?.toString()??''} Minutes", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),)),
          Expanded(
            child: InkWell(onTap: ()=> AppConstants.openUrl(zoomItem?.joinUrl?.toString()??''),
                child: CustomContainer(horizontalPadding: 20, borderRadius: 5,
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Center(child: Text('join_url'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),)))),
          ),


        ]),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: CustomDivider())
      ],
      ) :
      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: CustomContainer(borderRadius: 6, child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${zoomItem?.topic}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Text("Start Time: ${zoomItem?.startTime??''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
              Text("Duration: ${zoomItem?.duration?.toString()??''}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),


            ]),
            ),
            InkWell(onTap: ()=> AppConstants.openUrl(zoomItem?.joinUrl?.toString()??''),
                child: CustomContainer(horizontalPadding: 20, borderRadius: 5,
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Center(child: Text('join_url'.tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),)))),
          ],
        )),
      ),
    );
  }
}