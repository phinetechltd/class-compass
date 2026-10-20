import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/report/domain/model/dashboard_report_model.dart';
import 'package:class_compass/util/images.dart';
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
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (dashboardReportController) {
        DashboardReportModel? reportModel = dashboardReportController.dashboardReportModel;
        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisSize: MainAxisSize.min,spacing: 3, children: [

            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Text("Students", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
              const SizedBox(height: 4),
              Text("Total Student Gender Distribution", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.grey),),
              const SizedBox(height: 16),
            ]),


              Center(
                child: Stack(alignment: Alignment.center, children: [
                  CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: (reportModel?.data?.studentInfo?.malePercentage??0)/100,
                    startAngle: 180,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Theme.of(context).primaryColor,
                  ),

                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: (reportModel?.data?.studentInfo?.femalePercentage??0)/100,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Theme.of(context).colorScheme.tertiaryContainer,
                  ),


                    const CustomImage(image: Images.gender,  width: 30, localAsset: true),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, spacing: 150,
                children: [
                  _buildLegend("Male", "${(reportModel?.data?.studentInfo?.totalMaleStudents??0)}", Theme.of(context).primaryColor),
                  _buildLegend("Female", "${(reportModel?.data?.studentInfo?.totalFemaleStudents??0)}", Theme.of(context).colorScheme.tertiaryContainer),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegend(String label, String value, Color color) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 6),
        Text(value, style: textMedium),
        Text(label, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.grey)),
      ],
    );
  }
}

