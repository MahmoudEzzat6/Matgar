import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/models/products_model.dart';

import '../../constant/theme.dart';

class CartController extends GetxController {
  var productMap = {}.obs;

  void addProductCart(ProductsModels models) {
    if (productMap.containsKey(models)) {
      productMap[models] += 1;
      //  print(productMap.entries.map((e) => e.key.price * e.value).toList());

      //   print( productMap.entries.map((e) =>e.key.price *e.value).toList().reduce((value,
      //element) => (value + element)).toStringAsFixed(2));
    } else {
      productMap[models] = 1;
      //  print(productMap.entries.map((e) => e.key.price *e.value).toList());
      //    print( productMap.entries.map((e) =>e.key.price *e.value).toList().reduce((value,
      //  element) => (value + element)).toStringAsFixed(2));

    }
  }

  void removeProductCart(ProductsModels models) {
    if (productMap.containsKey(models) && productMap[models] == 1) {
      productMap.removeWhere((key, value) => key == models);
    } else {
      productMap[models] -= 1;
    }
  }

  void deleteAllProductCart() {
    Get.defaultDialog(
      onConfirm: () {
        productMap.clear();
        Get.back();
      },
      textConfirm: 'yes',
      title: 'Delete?',
      middleText: 'Are You Sure To Delete your carts?',
      textCancel: 'No',
      buttonColor: Get.isDarkMode ? Colors.white : mainColor,
      cancelTextColor: mainColor,
      confirmTextColor: Get.isDarkMode ? mainColor : Colors.white,
    );
  }

  get subTotal => productMap.entries.map((e) => e.key.price * e.value).toList();

  get total => productMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => (value + element))
      .toStringAsFixed(2);

  int quantity() {
    if (productMap.isEmpty) {
      return 0;
    } else {
      return productMap.entries
          .map((e) => e.value)
          .toList()
          .reduce((value, element) => value + element);
    }
  }
}
