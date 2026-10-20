import 'package:flutter/material.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/footer_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/landing_page_appbar.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;

  const BaseLayout({
    super.key,
    required this.child,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
          Padding(padding: const EdgeInsets.only(top: 78), // leave space for header
            child: WebSmoothScroll(
              controller: scrollController,
              scrollSpeed: 2.1,
              scrollAnimationLength: 800,
              child: SingleChildScrollView(controller: scrollController,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  child,
                  const Padding(padding: EdgeInsets.only(top: Dimensions.homePagePadding),
                      child: FooterWidget()),
                  ])))),

          // Header
          Container(height: 95, width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
            child: const LandingPageAppBar()),
        ],
      ),
    );
  }
}
