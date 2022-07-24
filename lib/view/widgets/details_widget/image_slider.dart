import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'color_picker.dart';

class ImageSlider extends StatefulWidget {
  final String image;

  const ImageSlider({required this.image, Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;


  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
              height: 300.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(seconds: 5),
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 290),
          child: Center(
            child: AnimatedSmoothIndicator(
              count: 3,
              activeIndex: currentIndex,
              effect: SwapEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Get.isDarkMode ? Colors.white : mainColor,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
