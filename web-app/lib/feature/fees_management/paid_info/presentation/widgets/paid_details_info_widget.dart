import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/paid_report_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class PaidDetailsInfoWidget extends StatelessWidget {
  final PaidReportInfo? info;

  const PaidDetailsInfoWidget({super.key, this.info});

  @override
  Widget build(BuildContext context) {
    final details = info?.details ?? [];

    if (details.isEmpty) {
      return const Center(child: Text("No Data"));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: details.length,
      itemBuilder: (_, index) {
        final data = details[index];
        final subHeads = data.feeHead?.feeSubHeads ?? [];

        return CustomContainer(
          child: Padding(padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(data.feeHead?.name ?? 'N/A',
                    style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,)),
                    Text(data.feeAndFinePaid ?? 'N/A',style: textMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge
                    )),
                  ]),

              const SizedBox(height: 8),

              if (subHeads.isNotEmpty)
                Column(children: List.generate(
                  subHeads.length, (i) {
                    final subHead = subHeads[i];
                    return Padding(padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(children: [
                        const Icon(Icons.circle, size: 6),
                        const SizedBox(width: 6),
                        Text(subHead.name ?? 'N/A'),
                      ]));
                    },
                ))
              else
                const Text("No Sub Heads"),
            ]),
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: Dimensions.paddingSizeSmall);
    },
    );
  }
}