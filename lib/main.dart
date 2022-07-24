import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/main_controller.dart';
import 'package:getx_test/routes/routes.dart';
import 'language/localization.dart';


///welcome+animation+darkMode-->Done
///LoginDarkMode=>Done
///splashScreen==>Done
///uploadGitHub


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemesApp.light,
      locale: Locale(GetStorage().read<String>('language').toString()),
      fallbackLocale: Locale(english),
      translations: LocalizationApp(),
      themeMode: MainController().themeDataGet,
      darkTheme: ThemesApp.dark,
      initialRoute: AppRoute.splash,
      getPages: AppRoute.routes,
    );
  }
}
