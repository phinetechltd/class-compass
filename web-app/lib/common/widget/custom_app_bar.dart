import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/landing_page/presentation/widgets/logo_section_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CustomAppBar extends StatelessWidget  implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final IconData? backIcon;
  final double toolbarHeight;
  final bool showBakButton;
  final List<Widget>? actions;
  final Function()? onBackPress;
  const CustomAppBar({
    super.key, this.title, this.titleWidget, this.toolbarHeight = 63, this.showBakButton = true,
    this.onBackPress, this.actions, this.centerTitle = true, this.backIcon});

  @override
  Widget build(BuildContext context) {
    bool isRouteTreeEmpty = Navigator.of(context).canPop();
    return ResponsiveHelper.isDesktop(context)? const SizedBox() :
    Container(decoration: BoxDecoration(color: systemPrimaryColor()),

        child: AppBar(title: titleWidget?? Text(title??"",style: textMedium.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,color: Colors.white ),) ,
          leading: (showBakButton && isRouteTreeEmpty)?
          IconButton(onPressed: () => onBackPress != null ? onBackPress?.call() : Get.back(),
              icon: Icon(backIcon?? Icons.arrow_back, color: Colors.white)): const LogoSectionWidget(),
          leadingWidth: 150,

          actions: actions, centerTitle: centerTitle, backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, elevation: 0));
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
