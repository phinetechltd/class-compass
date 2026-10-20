import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/model/question_bank_board_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/logic/question_bank_board_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class BoardFilterWidget extends StatelessWidget {
  const BoardFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankBoardController>(
        builder: (boardController) {
          ApiResponse<QuestionBankBoardItem>? board = boardController.questionBankBoardModel;
          return (board != null && board.data?.data != null && board.data?.data?.isNotEmpty == true)?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: board.data?.data?.length,
              itemBuilder: (context, typeIndex){
                QuestionBankBoardItem? item = board.data?.data?[typeIndex];
                return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("${item?.shortName}", style: textRegular)),
                    Checkbox(value: item?.isSelected ?? false, onChanged: (val){
                      boardController.toggleSelected(typeIndex);
                    })
                  ]),
                );
              }):const SizedBox();
        }
    );
  }
}
