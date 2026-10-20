import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/domain/model/question_bank_board_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/logic/question_bank_board_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankBoardWidget extends StatefulWidget {
  final QuestionBankBoardItem? item;
  const CreateNewQuestionBankBoardWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankBoardWidget> createState() => _CreateNewQuestionBankBoardWidgetState();
}

class _CreateNewQuestionBankBoardWidgetState extends State<CreateNewQuestionBankBoardWidget> {
  TextEditingController boardTextController = TextEditingController();
  TextEditingController boardShortNameTextController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      boardTextController.text = widget.item?.board??'';
      boardShortNameTextController.text = widget.item?.shortName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankBoardController>(
        builder: (boardController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_board".tr : "add_new_board".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "board".tr,
                controller: boardTextController,
                hintText: "enter_board".tr,),

              CustomTextField(title: "board_short_name".tr,
                controller: boardShortNameTextController,
                hintText: "enter_board_short_name".tr,),



              boardController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = boardTextController.text.trim();
                    String shortName = boardShortNameTextController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("board_is_empty".tr);
                    }
                    else if(shortName.isEmpty){
                      showCustomSnackBar("board_short_name_is_empty".tr);
                    }
                    else{
                      Get.back();
                      if(update){
                        boardController.editQuestionBankBoard(name, shortName, widget.item!.id!);
                      }else{
                        boardController.createQuestionBankBoard(name, shortName);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
