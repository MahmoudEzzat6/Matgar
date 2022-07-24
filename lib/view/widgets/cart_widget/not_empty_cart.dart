import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/models/products_model.dart';

import '../../../logic/controller/cart_controller.dart';

var controller = Get.find<CartController>();

class NotEmptyCart extends StatelessWidget {
  final ProductsModels models;
  final int index;
  final int quantity;

  const NotEmptyCart({Key? key, required this.models,required  this.index, required this.quantity,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 8),
                height: 90,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  image:
                  DecorationImage(image: NetworkImage('${models.image}')),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 12),
                      child: Text(
                        '${models.title}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12, top: 12),
                      child: Text(
                        '\$ ${controller.subTotal[index].toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.removeProductCart(models);
                          },
                          icon: Icon((Icons.indeterminate_check_box),
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                         Text('$quantity', style: const TextStyle(fontSize: 18)),
                        IconButton(
                          onPressed: () {
                            controller.addProductCart(models);
                          },
                          icon: Icon((Icons.add_box),
                              color: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                    ],
                ),
              ),
            ],
          ),
        )
      ],
    );

  }
}
