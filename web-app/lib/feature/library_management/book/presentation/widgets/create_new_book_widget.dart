import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/responsive_grid_widget.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_body.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_model.dart';
import 'package:class_compass/feature/library_management/book_category/controller/book_category_controller.dart';
import 'package:class_compass/feature/library_management/book_category/domain/model/book_category_model.dart';
import 'package:class_compass/feature/library_management/book_category/presentation/widgets/select_book_category_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewBookWidget extends StatefulWidget {
  final BookItem? bookItem;
  const CreateNewBookWidget({super.key, this.bookItem});

  @override
  State<CreateNewBookWidget> createState() => _CreateNewBookWidgetState();
}

class _CreateNewBookWidgetState extends State<CreateNewBookWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController copyController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController selfController = TextEditingController();
  TextEditingController rackController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.bookItem != null){
      update = true;
      nameController.text = widget.bookItem?.bookName??'';
      codeController.text = widget.bookItem?.code??'';
      authorController.text = widget.bookItem?.author??'';
      publisherController.text = widget.bookItem?.publisher??'';
      copyController.text = widget.bookItem?.bookCopyNo??'';
      providerController.text = widget.bookItem?.provider??'';
      selfController.text = widget.bookItem?.bookself??'';
      rackController.text = widget.bookItem?.rack??'';
      Get.find<BookCategoryController>().setSelectBookCategory(BookCategoryItem(
        id: int.parse(widget.bookItem?.category??''),
        categoryName: widget.bookItem?.category,
      ), notify: false);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: GetBuilder<BookController>(builder: (bookController) {
            return Column(mainAxisSize: MainAxisSize.min, children: [

              ResponsiveMasonryGrid(width: 300, children: [
                const SelectBookCategoryWidget(),
                CustomTextField(title: "name".tr,
                  controller: nameController,
                  hintText: "name".tr,),

                CustomTextField(
                  controller: codeController,
                  title: "code".tr,
                  hintText: "code".tr,
                ),

                CustomTextField(
                  controller: authorController,
                  title: "author".tr,
                  hintText: "author".tr,
                ),
                CustomTextField(
                  controller: publisherController,
                  title: "publisher".tr,
                  hintText: "publisher".tr,
                ),
                CustomTextField(
                  controller: copyController,
                  title: "book_copy_no".tr,
                  hintText: "book_copy_no".tr,
                ),
                CustomTextField(
                  controller: providerController,
                  title: "provider".tr,
                  hintText: "provider".tr,
                ),

                CustomTextField(
                  controller: selfController,
                  title: "book_self".tr,
                  hintText: "book_self".tr,
                ),

                CustomTextField(
                  controller: rackController,
                  title: "rack".tr,
                  hintText: "rack".tr,
                ),

              ]),



              bookController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    int? categoryId = Get.find<BookCategoryController>().selectedBookCategoryItem?.id;
                    String name = nameController.text.trim();
                    String code = codeController.text.trim();
                    String author = authorController.text.trim();
                    String publisher = publisherController.text.trim();
                    String copy = copyController.text.trim();
                    String provider = providerController.text.trim();
                    String self = selfController.text.trim();
                    String rack = rackController.text.trim();

                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }else{
                      BookBody body = BookBody(bookName: name,
                      code: code,
                      category: categoryId.toString(),
                      author: author,
                      publisher: publisher,
                      bookCopyNo: copy,
                      provider: provider,
                      bookself: self,
                      rack: rack,
                      method: update? "put" : "post");
                      if(update){
                        bookController.updateBook(body,  widget.bookItem!.id!);
                      }else{
                        bookController.addNewBook(body);
                      }
                    }
                  }, text: "confirm".tr))
            ],);
          }
      ),
    );
  }
}
