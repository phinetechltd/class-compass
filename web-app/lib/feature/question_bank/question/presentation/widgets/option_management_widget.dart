import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/question_bank/question/logic/question_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class OptionManagementWidget extends StatefulWidget {
  const OptionManagementWidget({super.key});

  @override
  State<OptionManagementWidget> createState() => _OptionManagementWidgetState();
}

class _OptionManagementWidgetState extends State<OptionManagementWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(builder: (questionController) {
      int? selectedIndex = questionController.options.indexWhere((o) => o.isSelected);
      if (selectedIndex == -1) selectedIndex = null;

      return CustomContainer(showShadow: false,
        child: Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.paddingSizeSmall, children: [


          Row(children: [
            Expanded(child: Text("options".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
              CustomButton(width: 120, text: "add_options".tr,
                onTap: () => questionController.addOption())]),


            const SizedBox(height: Dimensions.paddingSizeDefault),
            ReorderableListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              buildDefaultDragHandles: false,
              itemCount: questionController.options.length,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex--;
                questionController.reorderOption(oldIndex, newIndex);
              },
              itemBuilder: (context, index) {
                final option = questionController.options[index];

                return Padding(key: ValueKey(option),
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Row(spacing: Dimensions.paddingSizeDefault, children: [

                      MouseRegion(cursor: SystemMouseCursors.move,
                        child: ReorderableDragStartListener(index: index,
                            child: const Icon(Icons.grid_view_rounded))),

                      Expanded(child: CustomTextField(
                        minLines: 1,
                        maxLines: 4,
                        inputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                        controller: option.controller,
                        hintText: "enter_option".tr)),


                      if (index != 0)
                        CustomContainer(showShadow: false, borderRadius: 5,
                          verticalPadding: 5, horizontalPadding: 5,
                          border: Border.all(color: Theme.of(context).colorScheme.error),
                          child: SizedBox(height: 20,
                            child: Image.asset(Images.deleteIcon, color: Colors.red)),
                              onTap: () => questionController.deleteOption(index)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            Text("correct_option".tr,
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),


          DropdownButtonFormField<int>(
            initialValue: selectedIndex,
            isExpanded: true,
            decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
              hint: Text("select_correct_option".tr),
              items: List.generate(questionController.options.length, (i) {
                final option = questionController.options[i];
                final text = option.controller.text.isEmpty
                    ? "${"option".tr} ${i + 1}" : option.controller.text;
                return DropdownMenuItem<int>(value: i,
                  child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis));
              }),
              onChanged: (value) {
                if (value != null) {
                  questionController.selectOption(value);
                }
              },
            ),
          ],
        ),
      );
    });
  }
}

