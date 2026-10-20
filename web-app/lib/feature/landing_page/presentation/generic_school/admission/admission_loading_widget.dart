import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:shimmer/shimmer.dart';

class AdmissionWidgetLoadingWidget extends StatelessWidget {
  const AdmissionWidgetLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    /// Responsive breakpoints
    final bool isMobile = width < 650;
    final bool isTablet = width >= 650 && width < 1100;

    final content = _buildContent(context, isMobile);
    final image = _buildImageShimmer(context, isDark, isMobile);

    /// Mobile Layout (Vertical)
    if (isMobile) {
      return SingleChildScrollView(
        child: Column(
          children: [
            content,
            const SizedBox(height: 24),
            image,
          ],
        ),
      );
    }

    /// Tablet + Desktop Layout (Horizontal)
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: content),
        SizedBox(
          width: isTablet
              ? 40
              : Dimensions.paddingSizeExtraLarge,
        ),
        image,
      ],
    );
  }

  // ================= CONTENT =================

  Widget _buildContent(BuildContext context, bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "admissions".tr,
          style: textMedium.copyWith(
            color: systemLandingPagePrimaryColor(),
            fontSize: isMobile ? 16 : 20,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "ready_to_join_us".tr,
          textAlign: TextAlign.center,
          style: textBold.copyWith(
            fontSize: isMobile ? 24 : 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          height: 3,
          width: 60,
          decoration: BoxDecoration(
            color: systemLandingPagePrimaryColor(),
            borderRadius: BorderRadius.circular(50),
          ),
        ),

        const SizedBox(height: Dimensions.paddingSizeDefault),

        /// Admission Steps
        ...List.generate(
          3,
              (index) => Padding(
            padding: const EdgeInsets.only(
              bottom: Dimensions.paddingSizeDefault,
            ),
            child: _buildAdmissionStepShimmer(
              context,
              index,
              isMobile,
            ),
          ),
        ),
      ],
    );
  }

  // ================= IMAGE SHIMMER =================

  Widget _buildImageShimmer(
      BuildContext context, bool isDark, bool isMobile) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: const Duration(milliseconds: 2000),
      child: Container(
        width: isMobile ? double.infinity : 400,
        height: isMobile ? 220 : 400,
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
      ),
    );
  }

  // ================= STEP SHIMMER =================

  Widget _buildAdmissionStepShimmer(
      BuildContext context, int index, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      period: Duration(milliseconds: 1500 + (index * 300)),
      child: Container(
        width: isMobile ? double.infinity : width / 2.5,
        height: isMobile ? 70 : 80,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
            systemLandingPagePrimaryColor().withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Step Circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: systemLandingPagePrimaryColor()
                      .withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
            ),

            const SizedBox(width: 16),

            /// Text Lines
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),

            /// Arrow Placeholder
            Container(
              width: 24,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}