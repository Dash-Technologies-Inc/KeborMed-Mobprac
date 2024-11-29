import 'package:get/get.dart';
import 'package:kebormed_mobile/ui/login_screen.dart';

class AppRoutes{
  static const login = '/login';

  static final routes = [
    GetPage(name: login, page: () => const LoginScreen()),
  ];

}