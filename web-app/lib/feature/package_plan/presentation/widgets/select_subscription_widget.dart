import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/package_plan/controller/package_controller.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';

class SelectPackageWidget extends StatefulWidget {
  const SelectPackageWidget({super.key});

  @override
  State<SelectPackageWidget> createState() => _SelectPackageWidgetState();
}

class _SelectPackageWidgetState extends State<SelectPackageWidget> {
  @override
  void initState() {
    super.initState();
    if (Get.find<PackageController>().packageModel == null) {
      Get.find<PackageController>().getPackageList(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: Dimensions.paddingSizeDefault),
        const CustomTitle(title: "package"),
        GetBuilder<PackageController>(builder: (packageController) {
            final packages = packageController.packageModel?.data?.data ?? [];

            packages.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final item = entry.value;
              return MapEntry(item, "$index. ${item.name ?? ''} - ${PriceConverter.convertPrice(context, item.price ?? 0)}",);
            }).toList();

            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomGenericDropdown<PackageItem>(title: "select_package",
                items: packages,
                selectedValue: packageController.selectedPackageItem,
                onChanged: (val) {
                  packageController.selectPackage(val!, packages.indexOf(val));
                },
                getLabel: (item) {
                  final index = packages.indexOf(item) + 1;
                  return "$index. ${item.name ?? ''} - ${PriceConverter.convertPrice(context, item.price ?? 0)}";
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
