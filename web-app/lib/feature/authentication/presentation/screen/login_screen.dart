import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/authentication/presentation/widgets/animation_widget.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/feature/sidebar/controller/side_menu_bar_controller.dart';
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

  /// Demo logins published by the server for the demo school's domain only.
  List<_DemoAccount> _demoAccounts = [];
  int? _demoSelected;

  @override
  void initState() {
    super.initState();
    _loadDemoAccounts();

    if (Get.find<AuthenticationController>().isLoggedIn()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(RouteHelper.getDashboardRoute());
      });
    }

    // One-click demo login from the SaaS landing page: ?demo=1&token=...
    if (kIsWeb) {
      final params = Uri.parse(html.window.location.href).queryParameters;
      final token = params['token'];
      if (token != null && token.isNotEmpty && params['demo'] == '1') {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final ctrl = Get.find<AuthenticationController>();
          await ctrl.setUserToken(token);
          final api = Get.find<ApiClient>();
          api.updateHeader(token, null);
          final sideMenu = Get.find<SideMenuBarController>();
          sideMenu.toggleSideMenu(true);
          Get.offAllNamed(RouteHelper.getDashboardRoute());
        });
      }
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadDemoAccounts() async {
    try {
      final res = await Get.find<ApiClient>().getData(AppConstants.demoAccountsUri);
      final list = res.statusCode == 200 ? res.body?['data']?['accounts'] : null;
      if (list is List && mounted) {
        setState(() => _demoAccounts = list.whereType<Map>().map((m) => _DemoAccount(
            '${m['label'] ?? ''}', '${m['description'] ?? ''}', '${m['email'] ?? ''}', '${m['password'] ?? ''}')).where((a) => a.email.isNotEmpty).toList());
      }
    } catch (_) {}
  }

  void _useDemo(int i, AuthenticationController controller) {
    final a = _demoAccounts[i];
    setState(() => _demoSelected = i);
    userNameController.text = a.email;
    passwordController.text = a.password;
    // One-click: attempt login immediately after filling the demo credentials.
    login(controller);
  }

  Widget _demoPanel(AuthenticationController controller) {
    final primary = systemLandingPagePrimaryColor();
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primary.withValues(alpha: 0.25)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.play_circle_fill_rounded, color: primary, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text('Try a demo account', style: textHeavy.copyWith(fontSize: 15))),
        ]),
        const SizedBox(height: 4),
        Text('Pick a role to fill in its login, then press Login. Demo data resets every night.',
            style: textRegular.copyWith(fontSize: 12, color: Theme.of(context).hintColor)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (var i = 0; i < _demoAccounts.length; i++)
            Tooltip(message: _demoAccounts[i].description, child: ChoiceChip(
              label: Text(_demoAccounts[i].label),
              selected: _demoSelected == i,
              selectedColor: primary,
              backgroundColor: Theme.of(context).cardColor,
              checkmarkColor: Colors.white,
              side: BorderSide(color: primary.withValues(alpha: 0.6)),
              // Readable on the dark login card and on the light theme.
              labelStyle: textMedium.copyWith(fontSize: 13,
                  color: _demoSelected == i ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white),
              onSelected: (_) => _useDemo(i, controller),
            )),
        ]),
      ]),
    );
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

                    if (_demoAccounts.isNotEmpty) _demoPanel(authenticationController),
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
class _DemoAccount {
  final String label, description, email, password;
  _DemoAccount(this.label, this.description, this.email, this.password);
}
