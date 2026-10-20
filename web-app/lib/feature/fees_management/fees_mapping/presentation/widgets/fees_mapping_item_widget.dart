import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/domain/model/fees_mapping_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:get/get.dart';
import 'package:class_compass/util/styles.dart';

class FeesMappingItemWidget extends StatelessWidget {
  final FeesMappingItem feesMappingItem;
  final int index;
  const FeesMappingItemWidget({super.key, required this.feesMappingItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: '${feesMappingItem.feeHead?.name}')),
      Expanded(child: SizedBox(height: 40,
        child: ListView.separated(
          itemCount: feesMappingItem.feeHead?.feeSubHeads?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index){
              return CustomItemTextWidget(text: feesMappingItem.feeHead?.feeSubHeads?[index].name??'N/A');
            }, separatorBuilder: (BuildContext context, int index) {
            return const Text(", ", style: textRegular,);
        },),
      )),
      Expanded(child: CustomItemTextWidget(text: '${feesMappingItem.feeLedger?.ledgerName}')),

      IconButton(onPressed: (){
        Get.dialog(ConfirmationDialog(
          title: "fee_mapping".tr,
          content: "fee_mapping".tr,
            onTap: (){
          Get.find<FeesMappingController>().deleteFeesMapping(feesMappingItem.id!);
        }));
      }, icon: const CustomImage(image: Images.deleteIcon, height: 20, width: 20,))

    ],
    );
  }
}
