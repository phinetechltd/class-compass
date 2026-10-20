

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/model/question_category_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionCategoryDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<QuestionCategoryItem>? items ;
  final Function(QuestionCategoryItem?)? onChanged;
  final QuestionCategoryItem? selectedValue;
  const QuestionCategoryDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<QuestionCategoryDropdown> createState() => _QuestionCategoryDropdownState();
}

class _QuestionCategoryDropdownState extends State<QuestionCategoryDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<QuestionCategoryItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.name?? widget.title.tr,
          style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((QuestionCategoryItem item) => DropdownMenuItem<QuestionCategoryItem>(
            value: item, child: Text(item.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.items!.contains(widget.selectedValue)?  widget.selectedValue : null,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 40, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 40),
      ),
    );
  }
}
