import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:getx_test/models/products_model.dart';
import 'package:getx_test/view/widgets/details_widget/details_screen.dart';

import '../../../constant/theme.dart';
import '../../../logic/controller/cart_controller.dart';

class AddCart extends StatelessWidget {
  final ProductsModels models;
   AddCart({Key? key, required this.models}) : super(key: key);
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 60,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                cartController.addProductCart(models);
                Get.snackbar('Cart', 'Added to cart',
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.blueGrey,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Add to Cart',),
                  Icon(Icons.shopping_cart)
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                primary: mainColor,
              ),
            )),
      ],
    );
  }
}
