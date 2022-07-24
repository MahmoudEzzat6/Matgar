import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import '../../../routes/routes.dart';
import '../components.dart';

  Widget buildEmptyCart () {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Image.network(
              ('https://media0.giphy.com/media/fscIxPfKjPyShbwUS5/giphy.gif?cid=6c09b952d1ac77bc1ce907714f44c994ca262d7d6e8c0fb0&rid=giphy.gif&ct=s')),
          const SizedBox(
            height: 10,
          ),
           const Text(
            'Your Shopping cart is empty.',
            style: TextStyle(fontSize: 16, color: Colors.grey,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          defaultButton(text: 'Go to Shopping',textColor: Colors.white,background: mainColor,width:180, onTap: () { Get.offNamed(Routes.mainScreen); })
        ],
      ),
    );
  }

