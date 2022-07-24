import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color mainColor = Color(0xfff0a70a);
const Color darkGreyClr = Color(0xFF121212);


class ThemesApp {
  static final light = ThemeData(
    appBarTheme:const AppBarTheme(
      backgroundColor: mainColor,
      elevation: 10,
    ),
    primaryColor: mainColor,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Colors.white),
    buttonTheme: const ButtonThemeData(buttonColor: mainColor),
    textSelectionTheme: const TextSelectionThemeData(selectionColor: mainColor)
  );

  static final dark = ThemeData(
    appBarTheme:const AppBarTheme(
        backgroundColor: darkGreyClr,
      elevation: 10,
    ),
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Colors.white),
  );

}
