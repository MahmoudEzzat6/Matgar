import 'package:get/get.dart';
import 'package:getx_test/logic/controller/category_controller.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CategoryController);
  }

}