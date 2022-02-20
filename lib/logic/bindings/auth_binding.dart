
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/auth_controller.dart';

class AuthBinding extends Bindings{

  @override
  void dependencies() {
    Get.put(AuthController());
  }

}