import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/common/app_dimens.dart';
import 'package:kebormed_mobile/common/app_routes.dart';
import '../common/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the login screen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.login);
    });

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: AppDimens.imageLogo,
          width: AppDimens.imageLogo,
          child: Image.asset(Images.appLogo),
        ),
      ),
    );
  }
}
