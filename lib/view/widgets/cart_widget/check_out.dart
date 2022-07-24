import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/cart_controller.dart';

class CheckOut extends StatelessWidget {

  const CheckOut({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Obx((){
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Padding(
                  padding: EdgeInsets.only(top: 13, left: 12),
                  child: Text(
                    'Total',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 12),
                child: Text( '\$ ${controller.total}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offNamed('paymentScreen');
                    },
                    child:  const Text('Check Out',),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        primary: mainColor,
                    ),
                  )),
            ),
          ),
        ],
      );});
  }
}


