import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/view/widgets/details_widget/details_screen.dart';

import '../../../logic/controller/cart_controller.dart';
import '../../../logic/controller/products_controller.dart';

class ProductsWidget extends StatelessWidget {

  final productController = Get.find<ProductsControllers>();
  final cartController = Get.find<CartController>();

   ProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value) {
        return CircularProgressIndicator(
          color: Get.isDarkMode ? Colors.white : mainColor,
        );
      } else {
        return Expanded(
          child: productController.searchList.isEmpty &&
                  productController.searchController.text.isNotEmpty
              ?  Image.network('https://c.tenor.com/unvXyxtdn3oAAAAC/no-result.gif')
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: productController.searchList.isEmpty
                      ? productController.productList.length
                      : productController.searchList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 1.0,
                    mainAxisExtent: 285.0,
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (productController.searchList.isEmpty) {
                      return buildCardItem(
                        image: productController.productList[index].image,
                        price: productController.productList[index].price,
                        title: productController.productList[index].title,
                        id: productController.productList[index].id,
                        models: productController.productList[index],
                        onTap: () {
                          Get.to(
                            () => DetailsScreen(
                              models: productController.productList[index],
                            ),
                          );
                        },
                      );
                    } else {
                      return buildCardItem(
                        image: productController.searchList[index].image,
                        price: productController.searchList[index].price,
                        title: productController.searchList[index].title,
                        id: productController.searchList[index].id,
                        models: productController.searchList[index],
                        onTap: () {
                          Get.to(
                            () => DetailsScreen(
                              models: productController.searchList[index],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
        );
      }
    });
  }

  Widget buildCardItem({
    required String? image,
    required double? price,
    required String? title,
    required int? id,
    required var models,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(0.04)
                    : Colors.grey.withOpacity(0.08),
                spreadRadius: 3.0,
                blurRadius: 1.0,
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              productController.controlFavourite(id!);
                            },
                            icon: productController.changeFavourite(id!)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.grey.withOpacity(0.9),
                                  )),
                      ],
                    ),
                    const SizedBox(
                      width: 65,
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            cartController.addProductCart(models);
                            Get.snackbar('Cart', 'Added to cart',
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.blueGrey,
                                snackPosition: SnackPosition.BOTTOM);
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Stack(children: [
                Container(
                  width: double.infinity,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                        image: NetworkImage('$image'), fit: BoxFit.scaleDown),
                  ),
                ),
              ]),
              Column(
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 12),
                      child: Text(
                        '$title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 2.66,
                        left: 142.0,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 70.0,
                        ),
                        child: Text(
                          '$price\$',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        )),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
