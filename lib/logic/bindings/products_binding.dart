import 'package:get/get.dart';
import 'package:getx_test/logic/controller/cart_controller.dart';
import 'package:getx_test/logic/controller/products_controller.dart';

import '../controller/category_controller.dart';

class ProductsBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(ProductsControllers());
  Get.lazyPut(() => CartController());
  Get.put(CategoryController());
  }

}