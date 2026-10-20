import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/model/question_bank_board_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionBankBoardDropdown extends StatefulWidget {
  final double? width;
  final bool border;
  final String title;
  final List<QuestionBankBoardItem>? items ;
  final Function(QuestionBankBoardItem?)? onChanged;
  final QuestionBankBoardItem? selectedValue;
  const QuestionBankBoardDropdown({super.key, this.width, this.border = false, required this.title, this.items, this.onChanged, this.selectedValue});

  @override
  State<QuestionBankBoardDropdown> createState() => _QuestionBankBoardDropdownState();
}

class _QuestionBankBoardDropdownState extends State<QuestionBankBoardDropdown> {


  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
      border: Border.all(width: .5, color: Theme.of(context).hintColor), ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: DropdownButton2<QuestionBankBoardItem>(
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(widget.selectedValue?.board?? widget.title.tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault),),
        items: widget.items != null?
        widget.items?.map((QuestionBankBoardItem item) => DropdownMenuItem<QuestionBankBoardItem>(
            value: item, child: Text(item.board??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))).toList():[],
        value: widget.items!.contains(widget.selectedValue)? widget.selectedValue : null,
        onChanged: widget.onChanged,
        buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero,
            height: 35, width: widget.width?? 100),
        menuItemStyleData: const MenuItemStyleData(height: 35),
      ),
    );
  }
}
