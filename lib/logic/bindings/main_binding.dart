import 'package:get/get.dart';
import 'package:getx_test/logic/controller/main_controller.dart';

import '../controller/category_controller.dart';
import '../controller/payment_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
   Get.put(MainController());
   Get.lazyPut(() =>  MainController());
   Get.put(CategoryController());
   Get.put(PaymentController());

}
}