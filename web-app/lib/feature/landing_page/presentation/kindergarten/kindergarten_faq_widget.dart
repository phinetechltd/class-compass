import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/faq_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class KindergartenFaqWidget extends StatefulWidget {
  const KindergartenFaqWidget({super.key});

  @override
  State<KindergartenFaqWidget> createState() => _KindergartenFaqWidgetState();
}

class _KindergartenFaqWidgetState extends State<KindergartenFaqWidget> {
  int? expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val) => Get.find<LandingPageController>().getFaqData(),
      builder: (faqController) {
        final isDesktop = ResponsiveHelper.isDesktop(context);
        FaqModel? faqModel = faqController.faqModel;
        final faqs = faqModel?.data ?? [];
        return (faqs.isNotEmpty) ? Center(
          child: SizedBox(width: Dimensions.webMaxWidth,
            child: Padding(padding: EdgeInsets.symmetric(vertical:isDesktop ? 50 : 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                if(!ResponsiveHelper.isDesktop(context))
                Padding(padding: EdgeInsets.only(top: isDesktop ? Dimensions.paddingSizeOver : 0,
                    bottom: isDesktop ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall),
                    child: Text("Frequently Asked Questions",
                        style: textHeavy.copyWith(fontSize: isDesktop ? Dimensions.fontSizeExtraOverLarge : Dimensions.fontSizeLarge,))),

                Row(spacing: 50,
                  children: [
                    if(ResponsiveHelper.isDesktop(context))
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 400,
                            child: Text("Frequently Asked Questions",
                                style: textHeavy.copyWith(fontSize: isDesktop ? Dimensions.fontSizeExtraOverLarge : Dimensions.fontSizeLarge,)),
                          ),

                          Text("faq_description".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall)),
                          const CustomImage(width: 400, image: Images.faqImage, localAsset: true,),
                        ],
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: faqs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final item = faqs[index];
                          final isExpanded = expandedIndex == index;
                          return Column(children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  expandedIndex = isExpanded ? null : index;
                                });
                              },
                              child: AnimatedContainer(duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(color: isExpanded ? Theme.of(context).secondaryHeaderColor : Theme.of(context).hintColor.withValues(alpha: .07),
                                    borderRadius: isExpanded ? const BorderRadius.vertical(top: Radius.circular(10)) : BorderRadius.circular(10),
                                    boxShadow: [
                                      if (isExpanded)
                                        const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                                    ]),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Row(children: [
                                  Expanded(child: Text("${index+1}. ${item.question ?? ''}",
                                      style: textHeavy.copyWith(color: isExpanded ? Colors.white : Theme.of(context).textTheme.displayMedium?.color, fontSize: isDesktop ? Dimensions.fontSizeLarge : Dimensions.fontSizeExtraLarge))),
                                  AnimatedRotation(turns: isExpanded ? 0.5 : 0.0,
                                      duration: const Duration(milliseconds: 200),
                                      child: Icon(Icons.keyboard_arrow_down, color: isExpanded ? Colors.white : Colors.grey.shade600)),
                                ],
                                ),
                              ),
                            ),
                            AnimatedCrossFade(firstChild: const SizedBox.shrink(),
                                secondChild: Container(width: Dimensions.webMaxWidth, decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
                                    border: Border.all(color: Theme.of(context).secondaryHeaderColor)),
                                    child: Padding(padding: const EdgeInsets.all(16.0),
                                        child: Text(item.answer ?? '', style: textRegular.copyWith()))),
                                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 200)),
                            const SizedBox(height: 8),
                          ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
              ),
            ),
          ),
        )
            : const SizedBox();
      },
    );
  }
}

