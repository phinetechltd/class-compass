import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/route_helper.dart';

class NotLoginWidget extends StatelessWidget {
  final VoidCallback? onLogin;
  const NotLoginWidget({super.key, this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 48, color: systemPrimaryColor()),
            const SizedBox(height: 20),
            Text('You are not logged in.\nPlease login to browse this feature.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),
            CustomButton(onTap: ()=> Get.toNamed(RouteHelper.getSignInRoute()), text: "login".tr)

          ],
        ),
      ),
    );
  }
}
