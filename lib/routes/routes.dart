import 'package:get/get.dart';
import 'package:getx_test/logic/bindings/auth_binding.dart';
import 'package:getx_test/logic/bindings/products_binding.dart';
import 'package:getx_test/view/screens/auth_screens/forget_pass_screens.dart';
import 'package:getx_test/view/screens/auth_screens/signup_screens.dart';
import 'package:getx_test/view/screens/main_screen.dart';
import 'package:getx_test/view/screens/splash_screen.dart';
import 'package:getx_test/view/screens/welcome_screen.dart';
import '../logic/bindings/main_binding.dart';
import '../view/screens/auth_screens/login_screen.dart';
import '../view/screens/cart_screen.dart';
import '../view/screens/check_out_screen.dart';
import '../view/widgets/details_widget/details_screen.dart';

class AppRoute {
  //initial Route
  static const splash = Routes.splashScreen;

  static const main = Routes.mainScreen;

  //get page
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplachScreen(),
    ),

    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),),

    GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        binding: AuthBinding()),

    GetPage(
        name: Routes.signupScreen,
        page: () => const SignUpScreen(),
        binding: AuthBinding()),

    GetPage(
        name: Routes.forgotPasswordScreen,
        page: () => const ForgotPasswordScreen(),
        binding: AuthBinding()),

    GetPage(
        name: Routes.mainScreen,
        page: () => const MainScreen(),
        bindings: [
          AuthBinding(),
          MainBinding(),
          ProductsBinding(),
        ]),
    GetPage(
        name: Routes.cartScreen,
        page: () => const CartScreen(),
        bindings: [
          MainBinding(),
          ProductsBinding(),
        ]),
    GetPage(
        name: Routes.paymentScreen,
        page: () =>   CheckOutScreen(),
        bindings: [
          MainBinding(),
          ProductsBinding(),
        ]),
  ];
}

class Routes {
  static const splashScreen = "/splashScreen";
  static const welcomeScreen = "/welcomeScreen";
  static const loginScreen = "/loginScreen";
  static const signupScreen = "/signupScreen";
  static const forgotPasswordScreen = "/forgotPasswordScreen";
  static const mainScreen = "/mainScreen";
  static const cartScreen = "/cartScreen";
  static const detailsScreen = "/detailsScreen";
  static const paymentScreen = "/paymentScreen";
}
