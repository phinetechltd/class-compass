import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:class_compass/feature/landing_page/domain/models/event_model.dart';


class EventDetailsDialogWidget extends StatelessWidget {
  final EventItem item;
  const EventDetailsDialogWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeSmall, children: [
          Text(item.name??'', style: textMedium.copyWith(fontSize: 20),),

          HtmlViewer(htmlText:item.details??''),
        ],
        ),
      ),
    );
  }
}
