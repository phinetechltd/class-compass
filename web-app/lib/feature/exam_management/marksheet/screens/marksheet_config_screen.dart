import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_checkbox.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/paginated_list_widget.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/exam_management/marksheet/controller/markaheet_controller.dart';
import 'package:class_compass/feature/exam_management/marksheet/domain/model/marksheet_config_model.dart';
import 'package:class_compass/feature/exam_management/marksheet/widgets/add_new_marksheet_config_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MarksheetConfigScreen extends StatefulWidget {
  const MarksheetConfigScreen({super.key});

  @override
  State<MarksheetConfigScreen> createState() => _MarksheetConfigScreenState();
}

class _MarksheetConfigScreenState extends State<MarksheetConfigScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<MarkSheetController>().getMarkSheetConfigList(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "marksheet_config".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: Column(
          children: [
            SectionHeaderWithPath(sectionTitle: "marksheet_config".tr,
              addNewTitle: "add_new_config".tr,
              onAddNewTap: (){
                Get.dialog(CustomDialogWidget(title: "marksheet_config".tr,
                    width: 900,
                    child: const AddNewMarkSheetConfigWidget()));
              },),
            GetBuilder<MarkSheetController>(
              builder: (marksheetController) {
                final model = marksheetController.marksheetConfigModel;
                final marksheet = model?.data?.data;
                return marksheet != null? marksheet.isNotEmpty?
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: CustomContainer(
                    child: PaginatedListWidget(scrollController: scrollController,
                      totalSize: model?.data?.total??0,
                      offset: model?.data?.currentPage??1,
                      onPaginate: (page) async => marksheetController.getMarkSheetConfigList(page??1),
                      itemView: MasonryGridView.builder(
                        itemCount: marksheet.length,
                          shrinkWrap: true,
                          mainAxisSpacing: Dimensions.paddingSizeDefault,
                          crossAxisSpacing: Dimensions.paddingSizeDefault,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 600),
                          itemBuilder: (_, index){
                        return MarkConfigItemWidget(item: marksheet[index]);
                          }),
                    ),
                  ),
                ): const SizedBox(): const Center(child: CircularProgressIndicator());
              }
            ),
          ],
        ))
      ]),
    );
  }
}


class MarkConfigItemWidget extends StatelessWidget {
  final MarkSheetConfigItem? item;
  const MarkConfigItemWidget({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    String imageUrl = "${AppConstants.imageBaseUrl}/result_card_images";
    String signatureImageUrl = "${AppConstants.imageBaseUrl}/signatures";
    return GetBuilder<MarkSheetController>(
      builder: (marksheetController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Dimensions.paddingSizeSmall,
          children: [
            Row(spacing: Dimensions.paddingSizeDefault,
              children: [
                Expanded(child: Text(item?.name??"", style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
              CustomCheckbox(onChange: (){
                marksheetController.setSelectedMarkSheetConfigItem(item);
              },
                  value: item == marksheetController.selectedMarkSheetConfigItem ),
                EditDeletePopupMenu(
                  onDelete: ()=> marksheetController.deleteMarkSheetConfig(item!.id!),
                )
              ],
            ),
            Stack(children: [
              CustomImage(width: 600, image: "$imageUrl/${item?.borderDesign}"),



              Positioned(bottom: 0,top: 0,left: 0,right: 0,
                child: Align(alignment: Alignment.center,
                  child: Center(child: Opacity(opacity: .25,
                    child: CustomImage(width: 100, image: "$imageUrl/${item?.watermark}"))),
                ),
              ),

              Positioned(top: 50,left: 0,right: 0,
                child: Center(child: Opacity(opacity: .25,
                    child: Column(
                      children: [
                        CustomImage(height: 70, image: "$imageUrl/${item?.headerLogo}"),
                        Text("exam_marksheet_of_student".tr,
                          style: textMedium.copyWith(
                            color: Colors.black,
                              fontSize: Dimensions.fontSizeLarge),)
                      ],
                    )),
                ),
              ),

              Positioned(bottom: 0,left: 0,right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(70),
                  child: Center(child: Opacity(opacity: .25,
                      child: Column(children: [
                        Row(spacing: Dimensions.paddingSizeDefault,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          CustomImage(width: 50, image: "$signatureImageUrl/${item?.signatureImage}"),
                          CustomImage(width: 50, image: "$signatureImageUrl/${item?.teacherSignatureImage}"),
                          CustomImage(width: 50, image: "$imageUrl/${item?.stampImage}"),
                        ]),
                        const SizedBox(height: 20)
                        ],
                      )),
                  ),
                ),
              ),


            ]),
          ],
        );
      }
    );
  }
}
