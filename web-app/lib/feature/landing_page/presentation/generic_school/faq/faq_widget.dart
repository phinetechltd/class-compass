import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/faq_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/faq/landing_faw_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({super.key});

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  int? expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val) => Get.find<LandingPageController>().getFaqData(),
      builder: (faqController) {
        final isDesktop = ResponsiveHelper.isDesktop(context);
        FaqModel? faqModel = faqController.faqModel;
        final faqs = faqModel?.data ?? [];

        if (faqs.isEmpty) return const SizedBox();
        return Center(child: SizedBox(width: Dimensions.webMaxWidth,
          child: Padding(padding: EdgeInsets.symmetric(
            vertical: isDesktop ? Dimensions.paddingSizeDefault : 0,
              horizontal: Dimensions.paddingSizeDefault),

            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: EdgeInsets.only(top: isDesktop ? Dimensions.paddingSizeOver : 0,
                bottom: isDesktop ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall),
                child: Text("frequently_asked_questions".tr, style: textHeavy.copyWith(
                    fontSize: isDesktop ? Dimensions.fontSizeExtraOverLarge : Dimensions.fontSizeLarge,
                  ))),

                  ListView.builder(
                    itemCount: faqs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = faqs[index];
                      final isExpanded = expandedIndex == index;
                      return LandingFaqItemWidget(
                        item: item,
                        isExpanded: isExpanded,
                        isDesktop: isDesktop,
                        onTap: () {
                          setState(() {
                            expandedIndex = isExpanded ? null : index;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
