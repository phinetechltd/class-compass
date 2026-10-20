
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:class_compass/common/widget/html_viewer.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class QuestionPaperItemWidget extends StatefulWidget {
  final QuestionItem? questionItem;
  final int index;
  const QuestionPaperItemWidget({super.key, this.questionItem, required this.index});

  @override
  State<QuestionPaperItemWidget> createState() => _QuestionPaperItemWidgetState();
}

class _QuestionPaperItemWidgetState extends State<QuestionPaperItemWidget> {

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text("${widget.index + 1}. ",
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),

            Expanded(child:  HtmlViewer(htmlText: widget.questionItem?.question??"")),
          ]),
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(spacing: Dimensions.paddingSizeDefault,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              if(widget.questionItem?.options != null && widget.questionItem?.options?.isNotEmpty == true)
                MasonryGridView.builder(

                    itemCount: widget.questionItem?.options?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index){
                      return Padding(padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall),
                        child: Text("${String.fromCharCode(65 + index)}.  "
                            "${widget.questionItem?.options?[index].toString()??''}",
                            style: textSemiBold),
                      );
                    }, gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),),
            ]),
          )
        ]),
      ],
      ),
    );
  }
}