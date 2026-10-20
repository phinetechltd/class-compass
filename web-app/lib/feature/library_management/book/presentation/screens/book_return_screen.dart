import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_return_body.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_return_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class BookReturnScreen extends StatefulWidget {
  const BookReturnScreen({super.key});

  @override
  State<BookReturnScreen> createState() => _BookReturnScreenState();
}

class _BookReturnScreenState extends State<BookReturnScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "book_return".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<BookController>(builder: (bookController) {
            return Column(spacing: Dimensions.paddingSizeDefault, children: [
                BookReturnWidget(scrollController: scrollController,),

                Align(alignment: Alignment.centerRight,
                  child: IntrinsicWidth(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: bookController.isLoading?
                          const Center(child: CircularProgressIndicator()):
                      CustomButton(text: "return_book".tr,
                        onTap: () {
                          final body = BookReturnBody(bookIssues: bookController.bookIssues);
                          if (bookController.bookIssues.isNotEmpty) {
                            bookController.bookReturn(body);
                          } else {
                            showCustomSnackBar("select_book".tr);
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ))
      ]));
  }
}
