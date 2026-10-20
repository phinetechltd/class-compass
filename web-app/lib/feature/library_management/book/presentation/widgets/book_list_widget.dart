import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_model.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_item_widget.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/create_new_book_widget.dart';

class BookListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const BookListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      initState: (_) => Get.find<BookController>().getBookList(1),
      builder: (bookController) {
        final bookModel = bookController.bookModel;
        final bookData = bookModel?.data;
        return GenericListSection<BookItem>(
          sectionTitle: "library_management".tr,
          pathItems: ["book".tr],
          addNewTitle: "add_new_book".tr,
          onAddNewTap: ()=> Get.dialog(CustomDialogWidget(title: "book".tr,width: 900,
              child: const CreateNewBookWidget())),
          headings: const ["name", "category", "code", "author", "publisher", "book_copy_no", "provider", "book_self", "rack",],
          scrollController: scrollController ?? ScrollController(),
          isLoading: bookModel == null,
          totalSize: bookData?.total ?? 0,
          offset: bookData?.currentPage ?? 0,
          onPaginate: (offset) async => await bookController.getBookList(offset ?? 1),
          items: bookData?.data ?? [],
          itemBuilder: (item, index) => BookItemWidget(bookItem: item, index: index),
        );
      },
    );
  }
}
