import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kebormed_mobile/common/app_dimens.dart';
import 'package:kebormed_mobile/common/app_routes.dart';
import '../common/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds before navigating to the Login screen
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
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
