import 'package:get/get.dart';
import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/language/english.dart';

import 'arabic.dart';

class LocalizationApp extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    english:en,
    arabic:ar,
  };
}