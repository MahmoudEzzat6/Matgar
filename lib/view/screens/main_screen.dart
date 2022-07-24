import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/main_controller.dart';
import 'package:getx_test/routes/routes.dart';

import '../../constant/theme.dart';
import '../../logic/controller/auth_controller.dart';
import '../../logic/controller/cart_controller.dart';

class MainScreen extends StatelessWidget {

  const MainScreen({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    final cartController = Get.find<CartController>();

    return Obx(
      () {
        return Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            title: const Text('Matgary'),
            leading: Container(),
            centerTitle: true,
            backgroundColor: Get.isDarkMode ? Colors.blueGrey : mainColor,
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.cartScreen);
                },
                icon:Obx((){
                  return  Badge(
                      position: BadgePosition.bottomStart(bottom: 12,start: 14),
                      badgeColor: Colors.red,
                      animationDuration: const Duration(microseconds: 3000),
                      animationType: BadgeAnimationType.slide,
                      badgeContent:  Text(
                        '${cartController.quantity()}',
                        style: const TextStyle(color: Colors.white,fontSize: 12),
                      ),
                      child: const Icon(Icons.shopping_cart));
                })
              ),
            ],
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: controller.currentIndex.value,
            showElevation: true,
            iconSize: 25,
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            items: [
              BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                activeColor: Colors.purple,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.category),
                title:  Text('Category'.tr),
                activeColor: Colors.pink,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.favorite_rounded),
                title: const Text('Favourite'),
                activeColor: Colors.red,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                activeColor: Colors.blue,
              ),
            ],
            onItemSelected: (int index) {
              controller.currentIndex.value = index;
            },
          ),
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: controller.lists,
          ),
        );
      },
    );
  }
}
