import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:get/get.dart';

class CourseItemCardWidget extends StatefulWidget {
  final CourseItem? courses;
  const CourseItemCardWidget({super.key, required this.courses});

  @override
  State<CourseItemCardWidget> createState() => _CourseItemCardWidgetState();
}

class _CourseItemCardWidgetState extends State<CourseItemCardWidget> {
  bool _isHover = false;
  void _hover(bool v) => setState(() => _isHover = v);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(onEnter: (_) => _hover(true),
      onExit: (_) => _hover(false),
      child: SizedBox(width: 520, height: 260,
        child: Stack(children: [


            ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              child: CustomImage(image: "${AppConstants.baseUrl}/storage/courses/${widget.courses?.image}",
                width: 520, height: 260, fit: BoxFit.cover)),

            Positioned(left: 0, right: 0, bottom: 0,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 50000),
                  curve: Curves.easeIn,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(Dimensions.paddingSizeSmall)),
                  gradient: LinearGradient(begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).cardColor.withValues(alpha: .95),
                      Theme.of(context).cardColor.withValues(alpha: .94)])),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Text(widget.courses?.title ?? '', maxLines: 2,
                      overflow: TextOverflow.ellipsis, style: textBold.copyWith(
                        color: Colors.white, fontSize: Dimensions.fontSizeLarge)),

                    const SizedBox(height: 6),

                    (widget.courses?.paymentType == "free")
                        ? Text("free".tr, style: textBold.copyWith(color: Colors.white,
                        fontSize: Dimensions.fontSizeLarge))
                        : Text(PriceConverter.convertPrice(
                          context, widget.courses?.offerPrice ?? 0),
                      style: textBold.copyWith(color: Colors.white,
                        fontSize: Dimensions.fontSizeLarge)),


                  AnimatedContainer(duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    height: _isHover ?  50 : 0,
                    child: Stack(children: [
                      AnimatedPositioned(duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        bottom: _isHover ? 0 : -40, left: 0,
                        child: AnimatedOpacity(duration: const Duration(milliseconds: 250),
                          opacity: _isHover ? 1 : 0,
                          child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                            SizedBox(width: 170, child: CustomButton(onTap: () {},
                                text: "add_to_cart".tr)),

                                SizedBox(width: 170, child: CustomButton(onTap: () {},
                                    text: "buy_now".tr)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ]))),


            Positioned.fill(child: Material(color: Colors.transparent,
              child: InkWell(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                onTap: () {
                Get.toNamed(RouteHelper.getFrontendCourseDetailsRoute(widget.courses?.slug ?? ''),);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
