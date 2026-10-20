import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/level_filter_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/source_filter_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/sub_source_filter_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/tag_filter_widget.dart';
import 'package:class_compass/feature/question_bank/question/presentation/widgets/type_filter_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/styles.dart';
class QuestionBankLeftFilterMenu extends StatelessWidget {
  const QuestionBankLeftFilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return CustomContainer(horizontalPadding: 0,
        showShadow: false, borderRadius: 5, border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: .25)),
        child:isDesktop?
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Expanded(
            child: ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("type".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  TypeFilterWidget()
                ]),
          ),

          Expanded(
            child: ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("level".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  LevelFilterWidget()
                ]),
          ),


          Expanded(
            child: ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("source".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  SourceFilterWidget(),
                ]),
          ),

          Expanded(
            child: ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("sub_source".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  SubSourceFilterWidget()
                ]),
          ),

          Expanded(
            child: ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("tag".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  TagFilterWidget()
                ]),
          ),
        ]):
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          ExpansionTile(showTrailingIcon: false,
              title: Row(children: [
                Expanded(child: Text("type".tr, style: textRegular)),
                Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
              ]), children: const [
                TypeFilterWidget()
              ]),

           ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("level".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  LevelFilterWidget()
                ]),



          ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("source".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  SourceFilterWidget(),
                ]),


           ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("sub_source".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  SubSourceFilterWidget()
                ]),


           ExpansionTile(showTrailingIcon: false,
                title: Row(children: [
                  Expanded(child: Text("tag".tr, style: textRegular)),
                  Icon(Icons.keyboard_arrow_down, color: Theme.of(context).hintColor, size: 20)
                ]), children: const [
                  TagFilterWidget()
                ]),

        ])
    );
  }
}
