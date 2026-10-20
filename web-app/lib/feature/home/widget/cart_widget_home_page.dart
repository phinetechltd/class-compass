import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';

class HeaderSectionWidget extends StatelessWidget {
  const HeaderSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(padding: const EdgeInsets.only(right: 12.0),
        child: IconButton(onPressed: () {Get.toNamed(RouteHelper.getProfileRoute());
        },
          icon: Image.asset(Images.profile, height: Dimensions.iconSizeDefault, width: Dimensions.iconSizeDefault, color : Colors.white),
        ),
      ),
    ],
    );
  }
}