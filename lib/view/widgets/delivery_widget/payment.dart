import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/view/widgets/components.dart';

import '../../../logic/controller/auth_controller.dart';
import '../../../logic/controller/cart_controller.dart';

class PaymentWidget extends StatefulWidget {
  PaymentWidget({Key? key}) : super(key: key);

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  int radioContinerIndex = 1;
  var controller = Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Payment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        BuildRadioPayment(),
      ],
    );
  }

  Widget BuildRadioPayment() {
    var fee=10;
    return Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.credit_card,
                        color: mainColor,
                        size: 28,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Visa',
                        style: TextStyle(fontSize: 18,color: Colors.grey),
                      )),
                  const Spacer(),
                  Radio(
                    value: 1,
                    groupValue: radioContinerIndex,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => mainColor),
                    onChanged: (int? value) {
                      setState(() {
                        radioContinerIndex = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.payments,
                        color: mainColor,
                        size: 28,
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cash',
                        style: TextStyle(fontSize: 18,color: Colors.grey),
                      )),
                  const Spacer(),
                  Radio(
                    value: 2,
                    groupValue: radioContinerIndex,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => mainColor),
                    onChanged: (int? value) {
                      setState(() {
                        radioContinerIndex = value!;
                      });
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text('Pay:  ${controller.total} \$',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            const SizedBox(height: 6),
             Center(
              child: Text('DeliveryFee: $fee\$ ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            divider(),
             Padding(
                padding: const EdgeInsets.only(top: 13, left: 12),
                child: Center(
                  child: Text(
                    'Total Payment: ${controller.total} + $fee \$ ',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
