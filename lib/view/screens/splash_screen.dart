
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_test/logic/controller/main_controller.dart';
import 'package:getx_test/view/screens/main_screen.dart';
import 'package:getx_test/view/screens/welcome_screen.dart';

import '../../logic/controller/auth_controller.dart';
import '../../logic/controller/cart_controller.dart';
import '../../routes/routes.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  var controller=Get.put(MainController());
  var cartcontroller=Get.put(CartController());
  var authcontroller=Get.put(AuthController());

  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 7600), (){
      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) =>  FirebaseAuth.instance.currentUser!=null||GetStorage().read('auth')==true?const MainScreen():const WelcomeScreen()),
              (route) => true);} );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode?Colors.black:Colors.white,
      body:  Center(
      child: Image.network(
          ('https://cliply.co/wp-content/uploads/2019/05/371905230_ECOMMERCE_400px.gif')),

    ),

    );
  }
}