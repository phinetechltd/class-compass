import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel/presentation/widgets/select_hostel_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/presentation/widgets/select_hostel_category_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/domain/model/hostel_member_body.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/logic/hostel_members_controller.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/select_student_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewHostelMemberWidget extends StatefulWidget {
  final int? memberId;
  const AddNewHostelMemberWidget({super.key, this.memberId});

  @override
  State<AddNewHostelMemberWidget> createState() => _AddNewHostelMemberWidgetState();
}

class _AddNewHostelMemberWidgetState extends State<AddNewHostelMemberWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMembersController>(builder: (memberController) {
        return Column( spacing: Dimensions.paddingSizeDefault, children: [
           const Row(spacing: Dimensions.paddingSizeDefault, children: [

             Expanded(child: SelectClassWidget()),
             Expanded(child: SelectSectionWidget()),

           ]),
          const Row(spacing: Dimensions.paddingSizeDefault, children: [


            Expanded(child: SelectStudentWidget()),
            Expanded(child: SelectHostelCategoryWidget()),
            Expanded(child: SelectHostelWidget()),
          ]),

            const Row(spacing: Dimensions.paddingSizeDefault, children: [
              Expanded(child: DateSelectionWidget(title: "join_date")),
              Expanded(child: DateSelectionWidget(title: "leave_date", end: true)),
            ]),

            CustomButton(text: widget.memberId != null ? "update".tr : "add".tr,
              onTap: () => _submitForm(memberController)),
          ],
        );
      },
    );
  }

  void _submitForm(HostelMembersController memberController) {
    final studentController = Get.find<StudentController>();
    final hostelController = Get.find<HostelController>();
    final dateController = Get.find<DatePickerController>();


    if (studentController.selectedStudentItem == null) {
      showCustomSnackBar("select_student".tr);
    }
    
    else if (hostelController.selectedHostelItem == null) {
      showCustomSnackBar("select_hostel".tr);
    }


    HostelMemberBody memberBody = HostelMemberBody(
      studentId: studentController.selectedStudentItem!.id.toString(),
      hostelId: hostelController.selectedHostelItem!.id.toString(),
      hostelCategoryId: Get.find<HostelCategoriesController>().selectedCategoryItem!.id.toString(),
      joinDate: dateController.formatedDate,
      leaveDate: dateController.formatedEndDate.isEmpty ? null :
      dateController.formatedEndDate,

    );
    
    if (widget.memberId != null) {
      memberController.updateHostelMember(widget.memberId!, memberBody);
    } else {
      memberController.addNewHostelMember(memberBody);
    }
  }
}
