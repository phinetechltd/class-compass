import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/responsive_grid_widget.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/authentication/presentation/widgets/animation_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (AppConstants.demo) {
      userNameController.text = "superadmin@gmail.com";
      passwordController.text = "12345678";
    }

    if (Get.find<AuthenticationController>().isLoggedIn()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(RouteHelper.getDashboardRoute());
      });
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(AuthenticationController controller) {
    String username = userNameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty) {
      showCustomSnackBar("username_is_empty".tr);
      return;
    }

    if (!GetUtils.isEmail(username)) {
      showCustomSnackBar("username_is_invalid".tr);
      return;
    }

    if (password.isEmpty) {
      showCustomSnackBar("password_is_empty".tr);
      return;
    }

    if (controller.isActiveRememberMe) {
      controller.saveEmailAndPassword(username, password);
    }

    controller.login(username, password);
  }

  Widget demoButton({
    required AuthenticationController controller,
    required int index,
    required String email,
    required String role,
    required String text,
  }) {
    return Expanded(child: CustomButton(onTap: () {
          controller.setSelectedIndex(index);
          userNameController.text = email;
          passwordController.text = "12345678";
          controller.setUserType(role);
        },
        text: text,
        showBorderOnly: controller.selectedIndex != index,
        borderColor: systemPrimaryColor().withValues(alpha: .125),
        textColor: controller.selectedIndex == index ? Colors.white : Theme.of(context).textTheme.displayLarge!.color!,
        buttonColor: controller.selectedIndex == index ? systemPrimaryColor() : Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: Colors.black),

        const AnimatedParticleGrid(),

        GetBuilder<AuthenticationController>(builder: (authenticationController) {
          return Center(child: CustomContainer(horizontalPadding: 30, verticalPadding: 30,
            borderRadius: 20, color: ResponsiveHelper.isDesktop(context)
                ? Theme.of(context).cardColor : Colors.transparent,
            showShadow: ResponsiveHelper.isDesktop(context),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 400 : Get.width,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("login".tr, style: textHeavy.copyWith(fontSize: 40)),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Text("access_your_dashboard".tr, style: textMedium),
                const SizedBox(height: Dimensions.paddingSizeLarge),

                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    CustomTextField(controller: userNameController,
                      title: "email_address".tr,
                      hintText: "email_address".tr,
                      filled: true,
                      showBorder: false,
                      prefixIcon: Images.mailIconSvg,
                      prefixIconColor:
                      Theme.of(context).hintColor,
                      prefixIconSize: 16,
                      fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1)),


                    const SizedBox(height: Dimensions.paddingSize),

                    CustomTextField(
                      controller: passwordController,
                      title: "password".tr,
                      hintText: "password".tr,
                      filled: true,
                      showBorder: false,
                      isPassword: true,
                      prefixIcon: Images.lockIconSvg,
                      prefixIconSize: 20,
                      prefixIconColor: Theme.of(context).hintColor,
                      fillColor: Theme.of(context).hintColor.withValues(alpha: 0.1)),

                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    Row(children: [
                      Checkbox(value: authenticationController.isActiveRememberMe,
                        onChanged: (value) {
                        authenticationController.toggleRememberMe();
                        },
                        activeColor: systemLandingPagePrimaryColor(),
                        checkColor: Theme.of(context).cardColor,
                        side: BorderSide(color: Theme.of(context).hintColor, width: 2),),

                      Expanded(child: Text("remember_me".tr,
                          style: textMedium.copyWith(color: Theme.of(context).hintColor),)),

                      TextButton(onPressed: () {},
                        child: Text("forget_password".tr,
                          style: textRegular.copyWith(color:
                          systemLandingPagePrimaryColor())))
                    ]),

                    const SizedBox(height: 20),

                    authenticationController.isLoading ?
                    const Center(child: CircularProgressIndicator()) :
                    CustomButton(buttonColor: systemLandingPagePrimaryColor(),
                      onTap: () => login(authenticationController),
                      text: "login".tr, height: 45),

                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    if (AppConstants.demo) ...[
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: ResponsiveMasonryGrid(children: [
                          demoButton(controller: authenticationController,
                              index: 1,
                              email: "superadmin@gmail.com",
                              role: "superAdmin",
                              text: "super_admin".tr),

                          demoButton(controller: authenticationController,
                              index: 2,
                              email: "systemadmin@gmail.com",
                              role: "systemAdmin",
                              text: "system_admin".tr),

                          demoButton(controller: authenticationController,
                              index: 3,
                              email: "librarian@gmail.com",
                              role: "librarian",
                              text: "librarian".tr),

                          demoButton(controller: authenticationController,
                              index: 4,
                              email: "accountant@gmail.com",
                              role: "accounting",
                              text: "accounting".tr),
                          demoButton(controller: authenticationController,
                              index: 5,
                              email: "teacher1@gmail.com",
                              role: "teacher",
                              text: "teacher".tr),
                          demoButton(controller: authenticationController,
                              index: 6,
                              email: "parent@gmail.com",
                              role: "parent",
                              text: "login_as_a_parents".tr),

                          demoButton(controller: authenticationController,
                              index: 7,
                              email: "student@gmail.com",
                              role: "student",
                              text: "login_as_a_student".tr),

                        ]),
                      ),




                    ],
                  ])),
              ]),
            )));
            },
          ),
          Positioned(bottom: 10, right: 10,
            child: Text("${"app_version".tr}:- ${AppConstants.version}:${AppConstants.versionCode}",
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
          )
        ],
      ),
    );
  }
}