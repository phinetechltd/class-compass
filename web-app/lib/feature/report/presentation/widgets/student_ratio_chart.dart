import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/report/domain/model/dashboard_report_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentRatioChartWidget extends StatefulWidget {
  const StudentRatioChartWidget({super.key});

  @override
  State<StudentRatioChartWidget> createState() => _StudentRatioChartWidgetState();
}

class _StudentRatioChartWidgetState extends State<StudentRatioChartWidget> {
  static const Color _maleColor = AppColors.secondary;
  static const Color _femaleColor = Color(0xFFF472B6);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (dashboardReportController) {
        DashboardReportModel? reportModel = dashboardReportController.dashboardReportModel;
        final info = reportModel?.data?.studentInfo;
        final int male = info?.totalMaleStudents ?? 0;
        final int female = info?.totalFemaleStudents ?? 0;
        final int total = male + female;
        final double malePercent = (info?.malePercentage ?? 0) / 100;
        final double femalePercent = (info?.femalePercentage ?? 0) / 100;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _maleColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    ),
                    child: const Icon(Icons.pie_chart_rounded, size: 20, color: _maleColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Students", style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        const SizedBox(height: 2),
                        Text(
                          "Total student gender distribution",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 86.0,
                      lineWidth: 14.0,
                      animation: true,
                      percent: malePercent.clamp(0.0, 1.0).toDouble(),
                      startAngle: 180,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: _maleColor,
                      backgroundColor: _maleColor.withValues(alpha: 0.12),
                    ),
                    CircularPercentIndicator(
                      radius: 62.0,
                      lineWidth: 14.0,
                      animation: true,
                      percent: femalePercent.clamp(0.0, 1.0).toDouble(),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: _femaleColor,
                      backgroundColor: _femaleColor.withValues(alpha: 0.12),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          total.toString(),
                          style: textBold.copyWith(fontSize: 26, height: 1),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'learners'.tr,
                          style: textMedium.copyWith(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: _legend(
                      label: 'Male',
                      value: male,
                      percent: malePercent,
                      color: _maleColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _legend(
                      label: 'Female',
                      value: female,
                      percent: femalePercent,
                      color: _femaleColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _legend({
    required String label,
    required int value,
    required double percent,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label,
                    style: textMedium.copyWith(
                        fontSize: 12, color: AppColors.textTertiary)),
                Text('$value',
                    style: textBold.copyWith(fontSize: 16, height: 1.2)),
              ],
            ),
          ),
          Text(
            '${(percent * 100).round()}%',
            style: textBold.copyWith(fontSize: 13, color: color),
          ),
        ],
      ),
    );
  }
}
