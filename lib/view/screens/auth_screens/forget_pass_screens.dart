import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/auth_controller.dart';

import '../../../constant/strings.dart';
import '../../widgets/components.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var formKey=GlobalKey<FormState>();
    var controllers=Get.find<AuthController>();
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forgot Password',
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Center(
                    child: Image(
                        image: AssetImage('assets/images/forgtPass.png'),
                        height: 300,
                        width: 250)),
                const Text('Forgot password, no problem Enter your Account here',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 15.0,
                ),
                defaultTextField(
                    label: 'E-mail ID',
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (!RegExp(validationEmail).hasMatch(value!) ||
                          value.toString().isEmpty) {
                        return 'not valid e-mail';
                      } else {
                        return null;
                      }
                    },
                    controller: emailController),
                const SizedBox(
                  height: 15.0,
                ),
                GetBuilder<AuthController>(builder: (_) {
                  return defaultButton(
                      background: mainColor,
                      text: 'Send',
                      textColor: Colors.white,
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          controllers.resetPassword(emailController.text.trim());
                        }});
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
