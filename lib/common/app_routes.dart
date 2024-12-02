import 'package:get/get.dart';
import 'package:kebormed_mobile/ui/home_screen.dart';
import 'package:kebormed_mobile/ui/login_screen.dart';
import 'package:kebormed_mobile/ui/splash_screen.dart';

import '../ui/user_detail_screen.dart';

class AppRoutes{
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const userDetails = '/userDetails';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: userDetails, page: () => UserDetailScreen()),
  ];

}