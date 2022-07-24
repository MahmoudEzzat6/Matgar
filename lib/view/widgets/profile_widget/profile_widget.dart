import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/auth_controller.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({Key? key}) : super(key: key);
  final controller = Get.find<AuthController>();
  final logcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            width: 150,
            height: 150,
           
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(85),color:Colors.grey, ),
            child: CachedNetworkImage(
              imageUrl: controller.displayPhoto.value,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.person,size: 70),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Center(
              child: Text(
            controller.displayName.value,
            style: const TextStyle(fontSize: 19),
          )),
          const SizedBox(
            height: 3,
          ),
          Center(
              child: Text(
            controller.displayEmail.value,
            style: TextStyle(fontSize: 12),
          )),
        ],
      );
    });
  }
}
