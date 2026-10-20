import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome header shimmer
          shimmerBox( 24,  220, baseColor, highlightColor),
          const SizedBox(height: 24),

          // Top stats cards shimmer
          LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width > 1000
                ? 4
                : width > 700
                ? 2
                : 1;

            return GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return shimmerCard(baseColor, highlightColor);
              },
            );
          }),

          const SizedBox(height: 24),

          // Attendance + Gender chart row
          LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isWide = width > 900;
            return Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: shimmerChart(baseColor, highlightColor)),
                const SizedBox(width: 16, height: 16),
                Expanded(
                    flex: 1,
                    child: shimmerCard(baseColor, highlightColor,
                        height: isWide ? 200 : 150)),
              ],
            );
          }),

          const SizedBox(height: 24),

          // Fees collection
          shimmerChart(baseColor, highlightColor),

          const SizedBox(height: 24),

          // Income and Expenses
          shimmerChart(baseColor, highlightColor, height: 220),
        ],
      ),
    );
  }

  // Helper shimmer box
  Widget shimmerBox(double height, double width, Color base, Color highlight) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Shimmer card skeleton
  Widget shimmerCard(Color base, Color highlight, {double height = 100}) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Shimmer chart skeleton
  Widget shimmerChart(Color base, Color highlight, {double height = 180}) {
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Container(
        height: height,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
