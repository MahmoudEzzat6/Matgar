import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/models/products_model.dart';
import 'package:getx_test/view/widgets/details_widget/add_cart.dart';
import 'package:getx_test/view/widgets/details_widget/color_picker.dart';
import 'package:readmore/readmore.dart';

import '../../../logic/controller/cart_controller.dart';
import '../../../routes/routes.dart';
import 'image_slider.dart';

class DetailsScreen extends StatefulWidget {
  final ProductsModels models;
  const DetailsScreen({
    required this.models,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

int currentColor = 0;
final cartController = Get.find<CartController>();

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Color> selectedColor = [
      Colors.red,
      Colors.brown,
      Colors.blue,
      Colors.purple,
    ];
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0.0,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.cartScreen);
              },
              icon:Obx((){
                return  Badge(
                    position: BadgePosition.bottomStart(bottom: 12,start: 14),
                    badgeColor: Colors.red,
                    animationDuration: const Duration(microseconds: 3000),
                    animationType: BadgeAnimationType.slide,
                    badgeContent:  Text(
                      '${cartController.quantity()}',
                      style: const TextStyle(color: Colors.white,fontSize: 12),
                    ),
                    child: const Icon(Icons.shopping_cart));
              })
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Stack(children: [
                ImageSlider(
                  image: '${widget.models.image}',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentColor = index;
                              });
                            },
                            child: ColorPicker(
                                colors: selectedColor[index],
                                outerBorder: currentColor == index),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 5),
                        itemCount: selectedColor.length,
                      ),
                    ),
                  ],
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    '${widget.models.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: widget.models.rating!.rate,
                            ignoreGestures: true,
                            itemSize: 20,
                            updateOnDrag: false,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),

                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Price:',
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(' ${widget.models.price}\$',
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReadMoreText(
                    ' ${widget.models.description}',
                    trimLines: 5,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    style: const TextStyle(height: 1.5),
                    lessStyle:
                        const TextStyle(
                            fontWeight: FontWeight.bold,
                            color:mainColor,
                        ),
                    trimExpandedText: ' Show less',
                    moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                        fontSize: 16.0,height: 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              AddCart(models: widget.models),
            ],
          ),
        ),
      ),
    );
  }
}
