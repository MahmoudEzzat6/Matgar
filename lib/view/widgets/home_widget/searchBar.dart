import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/products_controller.dart';

import '../../../logic/controller/auth_controller.dart';

class SearchScreenBar extends StatefulWidget {
  const SearchScreenBar({Key? key}) : super(key: key);

  @override
  State<SearchScreenBar> createState() => _SearchScreenBarState();
}

class _SearchScreenBarState extends State<SearchScreenBar> {
  var controller = Get.find<ProductsControllers>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsControllers>(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hello,',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Text(' ${authController.displayName}',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 170,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    controller: controller.searchController,
                    showCursor: true,
                    onChanged: (searchName) {
                      controller.addSearchText(searchName);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: controller.searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                controller.searchClear();
                              },
                              icon: const Icon(Icons.clear),
                              color: Colors.black,
                            )
                          : null,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      //prefixIconColor: Get.isDarkMode ? Colors.black : mainColor,
                      hintText: 'Search Here',
                      hintStyle: const TextStyle(color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
