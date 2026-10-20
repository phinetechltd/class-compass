import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class SelectedBookItemWidget extends StatelessWidget {
  final BookItem? bookItem;
  final int index;
  const SelectedBookItemWidget({super.key, this.bookItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing : Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(bookItem?.bookName??'',maxLines: 2, overflow: TextOverflow.ellipsis, style: textRegular.copyWith())),
      Expanded(child: Text(bookItem?.code??'', style: textRegular.copyWith())),
      Expanded(child: Text(bookItem?.author??'', style: textRegular.copyWith())),
      Expanded(child: Text(bookItem?.quantity?.toString()??'', style: textRegular.copyWith())),
       Expanded(child: Container(height: 30, decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(2),
           border: Border.all(width: .2, color: Theme.of(context).hintColor)),
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0),
             child: Row(children: [
                 Expanded(child: Text(bookItem?.returnDate??'', style: textRegular.copyWith())),
                 Icon(Icons.calendar_month, size: 15,color: Theme.of(context).hintColor)
               ]),
           ))),
      const SizedBox(width: Dimensions.paddingSizeDefault),

      InkWell(onTap: ()=> Get.find<BookController>().removeBook(index),
          child: SizedBox(width : 20, child: Image.asset(Images.deleteIcon)))

    ]): Row(children: [
      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      Expanded(child: Text(bookItem?.bookName??'', style: textRegular.copyWith())),
      const Expanded(child: CustomTextField(hintText: "20-10-2025")),
      SizedBox(width : 20, child: Image.asset(Images.deleteIcon))

    ]);
  }
}
