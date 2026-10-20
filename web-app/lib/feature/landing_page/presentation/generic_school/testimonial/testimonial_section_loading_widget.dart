import 'package:flutter/material.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class TestimonialSectionLoadingWidget extends StatelessWidget {
  const TestimonialSectionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: Dimensions.webMaxWidth,
      child: Center(child: SizedBox(height: 380,
          child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: _buildTestimonialCardShimmer(context, index),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCardShimmer(BuildContext context, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(width: 320, margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
        period: Duration(milliseconds: 1400 + (index * 200)),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4)),
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2)),
            ]),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _buildHeaderShimmer(),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              _buildContentShimmer(),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              _buildUserInfoShimmer(),
              ],
            ),
          ),

        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radiusDefault))),
      const Spacer(),
      Row(children: List.generate(5, (index) => Padding(padding: const EdgeInsets.only(right: 2),
        child: Container(width: 16, height: 16,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2))))),
        ),
      ],
    );
  }

  Widget _buildContentShimmer() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ...List.generate(4, (lineIndex) {
        double width;
        switch (lineIndex) {
          case 0:
            width = double.infinity;
            break;
            case 1:
              width = double.infinity;
              break;
            case 2:
              width = double.infinity * 0.9;
              break;
            case 3:
              width = double.infinity * 0.6;
              break;
            default:
              width = double.infinity;
          }

          return Padding(padding: const EdgeInsets.only(bottom: 8),
            child: Container(width: width, height: 16,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(6))),
          );
        }),
      ],
    );
  }

  Widget _buildUserInfoShimmer() {
    return Row(children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3),
              width: 2))),
        const SizedBox(width: Dimensions.paddingSizeDefault),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 140, height: 18,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6))),
            const SizedBox(height: 6),
            Container(width: 90, height: 14,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),),
            ],
          ),
        ),
      ],
    );
  }
}
