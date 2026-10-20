import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/auto_scroll_widget.dart';
import 'package:class_compass/feature/landing_page/domain/models/teacher_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/teacher/front_end_teacher_card_widget.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/teacher/teacher_loading_widget.dart';
import 'package:class_compass/feature/landing_page/widgets/landing_section_header_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class TeachersWidget extends StatefulWidget {
  const TeachersWidget({super.key});

  @override
  State<TeachersWidget> createState() => _TeachersWidgetState();
}

class _TeachersWidgetState extends State<TeachersWidget> {
  ScrollController scrollController = ScrollController();
  bool showLeft = false;
  bool showRight = true;

  void _scrollListener() {
    if (!mounted) return;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    setState(() {
      showLeft = currentScroll > 0;
      showRight = currentScroll < maxScroll;
    });
  }

  void _scrollLeft() {
    scrollController.animateTo(
      (scrollController.offset - 200).clamp(
        0,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    scrollController.animateTo(
      (scrollController.offset + 200).clamp(
        0,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(initState: (_) {
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.teacherModel == null) {
          landingPageController.getTeachersData();
        }
      },
      builder: (landingPageController) {
        TeacherModel? teacherModel = landingPageController.teacherModel;
        final isDesktop = ResponsiveHelper.isDesktop(context);

        if (teacherModel == null) return const TeacherLoadingWidget();

        return Container(decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withValues(alpha: 0.1)),
          width: MediaQuery.sizeOf(context).width,
          child: Padding(padding: EdgeInsets.symmetric(
              vertical: isDesktop ? 50 : Dimensions.paddingSizeExtraLarge),
            child: Center(child: SizedBox(width: Dimensions.webMaxWidth,
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, children: [

                    LandingSectionHeader(subtitle: "teachers".tr,
                      title: "meet_our_dedicated_and_experienced_teachers".tr),
                    const SizedBox(height: 20),


                    SizedBox(height: 300, child: isDesktop ? Stack(children: [
                      AutoScrollListView(
                        controller: scrollController,
                        itemCount: teacherModel.data?.length??0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return FrontendTeacherCardWidget(item: teacherModel.data?[index]);
                          }, itemExtent: 220),

                          if (showLeft)
                            Positioned(left: 0, top: 0, bottom: 0,
                              child: Center(child: InkWell(onTap: _scrollLeft,
                                  child: const CircleAvatar(child: Icon(Icons.arrow_back))),
                              ),
                            ),

                          if (showRight)
                            Positioned(right: 0, top: 0, bottom: 0,
                              child: Center(child: InkWell(onTap: _scrollRight,
                                  child: const CircleAvatar(child: Icon(Icons.arrow_forward))),
                              ),
                            ),
                        ],
                      )
                        : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        itemCount: teacherModel.data?.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return FrontendTeacherCardWidget(
                              item: teacherModel.data?[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


