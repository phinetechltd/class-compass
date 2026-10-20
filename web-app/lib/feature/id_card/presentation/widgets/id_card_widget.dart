import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:class_compass/feature/id_card/logic/id_card_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class IdCardWidget extends StatefulWidget {
  const IdCardWidget({super.key});

  @override
  State<IdCardWidget> createState() => _IdCardWidgetState();
}

class _IdCardWidgetState extends State<IdCardWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutAndCertificateController>(
        builder: (layoutAndCertificateController) {
          String title = 'id_card'.tr;
          return Column(children: [
            Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: CustomTitle(title: title, webTitle: ResponsiveHelper.isDesktop(context),),),

            Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
              child: CustomContainer(showShadow: false, borderRadius: 5,
                  child: Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.end, children: [
                    const Expanded(child: SelectClassWidget()),

                    SizedBox(width: 120,child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomButton(onTap: (){
                        int? classId = Get.find<ClassController>().selectedClassItem?.id;

                         if(classId == null){
                          showCustomSnackBar("class_is_empty".tr);
                        }else{
                           Get.find<IdCardController>().openPrintLink("student_id_card", params: {"class_id": classId});
                         }
                      }, text: "search".tr),
                    ),)
                  ])),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault),

          ]);
        }
    );
  }

}
