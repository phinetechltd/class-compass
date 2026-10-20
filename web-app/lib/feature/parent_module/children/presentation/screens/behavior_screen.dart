import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/parent_module/children/controller/children_controller.dart';
import 'package:class_compass/feature/parent_module/children/domain/model/behavior_model.dart';
import 'package:class_compass/feature/parent_module/children/presentation/widgets/behaviour_item_widget.dart';

class BehaviourScreen extends StatelessWidget {
  const BehaviourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(appBar: CustomAppBar(title: "behaviour".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: GetBuilder<ChildrenController>(initState: (_) =>
              Get.find<ChildrenController>().getChildrenBehaviors(1),
            builder: (behaviorController) {
            final behaviorModel = behaviorController.behaviorsModel;
            final behaviours = behaviorModel?.data?.data ?? [];

            return GenericListSection<BehaviorItem>(
              sectionTitle: "behaviour".tr,
              showAction: false,
              headings: const ["title", "remarks"],

              scrollController: scrollController,
              isLoading: behaviorModel == null,
              totalSize: behaviorModel?.data?.total ?? 0,
              offset: behaviorModel?.data?.currentPage ?? 0,

              onPaginate: (offset) async {
                await behaviorController.getChildrenBehaviors(offset ?? 1);
                },

              items: behaviours,
              itemBuilder: (item, index) => BehaviourItemWidget(index: index,
                  behaviorItem: item));
              },
            ),
          ),
        ],
      ),
    );
  }
}
