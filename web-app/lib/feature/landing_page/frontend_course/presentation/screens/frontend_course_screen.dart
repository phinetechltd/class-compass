import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_search.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/all_course_list_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/landing_page_appbar.dart';
import 'package:class_compass/util/dimensions.dart';

class FrontendCourseScreen extends StatefulWidget {
  const FrontendCourseScreen({super.key});

  @override
  State<FrontendCourseScreen> createState() => _FrontendCourseScreenState();
}

class _FrontendCourseScreenState extends State<FrontendCourseScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandingPageAppBar(),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(children: [
            const SizedBox(height: Dimensions.paddingSizeDefault),
            CustomSearch(hintText: "search_course".tr,
                searchController: searchController),
            AllCourseListWidget(scrollController: scrollController),
          ])
        ),
      ]),
    );
  }
}
