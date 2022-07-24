import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_test/view/screens/category_screen.dart';
import 'package:getx_test/view/screens/favourite_screen.dart';
import 'package:getx_test/view/screens/home_screen.dart';
import 'package:getx_test/view/screens/setting_screen.dart';

class MainController extends GetxController{
  RxInt currentIndex=0.obs;

  final lists=[
    const HomeScreen(),
     CategoriesScreen(),
     FavoritesScreen(),
     const SettingScreen(),
  ].obs;

  bool isDark=Get.isDarkMode;
  void switchChange(){
    if(Get.isDarkMode==false){
      Get.changeThemeMode(ThemeMode.dark);
    }else{
      Get.changeThemeMode(ThemeMode.light);
    }
    isDark==!isDark;
    ThemeController().saveThemeDataInBox(!isDark);
    update();
  }
  ThemeMode get themeDataGet=>ThemeController().getThemeDataInBox()? ThemeMode.dark:ThemeMode.light;

}
class ThemeController{
  final String key='isDark';
  final GetStorage boxStorage=GetStorage();
  saveThemeDataInBox(bool isDark){
    boxStorage.write(key, isDark);
  }
  getThemeDataInBox(){
    return boxStorage.read<bool>(key)??false;

  }
}