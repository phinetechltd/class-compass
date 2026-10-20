import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/bulk_import_students_dialog.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class StudentHeaderRouteSectionSection extends StatelessWidget {
  const StudentHeaderRouteSectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: CustomRoutePathWidget(title: "student_management".tr, subWidget: Row(spacing: Dimensions.paddingSizeDefault, children: [
          PathItemWidget(title: "students".tr),

          CustomContainer(
              onTap: ()=> Get.dialog(const BulkImportStudentsDialog()),
              color: Theme.of(context).cardColor,
              borderRadius: 5, horizontalPadding: 15,verticalPadding: 7,
              child: Text("import_students".tr)),

          // Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          //   child: CustomContainer(color: Theme.of(context).cardColor, borderRadius: 5, horizontalPadding: 15,verticalPadding: 7,
          //       child: Text("export_students".tr)),
          // ),


          CustomContainer(onTap: (){
            Get.toNamed(RouteHelper.getAddNewStudentRoute());
          }, color: systemPrimaryColor(),
              borderRadius: 5, horizontalPadding: 15,verticalPadding: 7,
              child: Text("add_new_student".tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white))),
        ])));
  }
}
