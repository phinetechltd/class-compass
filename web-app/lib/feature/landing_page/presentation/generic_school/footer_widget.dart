import 'package:flutter/material.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/footer/copyright_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/footer/footer_left_portion.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/footer/footer_quick_link_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/footer/news_letter_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return isDesktop? Column(children: [
        Container(color: Theme.of(context).cardColor, padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: const Center(child: SizedBox(width: Dimensions.webMaxWidth,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(child: FooterLeftPortion()),
                Expanded(child: FooterQuickLinkWidget()),
                Expanded(child: NewsLetterWidget()),
                ])))),
      const CopyrightWidget()
      ]):

    Column(children: [
      Container(color: Theme.of(context).cardColor, padding: const EdgeInsets.symmetric(vertical: 50),
        child: const Column(spacing: Dimensions.paddingSizeOverLarge, children: [
          FooterLeftPortion(),
          FooterQuickLinkWidget(),
          NewsLetterWidget(),
        ])),
      const CopyrightWidget()
    ]);
  }
}

