import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:shimmer/shimmer.dart';

class TeacherLoadingWidget extends StatelessWidget {
  const TeacherLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor.withValues(alpha: .1),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).hintColor.withValues(alpha: .05),
          ],
        ),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
        child: Center(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("teachers".tr, style: textMedium.copyWith(color: systemLandingPagePrimaryColor(), fontSize: 20)),
                Text("meet_our_dedicated_and_experienced_teachers".tr,
                  textAlign: TextAlign.center,
                  style: textBold.copyWith(fontSize: 40, color: Theme.of(context).colorScheme.primary),
                ),
                Container(
                  height: 3,
                  width: 60,
                  decoration: BoxDecoration(
                    color: systemLandingPagePrimaryColor(),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                SizedBox(
                  height: 350,
                  child: Row(
                    spacing: Dimensions.paddingSizeDefault,
                    children: [
                      // Left arrow shimmer
                      Shimmer.fromColors(
                        baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).cardColor,
                          child: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
                        ),
                      ),

                      // Teacher cards
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 4,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              child: _buildTeacherCardShimmer(context, index),
                            );
                          },
                        ),
                      ),

                      // Right arrow shimmer
                      Shimmer.fromColors(
                        baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Theme.of(context).cardColor,
                          child: Icon(Icons.arrow_forward, color: Theme.of(context).hintColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeacherCardShimmer(BuildContext context, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: Duration(milliseconds: 1500 + (index * 200)), // Staggered animation
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Profile image shimmer
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(height: 16),

            // Name shimmer
            Container(
              width: 140,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 8),

            // Designation shimmer
            Container(
              width: 100,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
