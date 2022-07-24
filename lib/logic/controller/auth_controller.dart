import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_test/models/facebook_model.dart';
import 'package:getx_test/models/regesterModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/googleModel.dart';
import '../../routes/routes.dart';
import '../../view/widgets/components.dart';

class AuthController extends GetxController {
  bool isShow = false;
  bool isConfShow = false;
  bool checkBoxVis = false;
  var displayName = ''.obs;
  var displayEmail = ''.obs;
  var displayPhoto = ''.obs;
  var displayId = ''.obs;
  bool isLogin=true;
  var loginLoading=true.obs;
  final GetStorage getStorage=GetStorage();

  FacebookModel? facebookModel;
  GoogleModel? googleModel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User ?get userProfile=>auth.currentUser;
  @override
  Future<void> onInit() async {
   displayName.value=(userProfile!=null?userProfile!.displayName: '')!;
   displayEmail.value=(userProfile!=null?userProfile!.email: '')!;
   displayPhoto.value=(userProfile!=null?userProfile!.photoURL: '')!;
     }

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
  var google = GoogleSignIn();

  void signup({
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
        auth.currentUser!.updateDisplayName(displayName.value);
        update();
      });
      var registerModel=RegisterModel(
        name: name ,
        email: email,
      );
      Future<void> users = FirebaseFirestore.instance
          .collection('users')
          .doc(registerModel.uid)
          .set(registerModel.toMap());
      displayName.value=name;
      displayEmail.value=email;
      update();
      Get.offAndToNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (firerror) {
      if (firerror.code == 'weak-password') {
        snackBar(
            title: 'weak-password',
            message: 'The password provided is too weak.',
            color: Colors.red);
      } else if (firerror.code == 'email-already-in-use') {
        snackBar(
            title: 'Email Already in use',
            message: 'The account already exists for that email',
            color: Colors.red);
      }
    } catch (error) {
      // snackBar(title: 'Error!', message: error.toString(), color: Colors.red);
    }
  }

  void login({required email, required password}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        auth.currentUser!.displayName;
      });
      isLogin;
      getStorage.write('auth', isLogin);
      update();
      Get.offAndToNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        snackBar(
            title: 'user not found',
            message: 'No user found for that email.',
            color: Colors.red);
      } else if (error.code == 'wrong-password') {
        snackBar(
            title: 'wrong Password',
            message: 'Wrong password provided for that user.',
            color: Colors.red);
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
            title: 'Wrong E-mail',
            message: 'E-mail Not found check it again!',
            color: Colors.red);
      }
    } catch (errorr) {
      snackBar(
          title: 'Internet Check',
          message: errorr.toString(),
          color: Colors.red);
    }
  }

  void signByGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await google.signIn();
      displayName.value=googleUser!.displayName!;
      displayPhoto.value=googleUser.photoUrl!;
      displayEmail.value=googleUser.email;

      if (googleUser == null) {
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      GoogleModel googleModel = GoogleModel(
        email: googleUser.email,
        name: googleUser.displayName!,
        image: googleUser.photoUrl,
        id: googleUser.id,
      );

      Future<void> users = FirebaseFirestore.instance
          .collection('users')
          .doc(googleUser.id)
          .set(googleModel.toMap());
      isLogin;
      getStorage.write('auth', isLogin);
      update();
      Get.offNamed(Routes.mainScreen);
    } catch (error) {
      snackBar(
          title: 'SignIn Failed', message: error.toString(), color: Colors.red);
    }
  }

  void signByFacebook() async {

    isLogin;
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      var accessToken = result.accessToken;
      AuthCredential credential =
          FacebookAuthProvider.credential(accessToken!.token);
      await auth.signInWithCredential(credential);
      final data = await FacebookAuth.instance.getUserData();

      facebookModel = FacebookModel.fromjson(data);

      Future<void> users = FirebaseFirestore.instance
          .collection('users')
          .doc(facebookModel!.id)
          .set(data);
      isLogin;
      getStorage.write('auth', isLogin);
      update();
      Get.offNamed(Routes.mainScreen);
    } else {
      snackBar(
          title: result.status.toString(),
          message: result.message.toString(),
          color: Colors.red);
    }
  }

  void signOut()async{
    try{
      await auth.signOut();
      await google.signOut();
      await FacebookAuth.instance.logOut();
      displayName=''.obs;
      displayId=''.obs;
      displayEmail=''.obs;
      displayPhoto=''.obs;
      Get.offAllNamed(Routes.loginScreen);
      isLogin=false;
      getStorage.remove('auth');
      update();

    }catch(error){
      snackBar(title: 'LogOut Failed', message: error.toString(), color: Colors.red);
    }
  }

}