import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/routes/routes.dart';
import 'package:getx_test/view/screens/auth_screens/login_screen.dart';
import 'package:getx_test/view/screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: mainColor,
        ),
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: AppRoute.welcome,
      getPages: AppRoute.routes,
    );
  }
}
