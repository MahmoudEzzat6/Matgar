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
      backgroundColor: mainColor,
      body: Center(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.circle,color: Colors.white,size: 100.0),
                  const Center(
                    child: Text(
                      'Help you more anything, anywhere, anytime',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 330.0,
                  ),
                  Container(
                    height: 45,
                    width: 280.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: defaultButton(
                        text: 'SIGN In',
                        textColor: mainColor,
                        isUpper: true,
                        onTap: () {
                          Get.offAndToNamed(Routes.loginScreen);
                        }),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 45,
                    width: 280.0,
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
      ),
    );
  }
}
