import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_test/models/products_model.dart';
import 'package:getx_test/service/categorer_service.dart';
import 'package:getx_test/service/products_service.dart';

class ProductsControllers extends GetxController {
  var productList = <ProductsModels>[].obs;

  var favouriteList = <ProductsModels>[].obs;
  var isLoading = true.obs;
  var storage = GetStorage();

  var searchList = <ProductsModels>[].obs;
  TextEditingController searchController = TextEditingController();

  void onInit() {
    super.onInit();
    var storeData = storage.read<List>('isFavShop');
    if (storeData != null) {
      favouriteList =
          storeData.map((e) => ProductsModels.fromJson(e)).toList().obs;
    }
    getProducts();
  }

  getProducts() async {
    var products = await ProductsService.getProducts();
    try {
      isLoading(true);
      if (products.isNotEmpty) {
        productList.addAll(products);
      }
    } finally {
      isLoading(false);
    }
  }


  void controlFavourite(int id) async {
    var elementIndex = favouriteList.indexWhere((element) => element.id == id);

    if (elementIndex >= 0) {
      favouriteList.removeAt(elementIndex);
      await storage.remove('isFavShop');
      Get.snackbar('Favourite', 'Removed From Favourite',
          duration: const Duration(milliseconds: 1500),
          colorText: Colors.white,
          backgroundColor: Colors.red.shade400,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      favouriteList.add(productList.firstWhere((element) => element.id == id));
      await storage.write('isFavShop', favouriteList);
      //
      Get.snackbar('Favourite', 'Added toFavourite',
          duration: const Duration(milliseconds: 1500),
          colorText: Colors.white,
          backgroundColor: Colors.green.shade400,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool changeFavourite(int id) {
    return favouriteList.any((element) => element.id == id);
  }

  void addSearchText(String searchName) {
     searchName = searchName.toLowerCase();

     searchList.value = productList
        .where(
            (searchText) {
              var searchTitle=searchText.title!.toLowerCase();
              return searchTitle.contains(searchName);
            })
        .toList();

  update();
  }

  void searchClear() {
    searchController.clear();
    addSearchText('');
  }
}
