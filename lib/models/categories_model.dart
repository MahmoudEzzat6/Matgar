// To parse this JSON data, do
//
//     final categoriesModels = categoriesModelsFromJson(jsonString);

import 'dart:convert';

List<String> categoryModelFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String productsModelFromJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
