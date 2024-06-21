import 'package:get/get.dart';
import 'package:pranamas/screens/homepage.dart';
import 'package:pranamas/screens/register.dart';
import 'package:pranamas/screens/splash_screen.dart';

import '../screens/login_screen.dart';

class AppRoutes {
  static List<GetPage> route() => [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const RegisterScreen()),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
      ];
}
