import 'package:flutter/material.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart' show Dimensions;
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class WhyChooseUsLoadingWidget extends StatelessWidget {
  const WhyChooseUsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      scrollDirection: ResponsiveHelper.isDesktop(context) ? Axis.horizontal : Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: ResponsiveHelper.isDesktop(context) ? 0 : 10,
          ),
          child: _buildFeatureCardShimmer(context, index),
        );
      },
    );
  }

  Widget _buildFeatureCardShimmer(BuildContext context, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: Duration(milliseconds: 1400 + (index * 200)), // Staggered animation
      child: Container(width: isDesktop ? 280 : Get.width * 0.85, height: 250,
        decoration: BoxDecoration(color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.21),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon shimmer
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.white.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Title shimmer
              Container(
                width: double.infinity,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              const SizedBox(height: 12),

              // Description lines shimmer
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: 150,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const Spacer(),

              // Action button shimmer
              Container(
                width: 120,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}