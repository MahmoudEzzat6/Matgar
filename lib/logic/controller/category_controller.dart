import 'package:get/get.dart';
import 'package:getx_test/models/products_model.dart';

import '../../service/categorer_service.dart';

class CategoryController extends GetxController {
  var categoryNameList = <String>[].obs;
  var isLoading = false.obs;
  var isCatLoading = false.obs;

  var categoryList = <ProductsModels>[].obs;

  List<String> imageCategory = [
    "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
    "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
    "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
  ];

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  getCategories() async {
    var categories = await CategoryService.getCategory();
    try {
      isLoading(true);
      if (categories.isNotEmpty) {
        categoryNameList.addAll(categories);
      }
    } finally {
      isLoading(false);
    }
  }

  getAllCategories(var kind) async {
    isCatLoading(true);
    categoryList.value=
    (await CategoryData.getAllCategory(kind));
    isCatLoading(false);
  }

  getCategoryIndex(int index) async {
    var allCat = await getAllCategories(categoryNameList[index]);

    if (allCat != null) {
      categoryList.value = allCat;
    }
  }
}
