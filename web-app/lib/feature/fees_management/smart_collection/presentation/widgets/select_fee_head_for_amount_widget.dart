import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_details_model.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/sub_head_wise_collection_body.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class SelectFeeHeadForAmountWidget extends StatelessWidget {
  const SelectFeeHeadForAmountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartCollectionController>(builder: (controller) {
      SmartCollectionDetailsModel? smartCollectionDetailsModel = controller.smartCollectionDetailsModel;
      SmartItem? smartItem = smartCollectionDetailsModel?.data;

      return CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Column( children: [

            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: smartItem?.feeHeads?.length,
                itemBuilder: (context, index){
                  List<FeeSubHeads>? subHeads = smartItem?.feeHeads?[index].feeSubHeads;
                  return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text("${smartItem?.feeHeads?[index].name}"),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Container(width: 1,height: 20, color: Theme.of(context).hintColor,),),
                    Expanded(child: SizedBox(height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: subHeads?.length,
                          itemBuilder: (context, subIndex){
                            return Padding(padding: const EdgeInsets.all(5.0),
                              child: CustomContainer(color: subHeads![subIndex].selected! ?

                              Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                  border: Border.all(color:Theme.of(context).hintColor, width: 1),
                                  showShadow: false,
                                  onTap: ()=> controller.toggleSelectionFeeSubHead(index, subIndex),
                                  horizontalPadding: Dimensions.paddingSizeSmall,
                                  verticalPadding: Dimensions.paddingSizeExtraSmall,
                                  borderRadius: Dimensions.paddingSizeExtraSmall,
                                  child: Text("${subHeads[subIndex].name}",
                                    style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                      color: subHeads[subIndex].selected! ? Colors.white :
                                      Theme.of(context).textTheme.displayLarge?.color,),)),
                            );
                          }),
                    ))
                  ],);
                  }),

              const SizedBox(height: Dimensions.paddingSizeSmall),
            Align(alignment: Alignment.centerRight,
                child: SizedBox(width: 90,child: controller.isLoading?
                const Center(child: CircularProgressIndicator()):
                CustomButton(borderRadius: Dimensions.paddingSizeExtraSmall,
                    innerPadding: EdgeInsets.zero, onTap: (){
                  List<FeeHeadId>? feeHeadId = [];
                  if (smartItem?.feeHeads != null) {
                    for (var feeHead in smartItem!.feeHeads!) {
                      if (feeHead.feeSubHeads != null) {
                        var selectedSubHeads = feeHead.feeSubHeads!.where((sub) => sub.selected!).toList();
                        if (selectedSubHeads.isNotEmpty) {
                          List<int> subHeadIds = selectedSubHeads.map((sub) => sub.id!).toList();
                          feeHeadId.add(FeeHeadId(id: feeHead.id, feeSubHeadIds: subHeadIds));
                        }
                      }
                    }
                  }

                  SubHeadWiseCollectionBody body = SubHeadWiseCollectionBody(
                      studentId: smartItem?.studentSession?.studentId, feeHeadId: feeHeadId);
                  controller.getSubHeadWiseCalculation(body);
                  }, text: "confirm".tr)))

            ]));
      }
    );
  }
}
