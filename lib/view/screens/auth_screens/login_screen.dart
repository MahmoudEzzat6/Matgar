import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/auth_controller.dart';
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
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: mainColor,
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
                    isPassword: controllers.isShow ? false : true,
                    type: TextInputType.text,
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
                GetBuilder<AuthController>(builder: (_){
                  return  Row(
                    children: [
                      Checkbox(
                          value: controllers.checkBoxVis,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            controllers.checkBoxShow();
                            printInfo(info: 'clicked');
                          }),

                      const Text('Remember me'),
                      const SizedBox(width: 80.0,),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.forgotPasswordScreen);
                          },
                          child: const Text('Forget Password?')),

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
                          controllers.login(email: mailController.text.trim(), password: passwordController.text);

                        }
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                        style: TextStyle(color: Colors.black45)),
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
                Row(
                    children:[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: const Divider(
                          color: Colors.teal,
                          height: 40,
                        )),
                  ),
                  const Text('OR',style: TextStyle(color: Colors.teal)),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: const Divider(
                          color: Colors.teal,
                          height: 36,
                        )),
                  ),
                ]),
               GetBuilder<AuthController>(builder: (_) {
                 return  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     InkWell(
                       onTap: (){
                        print('clicked');
                       },
                       child: const Icon(
                         Icons.facebook,
                         color: Colors.blue,
                         size: 38,
                       ),
                     ),
                     //const Divider(color: Colors.black,height: 120,thickness: 12),
                     const SizedBox(
                       width: 25,
                     ),
                     InkWell(
                         onTap: (){
                           controllers.signByGoogle();
                         },
                         child: const Image(image: AssetImage('assets/images/google.png'),)
                     ),
                   ],
                 );
               },)
              ],
            ),

          ),
        ),
      ),
    );
  }
}
