import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_details_model.dart';


class StudentInfoWidgetFeesCollection extends StatelessWidget {
  const StudentInfoWidgetFeesCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<SmartCollectionController>(
      builder: (controller) {
        SmartCollectionDetailsModel? smartCollectionDetailsModel = controller.smartCollectionDetailsModel;
        Student? student = smartCollectionDetailsModel?.data?.studentSession?.student;
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomContainer(borderRadius: 5, showShadow: false,
              child: CustomImage(image: "${AppConstants.imageBaseUrl}/users/${student?.user?.image}", width: 120, height: 120,)),
          const SizedBox(width: Dimensions.paddingSizeDefault),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text('${"name".tr}: ${student?.firstName??''} ${student?.lastName??''}'),
            Text('${"registration_no".tr}: ${student?.registrationNo??''}'),
            Text('${"group".tr}: ${student?.studentGroup?.groupName??''}'),
            Text('${"fathers_name".tr}: ${student?.fatherName??''}'),
            Text('${"mothers_name".tr}: ${student?.motherName??''}'),
            Text('${"category".tr}: ${student?.studentCategory?.name??''}'),
            Text('${"phone".tr}: ${student?.phone??''}'),
          ],)
        ]);
      }
    );
  }
}
