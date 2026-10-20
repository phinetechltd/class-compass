import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_model.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MyCourseItemWidget extends StatefulWidget {
  final MyCourseItem? courses;
  const MyCourseItemWidget({super.key, required this.courses});
  @override
  MyCourseItemWidgetState createState() => MyCourseItemWidgetState();
}

class MyCourseItemWidgetState extends State<MyCourseItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          AnimatedContainer(duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                boxShadow: _isHovered? ThemeShadow.getShadow() : null,
                border: Border.all(color: Theme.of(context).secondaryHeaderColor, width: .125),
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
            transform: Matrix4.identity()
              ..scaleByDouble(_isHovered ? 1.01 : 1.0, _isHovered ? 1.01 : 1.0, 1.0, 1.0),
            child: InkWell(onTap: () {
              if(widget.courses?.course?.slug != null){
                Get.toNamed(RouteHelper.getMyCourseDetailsRoute(widget.courses!.course!.slug!));
              }
            },
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeSmall)),
                    child: Container(color: Theme.of(context).secondaryHeaderColor.withValues(alpha: 0.05),
                      child: CustomImage(image: "${AppConstants.baseUrl}/storage/courses/${widget.courses?.course?.image}",
                          width: 400, height: 168),
                    )),


                Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                      Text(widget.courses?.course?.title??'N/A',maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      Text('${widget.courses?.course?.author?.firstName??'N/A'} ${widget.courses?.course?.author?.lastName??''}',
                          maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),



                      Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
                        Icon(Icons.access_time, size: Dimensions.iconSizeSmall, color: Theme.of(context).hintColor),
                          Expanded(child: Text('Enrolled at: ${widget.courses?.enrollmentDate}',maxLines: 1,overflow: TextOverflow.ellipsis,
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))),
                        ],
                      ),
                    ],
                  ),),


              ]),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
