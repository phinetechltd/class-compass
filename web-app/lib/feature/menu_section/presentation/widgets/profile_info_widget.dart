import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/feature/profile/domain/model/profile_model.dart';
import 'package:class_compass/feature/profile/presentation/screens/profile_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class ProfileInfoWidget extends StatelessWidget {
  final ProfileModel? profileModel;
  const ProfileInfoWidget({super.key, this.profileModel});

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
      child: CustomContainer(borderRadius: 5, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(decoration : BoxDecoration(borderRadius: BorderRadius.circular(120),
              color: Theme.of(context).primaryColor.withValues(alpha:.15),
              border: Border.all()),
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: ClipRRect(borderRadius: BorderRadius.circular(120),
                child: const CustomImage(width: 40, height: 40, localAsset: true, image: Images.profile)),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profileModel?.data?.name?.capitalize??'', style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
              InkWell(onTap: ()=> Get.to(()=> const ProfileScreen()),
                child: Row(children: [
                    Text("edit_profile".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall)),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Icon(Icons.arrow_forward_ios_rounded, size: 13, color: Theme.of(context).hintColor),
                  ],
                ),
              ),
            ],
          )),
          InkWell(onTap: ()=> Get.to(()=> const ProfileScreen()),
              child: SizedBox(width: 25, child: Image.asset(Images.editIcon, color: Get.isDarkMode? Colors.white : Colors.black))),
        ],),

        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeSmall),
          child: Row(children: [
            Expanded(child: Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(width: .15)),
                alignment: Alignment.center,

                child: Text(profileModel?.data?.phone??'', style: textMedium,))),
            //Text(profileModel?.data?.email??''),
          ],
          ),
        ),

      ])),
    );
  }
}
