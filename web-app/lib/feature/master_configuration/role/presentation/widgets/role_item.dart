
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/theme_controller.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/master_configuration/role/domain/models/role_model.dart';
import 'package:class_compass/feature/master_configuration/role/presentation/screens/create_new_role_screen.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class RoleItemWidget extends StatelessWidget {
  final RoleItem? roleItem;
  final int index;
  const RoleItemWidget({super.key, this.roleItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    ExpansionTile(backgroundColor: Theme.of(context).cardColor,

      title: Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: Text("${roleItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        InkWell(onTap: (){
          Get.to(()=> CreateNewRoleScreen(roleItem: roleItem));
        },
            child: SizedBox(width: 15, child: Image.asset(Images.editIcon, color: Theme.of(context).hintColor))),
      ],
      ),
      children: [
        if(roleItem!.permissions != null && roleItem!.permissions!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(direction: Axis.horizontal, alignment : WrapAlignment.start,
              children: [for (int index =0; index < roleItem!.permissions!.length; index++)
                Padding(padding:  const EdgeInsets.symmetric(vertical: 5),
                  child: Container(decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: Get.find<ThemeController>().darkTheme? Colors.grey.withValues(alpha: 0.2): Theme.of(context).primaryColor.withValues(alpha: .1)),
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-3, horizontal: Dimensions.paddingSizeSmall),
                    margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.85),
                      child: Row(mainAxisSize:MainAxisSize.min,children: [
                        Flexible(child: Text(roleItem?.permissions?[index].name??'',
                            style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                            overflow: TextOverflow.ellipsis)),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
      ],):
    CustomContainer(horizontalPadding: 0, verticalPadding: 0,
        child: ExpansionTile(
          title: Row(children: [
              Expanded(child: Text("${roleItem?.name}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
              InkWell(onTap: (){
                Get.to(()=> CreateNewRoleScreen(roleItem: roleItem));
              },
                  child: SizedBox(width: 15, child: Image.asset(Images.editIcon))),
            ],
          ),
        children: [
          if(roleItem!.permissions != null && roleItem!.permissions!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(direction: Axis.horizontal, alignment : WrapAlignment.start,
              children: [for (int index =0; index < roleItem!.permissions!.length; index++)
                Padding(padding:  const EdgeInsets.symmetric(vertical: 5),
                  child: Container(decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: Get.find<ThemeController>().darkTheme? Colors.grey.withValues(alpha: 0.2): Theme.of(context).primaryColor.withValues(alpha: .1)),
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall-3, horizontal: Dimensions.paddingSizeSmall),
                    margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.85),
                      child: Row(mainAxisSize:MainAxisSize.min,children: [
                        Flexible(child: Text(roleItem?.permissions?[index].name??'',
                            style: textRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                            overflow: TextOverflow.ellipsis)),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],));
  }
}