import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/widgets/heading_type_button_widget.dart';
import 'package:class_compass/feature/id_card/logic/id_card_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class IdCardTypeSelectionWidget extends StatelessWidget {
  const IdCardTypeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IdCardController>(
      builder: (idCardController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: SizedBox(height: 35,
            child: ListView(scrollDirection: Axis.horizontal, shrinkWrap: true,
                padding: EdgeInsets.zero, children: [
                HeadingTypeButtonWidget(title: "teacher_id".tr, selected: idCardController.idTypeIndex == 0,
                    onTap: () {
                      idCardController.setSelectedIdTypeIndex(0);
                      idCardController.openPrintLink("teacher_id_card");
                    }),
                  HeadingTypeButtonWidget(title: "staff_id".tr, selected: idCardController.idTypeIndex == 1,
                      onTap: () {
                        idCardController.setSelectedIdTypeIndex(1);
                        idCardController.openPrintLink("staff_id_card");
                      }),
                  HeadingTypeButtonWidget(title: "student_id".tr, selected: idCardController.idTypeIndex == 2,
                      onTap: () => idCardController.setSelectedIdTypeIndex(2)),
                ]),
          ),
        );
      }
    );
  }
}
