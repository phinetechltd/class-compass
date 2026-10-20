import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/widgets/general_settings_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class SystemSettingWidget extends StatefulWidget {
  const SystemSettingWidget({super.key});

  @override
  State<SystemSettingWidget> createState() => _SystemSettingWidgetState();
}

class _SystemSettingWidgetState extends State<SystemSettingWidget> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      initState: (val){
        if(Get.find<SystemSettingsController>().generalSettingModel == null){
          Get.find<SystemSettingsController>().getGeneralSetting();
        }
      },
      builder: (systemSettingsController) {
        return const Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, showShadow: false,
            verticalPadding: Dimensions.paddingSizeExtraLarge,
            child: Column(children: [
              GeneralSettingsWidget(),
            ],),
          ),
        );
      }
    );
  }
}
