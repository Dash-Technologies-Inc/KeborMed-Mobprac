import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/common/app_routes.dart';
import 'package:kebormed_mobile/common/app_theme.dart';
import 'package:kebormed_mobile/common/constants.dart';
import 'package:kebormed_mobile/common/labels.dart';
import 'package:kebormed_mobile/ui/splash_screen.dart';
import 'package:kebormed_mobile/utils/session/preference.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().init();
  Transition transition = Transition.rightToLeft;
  Duration transitionDuration = const Duration(milliseconds: AppConstants.pageTransitionTime);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: Labels.appName,
          theme: AppTheme.lightTheme,
          home: const SplashScreen(),
          getPages: AppRoutes.routes,
          defaultTransition: transition,
          transitionDuration: transitionDuration),
    );
  });
}

