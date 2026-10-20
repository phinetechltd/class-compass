
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/controller/staff_attendance_controller.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/staff_attendance_body.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/user_model.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/widgets/add_new_staff_attendance_widget.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/widgets/staff_list_for_attendance_section.dart';
import 'package:class_compass/util/dimensions.dart';

class StaffAttendanceScreen extends StatefulWidget {
  const StaffAttendanceScreen({super.key});

  @override
  State<StaffAttendanceScreen> createState() => _StaffAttendanceScreenState();
}

class _StaffAttendanceScreenState extends State<StaffAttendanceScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "staff_attendance".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [

          SliverToBoxAdapter(child: Column(children: [
            const AddNewStaffAttendanceWidget(),
            const StaffListForAttendanceWidget(),


            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: GetBuilder<StaffAttendanceController>(
                builder: (attendanceController) {
                  UserModel? staffModel = attendanceController.userModel;
                  return (staffModel != null && staffModel.data != null && staffModel.data!.isNotEmpty)?
                    Align(alignment: Alignment.centerRight,
                      child: IntrinsicWidth(child: attendanceController.isLoading?
                      const Center(child: CircularProgressIndicator())
                      :CustomButton(onTap: (){

                        StaffAttendanceBody body = StaffAttendanceBody();
                        List<Attendance> attendanceList = [];
                        for(var staff in staffModel.data!){
                          if(staff.presentType != null){
                            Attendance attendance = Attendance(
                              userId: staff.id,
                              attendance: staff.presentType == "present"? 1 :
                              staff.presentType == "absent"? 2 : 3,
                              startTime: staff.checkIn,
                              endTime: staff.checkOut,
                                smsStatus: "0");
                            attendanceList.add(attendance);
                          }
                        }
                        body.attendance = attendanceList;
                        body.date = Get.find<DatePickerController>().formatedDate;
                        body.type = attendanceController.selectedStaffType;
                        body.smsStatus = 0;
                        attendanceController.createStaffAttendance(body);
                      }, text: "confirm".tr))) : const SizedBox();
                }
              ),
            )
          ]))
        ],),
    );
  }
}



