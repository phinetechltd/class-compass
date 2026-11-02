import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/report/domain/model/dashboard_report_model.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/styles.dart';

class SummeryNumberWidget extends StatelessWidget {
  const SummeryNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardReportController>(
      builder: (reportController) {
        DashboardReportModel? reportModel = reportController.dashboardReportModel;
        final data = reportModel?.data;

        final cards = <_KpiData>[
          _KpiData(
            title: 'total_admin',
            count: data?.admins ?? 0,
            icon: Icons.admin_panel_settings_rounded,
            colors: const [Color(0xFF1E293B), Color(0xFF0F172A)],
          ),
          _KpiData(
            title: 'total_students',
            count: data?.students ?? 0,
            icon: Icons.school_rounded,
            colors: const [Color(0xFF22D3EE), Color(0xFF0891B2)],
          ),
          _KpiData(
            title: 'total_teacher',
            count: data?.teachers ?? 0,
            icon: Icons.co_present_rounded,
            colors: const [Color(0xFF34D399), Color(0xFF059669)],
          ),
          _KpiData(
            title: 'total_staff',
            count: data?.staffs ?? 0,
            icon: Icons.badge_rounded,
            colors: const [Color(0xFFFBBF24), Color(0xFFD97706)],
          ),
        ];

        // Columns follow the space available (tablets get one row of four) and every card keeps
        // a fixed height, so cards never stretch into tall blocks.
        return LayoutBuilder(builder: (context, box) {
          final cols = box.maxWidth >= 680 ? 4 : 2;
          const spacing = 16.0;
          final cardWidth = (box.maxWidth - spacing * (cols - 1)) / cols;
          final cardHeight = ResponsiveHelper.isDesktop(context) ? 150.0 : 132.0;
          return GridView.count(
            crossAxisCount: cols,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
            childAspectRatio: cardWidth / cardHeight,
            children: cards.map((card) => _KpiCard(data: card)).toList(),
          );
        });
      },
    );
  }
}

class _KpiData {
  final String title;
  final int count;
  final IconData icon;
  final List<Color> colors;

  const _KpiData({
    required this.title,
    required this.count,
    required this.icon,
    required this.colors,
  });
}

class _KpiCard extends StatelessWidget {
  final _KpiData data;

  const _KpiCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: data.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppBorderRadius.xl),
        boxShadow: [
          BoxShadow(
            color: data.colors.last.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -22,
            top: -26,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    ),
                    child: Icon(data.icon, color: Colors.white, size: 20),
                  ),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 18,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.count.toString(),
                    style: textBold.copyWith(
                      fontSize: 30,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.title.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textMedium.copyWith(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
