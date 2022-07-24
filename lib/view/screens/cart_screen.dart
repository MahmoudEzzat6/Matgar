import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/cart_controller.dart';
import '../widgets/cart_widget/check_out.dart';
import '../widgets/cart_widget/empty_cart.dart';
import '../widgets/cart_widget/not_empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: context.theme.backgroundColor,
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Get.isDarkMode ? Colors.white : Colors.black),
          title: Text(
            'My Shopping',
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              color: Colors.red,
              icon: const Icon(Icons.delete),
              onPressed: () {
                controller.deleteAllProductCart();
              },
            )
          ],
        ),
        body: Obx(() {
          if (controller.productMap.isEmpty) {
            return buildEmptyCart();
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 520,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return NotEmptyCart(
                          models: controller.productMap.keys.toList()[index],
                          index: index,
                          quantity:
                              controller.productMap.values.toList()[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 12);
                      },
                      itemCount: controller.productMap.length,
                    ),
                  ),
                  const CheckOut(),
                ],
              ),
            );
          }
        }));
  }
}
