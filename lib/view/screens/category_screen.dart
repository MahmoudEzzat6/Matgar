import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/view/widgets/category_widget/category_items.dart';

import '../../logic/controller/category_controller.dart';
import '../widgets/components.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);
  final catController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (catController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
              color: Get.isDarkMode ? Colors.white : mainColor),
        );
      } else {
        return Scaffold(
          backgroundColor: context.theme.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => listDetails(index),
                separatorBuilder: (context, index) =>  SizedBox(child: divider()),
                itemCount: catController.categoryNameList.length,
              ),
            ),
          ),
        );
      }
    });
  }

  Widget listDetails(index) => InkWell(
    onTap: (){
      catController.getAllCategories(catController.categoryNameList[index]);
      Get.to(() => CategoryItems(categoryTitle: catController.categoryNameList[index],));
    },
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            Image(
                image: NetworkImage(catController.imageCategory[index]),
                height: 100,
                width: 60),
            const SizedBox(width: 15,),
            Text(
              catController.categoryNameList[index],
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
  );
}
