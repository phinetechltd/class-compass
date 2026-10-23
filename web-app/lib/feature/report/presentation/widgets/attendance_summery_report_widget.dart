import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:class_compass/feature/report/domain/model/chart_data.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AttendanceSummaryReportWidget extends StatefulWidget {
  const AttendanceSummaryReportWidget({super.key});

  @override
  AttendanceSummaryReportWidgetState createState() => AttendanceSummaryReportWidgetState();
}

class AttendanceSummaryReportWidgetState extends State<AttendanceSummaryReportWidget> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true, header: '', canShowMarker: false);
    Get.find<DashboardReportController>().getAttendanceSummaryData(Get.find<DashboardReportController>().selectedAttendanceType);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _iconTile(Icons.fact_check_rounded, AppColors.secondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("attendance_summary".tr,
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        const SizedBox(height: 2),
                        Text("Present and absent learners on the daily register",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 150,
                    child: CustomDropdown(
                      width: Get.width,
                      title: "select".tr,
                      items: reportController.attendanceTypeList,
                      selectedValue: reportController.selectedAttendanceType,
                      onChanged: (val) {
                        reportController.setSelectedAttendanceType(val!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: textRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.compact(),
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    majorGridLines: MajorGridLines(
                      color: AppColors.borderLight,
                      dashArray: const [4, 4],
                    ),
                    labelStyle: textRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  tooltipBehavior: _tooltip,
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    iconHeight: 10,
                    iconWidth: 10,
                  ),
                  series: <CartesianSeries<ChartData, String>>[
                    ColumnSeries<ChartData, String>(
                      name: "present".tr,
                      width: 0.3,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      dataSource: reportController.presentData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: AppColors.secondary,
                      dataLabelSettings: const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                    ColumnSeries<ChartData, String>(
                      name: "absent".tr,
                      width: 0.3,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      dataSource: reportController.absentData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: AppColors.error,
                      dataLabelSettings: const DataLabelSettings(isVisible: false),
                      enableTooltip: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _iconTile(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}
