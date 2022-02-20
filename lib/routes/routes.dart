import 'package:get/get.dart';
import 'package:getx_test/logic/bindings/auth_binding.dart';
import 'package:getx_test/view/screens/auth_screens/forget_pass_screens.dart';
import 'package:getx_test/view/screens/auth_screens/signup_screens.dart';
import 'package:getx_test/view/screens/main_screen.dart';
import 'package:getx_test/view/screens/welcome_screen.dart';

import '../view/screens/auth_screens/login_screen.dart';

class AppRoute {
  //initial Route
  static const welcome = Routes.welcomeScreen;

  //get page
  static final routes = [
    GetPage(name: Routes.welcomeScreen, page: () => const WelcomeScreen(),),
    GetPage(name: Routes.loginScreen, page: () => const LoginScreen(),binding: AuthBinding()),
    GetPage(name: Routes.signupScreen, page: () => const SignUpScreen(),binding: AuthBinding()),
    GetPage(name: Routes.forgotPasswordScreen, page: () => const ForgotPasswordScreen(),binding: AuthBinding()),
    GetPage(name: Routes.mainScreen, page: () => const MainScreen(),binding: AuthBinding()),
  ];
}

class Routes {
  static const welcomeScreen = "/welcomeScreen";
  static const loginScreen = "/loginScreen";
  static const signupScreen = "/signupScreen";
  static const forgotPasswordScreen = "/forgotPasswordScreen";
  static const mainScreen = "/mainScreen";
}
