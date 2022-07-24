import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/routes/routes.dart';

import '../widgets/components.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/hellow.gif'),
                const Center(
                  child: Text(
                    'Help you more\n anyThing, anyWhere, anyTime',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: defaultButton(
                      text: 'SIGN In',
                      textColor:Colors.white,
                      isUpper: true,
                      onTap: () {
                        Get.offAndToNamed(Routes.loginScreen);
                      }),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 55,
                  width:double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(50.0)
                  ),
                  child: defaultButton(
                      text: 'SIGN up',
                      textColor: Colors.white,
                      isUpper: true,
                      onTap: () {
                        Get.offAndToNamed(Routes.signupScreen);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
