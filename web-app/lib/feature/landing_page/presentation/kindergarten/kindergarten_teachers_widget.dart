import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/landing_page/domain/models/teacher_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/generic_school/teacher/teacher_loading_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class KindergartenTeachersWidget extends StatefulWidget {
  const KindergartenTeachersWidget({super.key});

  @override
  State<KindergartenTeachersWidget> createState() => _KindergartenTeachersWidgetState();
}

class _KindergartenTeachersWidgetState extends State<KindergartenTeachersWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      initState: (val){
        final landingPageController = Get.find<LandingPageController>();
        if (landingPageController.teacherModel == null) {
          landingPageController.getTeachersData();
        }
      },
      builder: (landingPageController) {
        TeacherModel? teacherModel = landingPageController.teacherModel;
        final isDesktop = ResponsiveHelper.isDesktop(context);
        return teacherModel != null?
            isDesktop?
        Container(decoration: BoxDecoration(color: Theme.of(context).hintColor.withValues(alpha: .1)),width: MediaQuery.sizeOf(context).width,
          child: Padding(padding:  EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context)? 50 : Dimensions.paddingSizeExtraLarge),
            child: Center(
              child: SizedBox( width: Dimensions.webMaxWidth,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [

                    Text("meet_our_dedicated_and_experienced_teachers".tr,
                      textAlign: TextAlign.center, style: textBold.copyWith(fontSize: 40, color: Theme.of(context).colorScheme.primary),),

                  SizedBox(height: 300,
                    child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                        InkWell(onTap: (){
                          scrollController.animateTo(
                            scrollController.offset - 200,
                            duration:
                            const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                            child: const CircleAvatar(child: Icon(Icons.arrow_back),)),
                        Expanded(
                          child: ListView.builder(
                              controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                            itemCount: teacherModel.data?.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return TeacherCardWidget(item: teacherModel.data?[index]);
                            }),
                        ),
                         InkWell(onTap: (){
                           scrollController.animateTo(
                             scrollController.offset + 200,
                             duration:
                             const Duration(milliseconds: 300),
                             curve: Curves.easeInOut,
                           );
                         },
                            child: const CircleAvatar(child: Icon(Icons.arrow_forward),)),
                      ],
                    ))
                  ]),
              ),
            ),
          ),
        ):

            Container(decoration: BoxDecoration(color: Theme.of(context).hintColor.withValues(alpha: .1)),width: MediaQuery.sizeOf(context).width,
              child: Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Center(
                    child: SizedBox( width: Dimensions.webMaxWidth,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Text("meet_our_dedicated_and_experienced_teachers".tr, textAlign: TextAlign.center, style: textBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).colorScheme.primary),),
                        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                        SizedBox(height: 300,
                            child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: teacherModel.data?.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return  TeacherCardWidget(item: teacherModel.data?[index]);
                                    }),
                              ),
                            ],
                            ))
                      ]),
                    ),
                  ),
                ),
              ),
            ) :const TeacherLoadingWidget();
      }
    );
  }
}

class TeacherCardWidget extends StatelessWidget {
  final TeacherItem? item;
  const TeacherCardWidget({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
      child: CustomContainer(width: 220,horizontalPadding: 10,verticalPadding: 10,borderRadius: 5,
        showShadow: false, border: Border.all(width: .25, color: Theme.of(context).primaryColorDark.withValues(alpha: 0.1)),
        child: Column(children: [
          CustomImage(width: 200, height: 200, image : "${AppConstants.baseUrl}//storage/users/${item?.user?.image??''}"),
         const SizedBox(height: Dimensions.paddingSizeDefault),
          Text(item?.name??'',maxLines: 1, overflow: TextOverflow.ellipsis, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
          Text(item?.designation??'',maxLines: 1,overflow: TextOverflow.ellipsis,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
        ]),
      ),
    );
  }
}
