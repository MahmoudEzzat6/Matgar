import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/auth_controller.dart';
import 'package:getx_test/logic/controller/main_controller.dart';
import 'package:getx_test/logic/controller/products_controller.dart';
import 'package:getx_test/view/widgets/components.dart';

import '../../../routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool iconShow = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mailController = TextEditingController();
    var passwordController = TextEditingController();
    final controllers = Get.find<AuthController>();
    final proControllers = Get.find<ProductsControllers>();
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Obx(() {
          if (proControllers.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(color: mainColor));
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/images/login.png',height: 120,width: 110,),

                    ],
                  ),
                  Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : mainColor,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    child: defaultTextField(
                        label: 'Email',
                        hintColor: Colors.white,
                        textColor:
                            Get.isDarkMode ? Colors.white : Colors.black,
                        iconColor: Colors.grey,
                        prefix: Icons.email_outlined,
                        validate: (value) {
                          if (!RegExp(validationEmail).hasMatch(value!) ||
                              value.toString().isEmpty) {
                            return 'not valid e-mail';
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.emailAddress,
                        controller: mailController),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GetBuilder<AuthController>(builder: (controller) {
                    return defaultTextField(
                      label: 'Password',
                      textColor:
                          Get.isDarkMode ? Colors.white : Colors.black,
                      isPassword: controllers.isShow ? false : true,
                      type: TextInputType.text,
                      iconColor: Colors.grey,
                      prefix: Icons.lock_outline_rounded,
                      validate: (value) {
                        if (value.toString().length < 6 ||
                            value.toString().isEmpty) {
                          return 'not valid password';
                        } else {
                          return null;
                        }
                      },
                      suffix: controllers.isShow
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                      suffixColor: mainColor,
                      suffixPress: () {
                        controllers.suffixShow();
                      },
                      controller: passwordController,
                    );
                  }),
                  GetBuilder<AuthController>(builder: (_) {
                    return Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                            value: controllers.checkBoxVis,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              controllers.checkBoxShow();
                            }),
                        const Text('Remember me'),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.forgotPasswordScreen);
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : mainColor),
                            )),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 45,
                    width: 280.0,
                    decoration: BoxDecoration(
                        color: mainColor,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: defaultButton(
                        text: 'Login',
                        textColor: Colors.white,
                        isUpper: true,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controllers.login(
                                email: mailController.text,
                                password: passwordController.text);
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: MainController().isDark
                                  ? Colors.white
                                  : Colors.black)),
                      const SizedBox(
                        width: 2.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAndToNamed(Routes.signupScreen);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: mainColor),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 20.0),
                          child: Divider(
                            color: MainController().isDark
                                ? Colors.white
                                : mainColor,
                            height: 40,
                          )),
                    ),
                    Text('OR',
                        style: TextStyle(
                            color: MainController().isDark
                                ? Colors.white
                                : mainColor)),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 10.0),
                          child: Divider(
                            color: MainController().isDark
                                ? Colors.white
                                : mainColor,
                            height: 36,
                          )),
                    ),
                  ]),
                  GetBuilder<AuthController>(
                    builder: (_) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 3,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                              ),
                              onPressed: (){
                                controllers.signByGoogle();
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: const [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/google.png'),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Sign In with Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              controllers.signByFacebook();
                            },
                            child:  Container(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                                ),
                                onPressed: (){
                                  controllers.signByFacebook();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: const [
                                  Icon(Icons.facebook),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Sign In with Facebook',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
