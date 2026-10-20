import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/dialog/institute_type_dialog.dart';
import 'package:class_compass/common/dialog/right_side_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/enums.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class InstituteSelector extends StatefulWidget {
  const InstituteSelector({super.key});

  @override
  State<InstituteSelector> createState() => _InstituteSelectorState();
}

class _InstituteSelectorState extends State<InstituteSelector> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingPageController>(
      builder: (landingPageController) {
        return InkWell(onTap: () async {
            final result = await showRightSideDialog<InstituteEnum>(context, child: const InstituteMenuDialog());
            if (result != null) {
              landingPageController.setInstitute(result);
            }
          },
          child: CustomContainer(showShadow: false, verticalPadding: 7,
            border: Border.all(color: Theme.of(context).primaryColorDark.withValues(alpha: .25), width: .125),
            borderRadius: 123,
            child: Row(spacing: Dimensions.paddingSizeExtraSmall, children: [
              Icon(Icons.school, color: systemPrimaryColor()),
                Text(landingPageController.selected.label.split(" - ").first, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
              Icon(Icons.arrow_drop_down, color: Theme.of(context).hintColor),
              ],
            ),
          ),
        );
      }
    );
  }
}
