import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/responsive_grid_widget.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/cms_management/cms_settings/presentation/widgets/hover_and_auto_scroll_image.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class SelectThemeWidget extends StatefulWidget {
  const SelectThemeWidget({super.key});

  @override
  State<SelectThemeWidget> createState() => _SelectThemeWidgetState();
}

class _SelectThemeWidgetState extends State<SelectThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "select_theme".tr),
      body: CustomWebScrollView(slivers: [SliverToBoxAdapter(
        child: Column(children: [

           SectionHeaderWithPath(sectionTitle: "cms_management".tr, pathItems: ["manage_theme".tr],),
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
             child: CustomContainer(
               child: ResponsiveMasonryGrid(children: [
                Column(spacing: Dimensions.paddingSizeDefault, children: [
                    const HoverAdvancedScrollImage(imageUrl: Images.themeOne,
                        height: 380, width: 600, speed: 30),
                  Row(children: [
                    Expanded(child: Text("default".tr, style: textRegular)),
                    SizedBox(width: 100, child: CustomButton(onTap: (){},
                        text: "activated".tr))
                  ])
                  ],
                ),
                Column(spacing: Dimensions.paddingSizeDefault, children: [
                    const HoverAdvancedScrollImage(imageUrl: Images.themeTwo,
                        height: 380, width: 600, speed: 30),
                    Row(children: [
                      Expanded(child: Text("kindergarten".tr, style: textRegular)),
                      SizedBox(width: 100, child: CustomButton(onTap: (){}, text: "active".tr))
                    ])
                  ],
                ),
                         ]),
             ),
           )
        ]),
      )]));
  }
}
