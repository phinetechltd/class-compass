import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/sent_sms_report_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class SentSmsReportItemWidget extends StatelessWidget {
  final SmsReportItem? userItem;
  final int index;
  const SentSmsReportItemWidget({super.key, this.userItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeSmall, children: [
     NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: userItem?.message??'')),
      Expanded(child: CustomItemTextWidget(text: userItem?.receiver??'')),
      Expanded(child: CustomItemTextWidget(text: userItem?.userType??'')),

    ],
    ):
    Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, 0),
      child: CustomContainer(borderRadius: 5, 
        child: Row( children: [

          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              CustomItemTextWidget(text: userItem?.message??''),
              CustomItemTextWidget(text: userItem?.receiver??''),
              CustomItemTextWidget(text: userItem?.userType??''),

            ],),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
        ],
        )
      ),
    );
  }
}
