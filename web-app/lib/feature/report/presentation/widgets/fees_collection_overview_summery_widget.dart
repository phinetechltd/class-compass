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
      format: 'point.x\n● Collected: \$point.y1\n● Outstanding: \$point.y2',
      textStyle: textRegular.copyWith(fontSize: 12),
    );
    Get.find<DashboardReportController>().getFeesCollectionData("${DateTime.now().year}");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("fees_collection_overview".tr,
                        style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                    const SizedBox(height: 4),
                    Text("track_collected_and_pending_fees_over_time".tr,
                        style: textRegular.copyWith(color: Colors.grey))]),
            ]),

          const SizedBox(height: 16),

            SizedBox(
              height: 250,
              child: SfCartesianChart(
                key: UniqueKey(),
                tooltipBehavior: _tooltip,
                primaryXAxis: const CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.compactCurrency(
                      symbol: "${Get.find<SystemSettingsController>().generalSettingModel?.data?.currencySymbol}"),
                  majorGridLines: MajorGridLines(
                    color: Theme.of(context).hintColor,
                    dashArray: const [4, 4],
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
                    dataSource: reportController.collectedData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Theme.of(context).primaryColor,
                    enableTooltip: true,
                  ),
                  StackedColumnSeries<ChartData, String>(
                    name: "outstanding",
                    width: 0.2,
                    borderRadius: const BorderRadius.vertical(top:Radius.circular(5)),
                    dataSource: reportController.outstandingData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Theme.of(context).cardColor,
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
