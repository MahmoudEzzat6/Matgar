import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/routes.dart';
import '../../view/widgets/components.dart';

class AuthController extends GetxController {
  bool isShow = false;
  bool isConfShow = false;
  bool checkBoxVis = false;
  String displayName = '';
  String displayImage = '';

  void suffixShow() {
    isShow = !isShow;
    update();
  }
  void suffixConShow() {
    isConfShow = !isConfShow;
    update();
  }

  void checkBoxShow() {
    checkBoxVis = !checkBoxVis;
    update();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  var google=GoogleSignIn();


  void signup(
      {
    required var name,
    required email,
    required password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        displayName = name;
        auth.currentUser!.updateDisplayName(displayName);
        update();
      });
      Get.offAndToNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (firerror) {
      if (firerror.code == 'weak-password') {
        snackBar(
            title: 'weak-password',
            message: 'The password provided is too weak.',
            color: Colors.red
        );
      } else if (firerror.code == 'email-already-in-use') {
        snackBar(
            title: 'Email Already in use',
            message: 'The account already exists for that email',color: Colors.red);
      }
    } catch (error) {
      snackBar(title: 'Error!', message: error.toString(),color: Colors.red);
    }
  }

  void login({required email, required password}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        auth.currentUser!.displayName;
      });
      update();
      Get.offAndToNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        snackBar(
            title: 'user not found', message: 'No user found for that email.',color: Colors.red);
      } else if (error.code == 'wrong-password') {
        snackBar(
            title: 'wrong Password',
            message: 'Wrong password provided for that user.',
            color: Colors.red
        );
      }
    }
  }

  void resetPassword(email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      Get.back();
      snackBar(
          title: 'Check Your E-mail',
          message: 'open the message in your e-mail to confirm',
          color: Colors.green,
          time: 5);
      update();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        snackBar(
            title: 'Wrong E-mail', message: 'E-mail Not found check it again!', color: Colors.red);
      }
    } catch (errorr) {
      snackBar(title: 'Internet Check', message: errorr.toString() , color: Colors.red);
    }
  }

  void signByGoogle() async{
    try {
      final GoogleSignInAccount? googleUser = await google.signIn();
      displayName = googleUser!.displayName!;
      displayImage = googleUser.photoUrl!;
      update();
      Get.offNamed(Routes.mainScreen);
      print(displayImage.toString());

    }catch(error){
      snackBar(title: 'SignIn Failed', message: error.toString(), color: Colors.red);
      print(error.toString());
    }
  }

  void signByFacebook() {}
}
