
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/global_api_response_model.dart';
import 'package:class_compass/feature/package_plan/controller/package_controller.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';
import 'package:class_compass/feature/package_plan/presentation/widgets/subscription_item.dart';
import 'package:class_compass/util/dimensions.dart';


class SubscriptionPackageWidget extends StatelessWidget {
  const SubscriptionPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        initState: (val) => Get.find<PackageController>().getPackageList(1),
        builder: (packageController) {
          ApiResponse<PackageItem>? package = packageController.packageModel;
          return package != null?
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(spacing:  Dimensions.paddingSizeDefault, children: [
              MasonryGridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: package.data?.data?.length??0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemBuilder: (context, index){
                    PackageItem? packageItem = package.data?.data?[index];
                    return SubscriptionItem(index: index, packageItem: packageItem);
                  }, gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400),),

            ],),
          ): const SizedBox();
        }
    );
  }
}
