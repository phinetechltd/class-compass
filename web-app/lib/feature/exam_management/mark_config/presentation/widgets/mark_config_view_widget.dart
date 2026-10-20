import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/heading_menu_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/general_exam_model.dart';
import 'package:class_compass/feature/exam_management/mark_config/presentation/widgets/mark_config_view_search_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MarkConfigViewWidget extends StatefulWidget {
  final ScrollController scrollController;
  const MarkConfigViewWidget({super.key, required this.scrollController});

  @override
  State<MarkConfigViewWidget> createState() => _MarkConfigViewWidgetState();
}

class _MarkConfigViewWidgetState extends State<MarkConfigViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        final markViewModel = markConfigController.markViewModel;
        final markConfigList = markViewModel?.data?.markConfig ?? [];

        return Column(children: [
          const MarkConfigViewSearchWidget(),
          if (markConfigList.isNotEmpty)
            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: _buildGroupedSubjects(markConfigList))
            else const SizedBox(),
          ],
        );
      },
    );
  }


  Widget _buildGroupedSubjects(List<MarkConfig> markConfigList) {
    final Map<String, List<MarkConfigExamCodes>> grouped = {};
    for (var config in markConfigList) {
      final subjectName = config.subject?.subjectName ?? 'N/A';
      final examCodes = config.markConfigExamCodes ?? [];
      grouped.putIfAbsent(subjectName, () => []).addAll(examCodes);
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        final subjectName = entry.key;
        final codes = entry.value;

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Text(subjectName, style: textMedium.copyWith(fontWeight: FontWeight.bold))),
          const HeadingMenu(showActionOption: false, headings: ["short_code", "total_mark", "pass_mark", "accept_percent"]),
            ...codes.asMap().entries.map((e) {
              final idx = e.key + 1;
              final code = e.value;
              return Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                child: Row(spacing: Dimensions.paddingSizeDefault, children: [
                  NumberingWidget(index: idx),
                  Expanded(child: CustomItemTextWidget(text: code.title ?? "-")),
                  Expanded(child: CustomItemTextWidget(text: code.totalMarks ?? "0.00")),
                  Expanded(child: CustomItemTextWidget(text: code.passMark ?? "0.00")),
                  Expanded(child: CustomItemTextWidget(text: code.acceptance ?? "0.00")),
                  ],
                ),
              );
            }),
          ],
        );
      }).toList(),
    );
  }
}
