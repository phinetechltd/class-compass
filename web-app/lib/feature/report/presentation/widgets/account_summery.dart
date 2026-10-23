import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:class_compass/feature/report/domain/model/chart_data.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';

class DashboardAccountChartWidget extends StatefulWidget {
  const DashboardAccountChartWidget({super.key});
  @override
  DashboardAccountChartWidgetState createState() => DashboardAccountChartWidgetState();
}

class DashboardAccountChartWidgetState extends State<DashboardAccountChartWidget> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    Get.find<DashboardReportController>().getYearlyCashFlowData("${DateTime.now().year}", "3");
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(builder: (reportController) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: const Icon(Icons.insights_rounded, size: 20, color: AppColors.accentDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("income_and_expense_overview".tr,
                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const SizedBox(height: 2),
                    Text("track_the_institute".tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: AppColors.textTertiary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 260,
            child: SfCartesianChart(
              tooltipBehavior: _tooltip,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                labelStyle: textRegular.copyWith(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.compact(),
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                majorGridLines: const MajorGridLines(
                  color: AppColors.borderLight,
                  dashArray: [4, 4],
                ),
                labelStyle: textRegular.copyWith(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                iconHeight: 10,
                iconWidth: 10,
              ),
              series: <CartesianSeries<ChartData, String>>[
                SplineAreaSeries<ChartData, String>(
                  name: "total_income".tr,
                  dataSource: reportController.incomeData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: AppColors.accent.withValues(alpha: 0.22),
                  borderColor: AppColors.accent,
                  borderWidth: 3,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    color: AppColors.accent,
                  ),
                ),
                SplineAreaSeries<ChartData, String>(
                  name: "total_expense".tr,
                  dataSource: reportController.expenseData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  color: AppColors.error.withValues(alpha: 0.20),
                  borderColor: AppColors.error,
                  borderWidth: 3,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    });
  }
}
