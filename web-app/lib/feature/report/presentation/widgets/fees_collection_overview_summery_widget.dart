import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:class_compass/feature/report/domain/model/chart_data.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FeesCollectionOverviewWidget extends StatefulWidget {
  const FeesCollectionOverviewWidget({super.key});

  @override
  FeesCollectionOverviewWidgetState createState() => FeesCollectionOverviewWidgetState();
}

class FeesCollectionOverviewWidgetState extends State<FeesCollectionOverviewWidget> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(
      enable: true,
      header: '',
      color: Colors.grey,
      canShowMarker: false,
      format: 'point.x\nCollected: \$point.y1\nOutstanding: \$point.y2',
      textStyle: textRegular.copyWith(fontSize: 12),
    );
    Get.find<DashboardReportController>().getFeesCollectionData("${DateTime.now().year}");
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    ),
                    child: const Icon(Icons.request_quote_rounded,
                        size: 20, color: AppColors.accentDark),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("fees_collection_overview".tr,
                            style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        const SizedBox(height: 2),
                        Text("track_collected_and_pending_fees_over_time".tr,
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
                height: 250,
                child: SfCartesianChart(
                  key: UniqueKey(),
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
                    numberFormat: NumberFormat.compactCurrency(
                        symbol: "${Get.find<SystemSettingsController>().generalSettingModel?.data?.currencySymbol}"),
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
                    StackedColumnSeries<ChartData, String>(
                      name: "collected".tr,
                      width: 0.2,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      dataSource: reportController.collectedData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: AppColors.accent,
                      enableTooltip: true,
                    ),
                    StackedColumnSeries<ChartData, String>(
                      name: "outstanding".tr,
                      width: 0.2,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      dataSource: reportController.outstandingData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: AppColors.warning,
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
}
