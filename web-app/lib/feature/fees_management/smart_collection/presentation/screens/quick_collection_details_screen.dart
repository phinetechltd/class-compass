import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/quick_collection_details_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class QuickCollectionDetailsScreen extends StatefulWidget {
  final String id;
  const QuickCollectionDetailsScreen({super.key, required this.id});

  @override
  State<QuickCollectionDetailsScreen> createState() => _QuickCollectionDetailsScreenState();
}

class _QuickCollectionDetailsScreenState extends State<QuickCollectionDetailsScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Get.find<SmartCollectionController>().getSmartCollectionDetails(int.parse(widget.id), 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "quick_collection_details".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Column(children: [
            SectionHeaderWithPath(sectionTitle: "fees_management".tr,
            pathItems: ["quick_collection_details".tr],),
            const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: QuickCollectionDetailsWidget()),
          ],
        ))
      ],),

    );
  }
}
