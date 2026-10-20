import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:class_compass/helper/date_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class BookIssueReportItemWidget extends StatelessWidget {
  final BookIssueItem? bookIssueItem;
  final int index;
  const BookIssueReportItemWidget({super.key, this.bookIssueItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Column(
      children: [
        Row(spacing:Dimensions.paddingSizeSmall, children: [
          SizedBox(width: 20, child: Checkbox(value: bookIssueItem?.isSelected??false, onChanged: (val){
            Get.find<BookController>().toggleBookIssues(index);
          }),),

          Expanded(child: Text(bookIssueItem?.code??'', style: textRegular,)),
          Expanded(child: Text(bookIssueItem?.libraryId??'', style: textRegular,)),
          Expanded(child: Text(bookIssueItem?.bookName??'', style: textRegular,)),
          Expanded(child: Text(DateConverter.quotationDate(DateTime.parse(bookIssueItem?.updatedAt??'${DateTime.now()}')), style: textRegular,)),
          Expanded(child: Text(bookIssueItem?.issueDate??'', style: textRegular,)),
          Expanded(child: CustomTextField(
              inputType: TextInputType.number,
              inputFormatters: [AppConstants.numberFormat],
              controller: bookIssueItem?.fineController, hintText: "0")),

          Expanded(child: CustomTextField(
              inputType: TextInputType.number,
              inputFormatters: [AppConstants.numberFormat],
              controller: bookIssueItem?.lostController, hintText: "0")),

          Expanded(child: Text(bookIssueItem?.status??'', style: textRegular,)),




        ],),
        const CustomDivider(),
      ],
    ):
    CustomContainer(
      child: Column(spacing: Dimensions.paddingSizeSmall, children: [
        SizedBox(width: 20, child: Checkbox(value: false, onChanged: (val){}),),
        Text(bookIssueItem?.code??'', style: textRegular,),
        Text(bookIssueItem?.libraryId??'', style: textRegular,),
        Text(bookIssueItem?.bookName??'', style: textRegular,),
       Text(bookIssueItem?.issueDate??'', style: textRegular,),
       Text(bookIssueItem?.returnDate??'', style: textRegular,),
       Text(bookIssueItem?.status??'', style: textRegular,),
       Row(children: [
         Expanded(child: CustomTextField(
             inputType: TextInputType.number,
             inputFormatters: [AppConstants.numberFormat],
             controller: bookIssueItem?.fineController, hintText: "0")),

         Expanded(child: CustomTextField(
             inputType: TextInputType.number,
             inputFormatters: [AppConstants.numberFormat],
             controller: bookIssueItem?.lostController, hintText: "0")),

       ],)


      ],),
    );
  }
}
