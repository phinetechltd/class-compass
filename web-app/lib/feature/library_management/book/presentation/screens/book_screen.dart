
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/library_management/book/presentation/screens/add_new_book_screen.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_list_widget.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "books".tr),
    body: CustomWebScrollView(controller: scrollController, slivers: [

      SliverToBoxAdapter(child: BookListWidget(scrollController: scrollController,))
    ],),
      floatingActionButton: CustomFloatingButton(
          onTap: ()=> Get.dialog(const AddNewBookScreen())));
  }
}
