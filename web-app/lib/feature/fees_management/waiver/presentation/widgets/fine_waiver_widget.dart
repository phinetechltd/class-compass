import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class FineWaiverWidget extends StatelessWidget {
  const FineWaiverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaiverController>(
        builder: (waiverConfigController) {
          return Column(children: [
            SectionHeaderWithPath(sectionTitle: "fees_management".tr,
                pathItems: ["fine_waiver".tr]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomContainer(
                  child: Column(children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
                      const Expanded(child: SelectClassWidget()),
                      const Expanded(child: SelectSectionWidget()),


                      Padding(padding: const EdgeInsets.only(bottom: 8),
                          child: SizedBox(width: 90, child: CustomButton(onTap: (){

                          }, text: "process")))
                    ]),




                  ],),
                ),
              ),
            ],
          );
        }
    );
  }
}
