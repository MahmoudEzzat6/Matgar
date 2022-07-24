import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/logic/controller/products_controller.dart';


class FavoritesScreen extends StatelessWidget {
  var controllers = Get.put(ProductsControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Obx(() {
        if (controllers.favouriteList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(image: AssetImage('assets/images/fav2.png'),height: 300),
                Text(
                  'No Favourite yet!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                )
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return buildFavItem(
                  image: controllers.favouriteList[index].image,
                  price: controllers.favouriteList[index].price,
                  title: controllers.favouriteList[index].title,
                  id: controllers.favouriteList[index].id,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                      color: Colors.blueGrey, indent: 12, endIndent: 12),
              itemCount: controllers.favouriteList.length,
            ),
          );
        }
      }),
    );
  }

  Widget buildFavItem({
    required String? image,
    required String? title,
    required double? price,
    required int id,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(image!),
            height: 80,
            width: 80,

          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                '$title',
                maxLines: 3,
                style: const TextStyle(fontSize:14,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w500, ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 70,),
            child: Text('$price\$',style: TextStyle(fontWeight: FontWeight.w900)),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 20),
            child: IconButton(
                onPressed: () {
                  controllers.controlFavourite(id);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 32,
                )),
          )
        ],
      ),
    );
  }
}
