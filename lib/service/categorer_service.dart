import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/models/products_model.dart';
import 'package:http/http.dart' as http;

import '../models/categories_model.dart';

class CategoryService {

  static Future<List<String>> getCategory() async {
    var response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      var data = response.body;
      return categoryModelFromJson(data);
    } else {
      return throw Exception('Failed to Load the Product');
    }
  }

}


class CategoryData {

  static Future<List<ProductsModels>> getAllCategory(String kind) async {
    var response = await http.get(Uri.parse('$baseUrl/products/category/$kind'));
    if (response.statusCode == 200) {
      var data = response.body;
      return productsModelsFromJson(data);
    } else {
      return throw Exception('Failed to Load the Product');
    }
  }

}

