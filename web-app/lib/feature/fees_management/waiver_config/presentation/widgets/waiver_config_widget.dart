import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/fees_management/waiver_config/controller/waiver_config_controller.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/widgets/waiver_assign_and_config_widget.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/widgets/waiver_assign_widget.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/widgets/waiver_config_list_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class WaiverConfigWidget extends StatelessWidget {
  final ScrollController scrollController;
  const WaiverConfigWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverConfigController>(builder: (waiverConfigController) {
          return Column(children: [
              SectionHeaderWithPath(sectionTitle: "fees_management".tr, pathItems: ["waiver_config".tr],),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(children: [
                    const WaiverAssignAndConfigTypeWidget(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),

                    if(waiverConfigController.waiverConfigTypeIndex == 0)
                      const WaiverAssignWidget(),

                  if(waiverConfigController.waiverConfigTypeIndex == 1)
                  WaiverConfigListWidget(scrollController: scrollController,)



                  ],),
              ),
            ],
          );
        }
    );
  }
}
