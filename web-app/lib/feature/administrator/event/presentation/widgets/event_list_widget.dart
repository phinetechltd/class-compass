import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/administrator/event/controller/event_controller.dart';
import 'package:class_compass/feature/administrator/event/domain/models/event_model.dart';
import 'package:class_compass/feature/administrator/event/presentation/widgets/create_new_event_widget.dart';
import 'package:class_compass/feature/administrator/event/presentation/widgets/event_item_widget.dart';

class EventListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const EventListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      initState: (val) => Get.find<EventController>().getEventList(1),
      builder: (eventController) {
        final eventModel = eventController.eventModel;
        final eventData = eventModel?.data;

        return GenericListSection<EventItem>(
          sectionTitle: "administrator".tr,
          pathItems: ["event_list".tr],
          addNewTitle: "add".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "event".tr,
              child: const CreateNewEventWidget())),
          headings: const ["image","event", "description","location", "start_date", "end_date"],

          scrollController: scrollController,
          isLoading: eventModel == null,
          totalSize: eventData?.total ?? 0,
          offset: eventData?.currentPage ?? 0,
          onPaginate: (offset) async => await eventController.getEventList(offset ?? 1),

          items: eventData?.data ?? [],
          itemBuilder: (item, index) => EventItemWidget(index: index, eventItem: item),
        );
      },
    );
  }
}