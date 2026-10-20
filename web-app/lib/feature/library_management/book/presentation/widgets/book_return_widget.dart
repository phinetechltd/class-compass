import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_return_item_widget.dart';
import 'package:class_compass/feature/library_management/library_member/presentation/widgets/member_selection_dropdown_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class BookReturnWidget extends StatelessWidget {
  final ScrollController scrollController;
  const BookReturnWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      initState: (val)=> Get.find<BookController>().getIssuedBookList(1),
      builder: (bookController) {
        final bookIssueModel = bookController.bookIssueModel;
        final bookData = bookIssueModel?.data;

        return GenericListSection<BookIssueItem>(
          sectionTitle: "library_management".tr,
          showAction: false,
          pathItems: ["book_return".tr],
          topWidget: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end,spacing: Dimensions.paddingSizeSmall, children: [
              const Expanded(flex: 5, child: SelectMemberDropdownWidget()),
              Expanded(flex: 1, child: Padding(padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomButton(onTap: () => bookController.getIssuedBookList(1),
                      text: "search".tr)))]),
          ),
          headings: const ["code", "id", "name", "issue_date", "return_date", "fine", "lost",],

          scrollController: scrollController,
          isLoading: false,
          totalSize: bookData?.total ?? 0,
          offset: bookData?.currentPage ?? 0,
          onPaginate: (offset) async => await bookController.getIssuedBookList(offset ?? 1),
          items: bookData?.data ?? [],
          itemBuilder: (item, index) => BookReturnItemWidget(bookIssueItem: item, index: index),
        );
      },
    );
  }
}
