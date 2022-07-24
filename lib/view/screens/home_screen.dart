import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import '../widgets/home_widget/productShow.dart';
import '../widgets/home_widget/searchBar.dart';


class HomeScreen extends StatelessWidget {
   const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              decoration:  BoxDecoration(
                color: Get.isDarkMode ? Colors.blueGrey : mainColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  const [
                  Center(child: SearchScreenBar()),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Products',
                    //textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 3),
            ProductsWidget(),
          ],
        ),
      ),
    );
  }
}
