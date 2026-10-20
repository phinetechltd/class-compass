import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_model.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';

class SmartCollectionStudentItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  const SmartCollectionStudentItemWidget({super.key, this.studentItem, required this.index});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SmartCollectionController>(
      builder: (smartCollectionController) {
        return ResponsiveHelper.isDesktop(context)?
        Row(spacing: Dimensions.paddingSizeDefault, children: [
          NumberingWidget(index: index),
          Expanded(child: CustomItemTextWidget(text: "${studentItem?.id}")),
          Expanded(child: CustomItemTextWidget(text: studentItem?.roll??'',)),
          Expanded(child: CustomItemTextWidget(text: "${studentItem?.name}")),
          Expanded(child: CustomItemTextWidget(text: "${studentItem?.className}")),
          Expanded(child: CustomItemTextWidget(text: "${studentItem?.groupName}")),

        studentItem?.loading?? false? const CircularProgressIndicator():
        CustomContainer(borderRadius: 5,onTap: (){
          smartCollectionController.getSmartCollectionDetails(studentItem!.id!, index);
        },verticalPadding: 5,horizontalPadding: 5,
          child: SizedBox(width: 20,height: 20,child: Image.asset(Images.cart, color: Theme.of(context).hintColor,)),),

        ],):

        CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text: "${studentItem?.id}"),
              CustomItemTextWidget(text: "${studentItem?.name}"),
              CustomItemTextWidget(text: "${"roll".tr} : ${studentItem?.roll??''}",),
              CustomItemTextWidget(text: "${"class".tr} : ${studentItem?.className??''}",),
              CustomItemTextWidget(text: "${"group".tr} : ${studentItem?.groupName??''}",),

            ]),
            ),
            studentItem?.loading?? false? const CircularProgressIndicator():
            CustomContainer(borderRadius: 5,onTap: (){
              smartCollectionController.getSmartCollectionDetails(studentItem!.id!, index);
            },verticalPadding: 5,horizontalPadding: 5,
              child: SizedBox(width: 20,height: 20,child: Image.asset(Images.cart,
                color: systemPrimaryColor())),),


          ],
        ));
      }
    );
  }
}