import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsService {

  static Future<List<ProductsModels>> getProducts() async {
    var response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      var data = response.body;
      return productsModelsFromJson(data);
    } else {
      return throw Exception('Failed to Load the Product');
    }
  }

}
