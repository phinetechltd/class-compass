import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_model.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/create_new_book_widget.dart';

class AddNewBookScreen extends StatefulWidget {
  final BookItem? bookItem;
  const AddNewBookScreen({super.key, this.bookItem});

  @override
  State<AddNewBookScreen> createState() => _AddNewBookScreenState();
}

class _AddNewBookScreenState extends State<AddNewBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_book".tr),
    body: CustomWebScrollView(slivers: [
      SliverToBoxAdapter(child: Column(children: [
        CreateNewBookWidget(bookItem: widget.bookItem)
      ]))
    ]),);
  }
}
