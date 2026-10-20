import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_model.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/selected_book_item_widget.dart';

class SelectedBookListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SelectedBookListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(builder: (bookController) {
        return GenericListSection<BookItem>(
          showRouteSection: false,
          sectionTitle: "library_management".tr,
          headings: const ["name", "code", "writer", "quantity", "return_date"],

          scrollController: scrollController,
          isLoading: false,
          totalSize: 0,
          offset:0,
          onPaginate: (offset) async => {},
          items: bookController.selectedBookItems,
          itemBuilder: (item, index) => SelectedBookItemWidget(index: index, bookItem: item),
        );
      },
    );
  }
}
