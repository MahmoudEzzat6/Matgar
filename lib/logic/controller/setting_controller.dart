import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_test/constant/strings.dart';

class SettingController extends GetxController {

  var storage = GetStorage();
  var langLocal = english;

  @override
  void onInit() async {
    super.onInit();
    langLocal = await getLanguage;
    update();
Get.updateLocale(Locale(langLocal));

  }


  Future<void> saveLanguage(String lang) async {
    await storage.write('language', lang);
  }

  Future<String> get getLanguage async {
    return await storage.read('language');
  }

  void changeLanguage(String type) {
    saveLanguage(type);

    if (langLocal == type) {
      return;
    }
    if (type == arabic) {
      langLocal = arabic;
      saveLanguage(arabic);
    }
    langLocal=type;
    update();
  }

}
