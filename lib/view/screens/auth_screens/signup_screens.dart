import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/auth_controller.dart';
import 'package:getx_test/routes/routes.dart';
import 'package:getx_test/view/widgets/components.dart';

import '../../../constant/strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  bool iconShow = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confPasswordController = TextEditingController();

    final controllers = Get.find<AuthController>();
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
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
                    'Sign Up',
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                defaultTextField(
                    label: 'User Name',
                    prefix: Icons.person_outline,
                    validate: (value) {
                      if (!RegExp(validationName).hasMatch(value!) ||
                          value.isEmpty) {
                        return 'invalid name';
                      } else {
                        return null;
                      }
                    },
                    type: TextInputType.name,
                    controller: nameController),
                const SizedBox(
                  height: 10.0,
                ),
                defaultTextField(
                    label: 'E-mail',
                    type: TextInputType.emailAddress,
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (value.toString().isEmpty ||
                          !RegExp(validationEmail).hasMatch(value!)) {
                        return 'invalid E-mail ';
                      } else {
                        return null;
                      }
                    },
                    controller: emailController),
                const SizedBox(
                  height: 10.0,
                ),
                GetBuilder<AuthController>(
                  builder: (GetxController controller) {
                    return defaultTextField(
                      label: 'Password',
                      isPassword: controllers.isShow ? false : true,
                      type: TextInputType.text,
                      controller: passwordController,
                      suffixPress: () {
                        controllers.suffixShow();
                      },
                      suffixColor: mainColor,
                      suffix: controllers.isShow
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                      prefix: Icons.lock_outline_rounded,
                      validate: (value) {
                        if (value.toString().length < 6 ||
                            value.toString().isEmpty) {
                          return 'invalid Password';
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                GetBuilder<AuthController>(
                  builder: (GetxController controller) {
                    return defaultTextField(
                      label: 'Confirm Password',
                      isPassword: controllers.isConfShow ? false : true,
                      type: TextInputType.text,
                      controller: confPasswordController,
                      suffixPress: () {
                        controllers.suffixConShow();
                      },
                      suffixColor: mainColor,
                      suffix: controllers.isConfShow
                          ? Icons.visibility
                          : Icons.visibility_off_outlined,
                      prefix: Icons.lock_outline_rounded,
                      validate: (value) {
                        if (value.toString().length < 6 ||
                            value.toString().isEmpty) {
                          return 'invalid Password';
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GetBuilder<AuthController>(
                      builder: (GetxController controller) {
                        return Checkbox(
                            value: controllers.checkBoxVis,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              controllers.checkBoxShow();
                            });
                      },
                    ),
                    const Text('I Accept '),
                    const Text('terms& condition',
                        style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                GetBuilder<AuthController>(
                  builder: (GetxController controller) {
                    return Container(
                      height: 45,
                      width: 280.0,
                      decoration: BoxDecoration(
                          color: mainColor,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: defaultButton(
                          text: 'Continue',
                          textColor: Colors.white,
                          isUpper: true,
                          onTap: () {
                            if(controllers.checkBoxVis==false){
                              snackBar(title: 'Terms& Condition', message:'should Accept in our terms& condition', color: Colors.red);
                            }else if(passwordController.text!=confPasswordController.text){
                              snackBar(title: 'Password Check', message:'The password not the same', color: Colors.red);
                            }else if (formKey.currentState!.validate()) {
                              controllers.signup(
                                  name: '',
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                              );
                              controllers.checkBoxVis=true;
                            }
                          }),
                    );
                  },
                ),
                const SizedBox(
                  height: 10.0,
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
                        Get.offAndToNamed(Routes.loginScreen);
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: mainColor),
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: const Divider(
                          color: Colors.teal,
                          height: 40,
                        )),
                  ),
                  const Text('OR', style: TextStyle(color: Colors.teal)),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: const Divider(
                          color: Colors.teal,
                          height: 36,
                        )),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
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
                        onTap: () {
                          print('clicked');
                        },
                        child: const Image(
                          image: AssetImage('assets/images/google.png'),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
