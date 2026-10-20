import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_body.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_selection_dropdown_widget.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/selected_book_list_widget.dart';
import 'package:class_compass/feature/library_management/library_member/controller/library_member_controller.dart';
import 'package:class_compass/feature/library_management/library_member/presentation/widgets/member_selection_dropdown_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class BookIssueWidget extends StatefulWidget {
  const BookIssueWidget({super.key});

  @override
  State<BookIssueWidget> createState() => _BookIssueWidgetState();
}

class _BookIssueWidgetState extends State<BookIssueWidget> {
  TextEditingController searchController = TextEditingController();
  TextEditingController searchMemberController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(builder: (bookController) {
        return GetBuilder<LibraryMemberController>(builder: (memberController) {
            return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor :
              Colors.transparent, showShadow: false,
                child: Column(children: [
                  SectionHeaderWithPath(sectionTitle: "library_management".tr, pathItems: ["book_issue".tr],),

                  const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: SelectBookDropdownWidget(),
                  ),

                   SelectedBookListWidget(scrollController: scrollController),


                  const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: SelectMemberDropdownWidget(),
                  ),

                  if(memberController.selectedMemberItem != null)
                  Row(children: [
                    CustomImage(width: 100, height:100,
                        image: "${AppConstants.imageBaseUrl}/users/${memberController.selectedMemberItem?.user?.image}"),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("${"id".tr} : ${memberController.selectedMemberItem?.libraryId}", style: textRegular),
                      Text("${"name".tr} : ${memberController.selectedMemberItem?.user?.name}", style: textRegular),
                      Text("${"occupation".tr} : ${memberController.selectedMemberItem?.memberType}",  style: textRegular),
                      Text("${"phone".tr} : ${memberController.selectedMemberItem?.user?.phone}",  style: textRegular),
                    ]))
                  ],),

                  Align(alignment: Alignment.centerRight, child: SizedBox(width: 120, child: CustomButton(onTap: (){
                    String? libraryId = memberController.selectedMemberItem?.libraryId;
                    if(bookController.selectedBookItems.isEmpty){
                      showCustomSnackBar("select_book_items".tr);
                    }else if(libraryId == null){
                      showCustomSnackBar("select_member".tr);
                    }else{
                      BookIssueBody body = BookIssueBody(
                       libraryId: libraryId,
                        bookIds: bookController.selectedBookItems.map((book) => book.id.toString()).toList(),
                        returnDates : bookController.selectedBookItems.map((book) => book.returnDate.toString()).toList(),
                      );
                      bookController.bookIssue(body);
                    }
                  }, text: "book_issue".tr)))

                ],),
              ),
            );
          }
        );
      }
    );
  }
}
