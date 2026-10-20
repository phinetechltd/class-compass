import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/domain/models/policy_model.dart';
import 'package:class_compass/feature/landing_page/logic/landing_page_controller.dart';
import 'package:class_compass/feature/landing_page/presentation/policy_enum.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:class_compass/common/layout/base_layout.dart';

class PolicyScreen extends StatefulWidget {
  final PolicyEnum policyType;
  const PolicyScreen({super.key, required this.policyType});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<LandingPageController>().getPolicy(widget.policyType);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      scrollController: _scrollController,
      child: GetBuilder<LandingPageController>(
        builder: (policyController) {
          PolicyModel? policyModel = widget.policyType == PolicyEnum.termsOfService
              ? policyController.termsPolicyModel
              : widget.policyType == PolicyEnum.privacyPolicy
              ? policyController.privacyPolicyModel
              : policyController.cookiePolicyModel;

          String? data = policyModel?.data?.description;

          if (data != null && data.isNotEmpty) {
            data = data.replaceAll('href=', 'target="_blank" href=');

            return SizedBox(
              width: Dimensions.webMaxWidth,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (ResponsiveHelper.isDesktop(context))
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeDefault),
                        child: Text(
                          widget.policyType == PolicyEnum.termsOfService
                              ? 'terms_and_conditions'.tr
                              : widget.policyType == PolicyEnum.privacyPolicy
                              ? 'privacy_policy'.tr
                              : 'cookie_policy'.tr,
                          style: textMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                      ),
                    Html(
                      data: data,
                      style: {"p": Style(fontSize: FontSize.medium)},
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
