import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/theme_controller.dart';
import 'package:class_compass/common/model/messages.dart';
import 'package:class_compass/helper/di_container.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/localization/controller/localization_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:toastification/toastification.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isMobile) {
    HttpOverrides.global = MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await init();
  runApp(MyApp(languages: languages));
}




class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;

  const MyApp({super.key, required this.languages});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ToastificationWrapper(child: GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            }),

          navigatorKey: Get.key,
          theme: themeController.currentTheme,

          locale: localizeController.locale,
          translations: Messages(languages: widget.languages),

          fallbackLocale: Locale(
            AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),

          initialRoute: RouteHelper.getInitialRoute(),
          getPages: RouteHelper.routes,

          defaultTransition: GetPlatform.isMobile ? Transition.cupertino
              : Transition.noTransition,

          transitionDuration: const Duration(milliseconds: 500),

          builder: (context, child) {
            return SafeArea(top: false, child: child!);
            }),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
