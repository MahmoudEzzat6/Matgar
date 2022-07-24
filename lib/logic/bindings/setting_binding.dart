import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController());
  }

}