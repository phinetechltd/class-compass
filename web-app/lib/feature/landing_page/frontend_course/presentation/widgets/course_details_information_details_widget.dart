
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/domain/model/my_course_details_model.dart';
import 'package:class_compass/feature/landing_page/frontend_course/logic/frontend_course_controller.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/all_course_list_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/course_include_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/frontend_course_summery_overview_widget.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/preview_content_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/footer_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CourseDetailsInformationDetailsWidget extends StatefulWidget {
  final MyCourseDetailsModel courseDetailsModel;
  const CourseDetailsInformationDetailsWidget({super.key, required this.courseDetailsModel});

  @override
  State<CourseDetailsInformationDetailsWidget> createState() => _CourseDetailsInformationDetailsWidgetState();
}

class _CourseDetailsInformationDetailsWidgetState extends State<CourseDetailsInformationDetailsWidget> {
  final ScrollController _scrollController = ScrollController();
  double _summaryTop = 0;
  final GlobalKey _footerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final RenderBox? footerBox =
    _footerKey.currentContext?.findRenderObject() as RenderBox?;
    final double footerY = footerBox?.localToGlobal(Offset.zero).dy ?? double.infinity;

    const double summaryHeight = 520;
    if (footerY < summaryHeight + 100) {
      double offset = summaryHeight + 100 - footerY;
      setState(() {
        _summaryTop = 0 - offset;
      });
    } else {
      setState(() {
        _summaryTop = 0;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Courses? course = widget.courseDetailsModel.data;
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    return GetBuilder<FrontendCourseController>(builder: (courseController) {
      return Stack(children: [
          SingleChildScrollView(controller: _scrollController,
            child: Column(spacing: Dimensions.paddingSizeExtraLarge, children: [
              Center(child: Padding(padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
                child: SizedBox(width: Dimensions.webMaxWidth,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    SizedBox(width: isDesktop?
                    Dimensions.webMaxWidth - 400 : Get.width-30,
                      child: Column(spacing: Dimensions.paddingSizeExtraLarge,
                          crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SectionHeaderWithPath(sectionTitle: "home".tr,
                              pathItems: ["category".tr],),
                        Text(course?.courseTitle ?? '',
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeOverLarge)),

                        HtmlViewer(htmlText: course?.courseDescription??''),

                            Row(spacing: Dimensions.paddingSizeDefault, children: [
                              Text("📅 Last updated 1/2026", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                              Text("🌐 English", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                            ],),

                        CustomContainer(border: Border.all(width: 1,color: Theme.of(context).hintColor),
                          showShadow: false,
                          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: Column(spacing: Dimensions.paddingSizeDefault,
                                crossAxisAlignment: CrossAxisAlignment.start, children: [


                              Text('what_you_will_learn'.tr,
                                  style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),

                              HtmlViewer(htmlText: course?.courseDescription??''),
                              HtmlViewer(htmlText: course?.courseDescription??''),
                              HtmlViewer(htmlText: course?.courseDescription??''),
                              HtmlViewer(htmlText: course?.courseDescription??''),
                            ]),
                          ),
                        ),

                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            const CourseIncludeWidget(),

                            PreviewCourseContentWidget(courseDetailsModel: widget.courseDetailsModel),

                      ])),

                    if(isDesktop)...[
                      const SizedBox(width: 20),
                      const SizedBox(width: 350)],

                  ])),
              )),
              AllCourseListWidget(scrollController: _scrollController),
              Padding(key: _footerKey,
                  padding: const EdgeInsets.only(top: Dimensions.homePagePadding),
                  child: const FooterWidget()),
            ])),

          if(isDesktop)
          Positioned(top: _summaryTop,
            left: MediaQuery.of(context).size.width / 2 + (Dimensions.webMaxWidth / 2 - 350),
            child: SizedBox(width: 350, child: FrontendCourseSummeryOverviewWidget(
                courseDetailsModel: widget.courseDetailsModel))),
        ],
      );
    });
  }
}

class IconRowWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconRowWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      Icon(icon),
      Text(text, style: textRegular),
    ]);
  }
}
