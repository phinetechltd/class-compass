import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class ExamCreatedSuccessfullyDialog extends StatelessWidget {
  final String courseId;
  const ExamCreatedSuccessfullyDialog({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        child: SizedBox(width: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraLarge, horizontal: Dimensions.paddingSizeExtraLarge),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeExtraSmall, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const CustomImage(image: Images.examCreatedIcon, width: 50, localAsset: true),
            InkWell(onTap: ()=> Get.back(),
                child: const CustomImage(image: Images.close, width: 20, localAsset: true)),
          ]),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          Text("exam_created_successfully".tr, style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
          Text("${"exam".tr} ${"from".tr} ${"subject"} ${"has_been_created".tr}. ${"would_you_like_to_visit".tr}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.displaySmall?.color)),

          const SizedBox(height: Dimensions.paddingSizeDefault),
          Center(child: CustomButton(width: 250, onTap: (){
            Get.back();
            Get.toNamed(RouteHelper.getQuestionRoute("quiz", courseId: courseId));
          }, text: "select_from_question_bank".tr))
        ]),
      ),
    ));
  }
}
