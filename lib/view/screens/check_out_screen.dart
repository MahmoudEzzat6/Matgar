import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/routes/routes.dart';
import 'package:getx_test/view/widgets/delivery_widget/payment.dart';

import '../../logic/controller/auth_controller.dart';
import '../../logic/controller/checkout_controller.dart';
import '../../logic/controller/payment_controller.dart';

class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final controller = Get.put(CheckOutController());
  int radioContinerIndex = 1;
  bool color = false;
  var authcontroller = Get.find<AuthController>();
  var paymentController = Get.find<PaymentController>();
  var paymentControllerr = Get.put(PaymentController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor:Get.isDarkMode?Colors.blueGrey :Colors.grey.withOpacity(0.04),
          elevation: 0,
          iconTheme: IconThemeData(
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        body: Obx(
          () {
            return Theme(
              data: ThemeData(
                  primarySwatch: Colors.orange,
                  colorScheme:  ColorScheme.light(primary: Colors.orange,background: Get.isDarkMode?Colors.grey:Colors.white)),
              child: Stepper(
                physics: const BouncingScrollPhysics(),
                elevation: 0,
                type: StepperType.horizontal,
                steps: buildStep(),
                currentStep: controller.currentSteps.value,
                onStepContinue: () {
                  if (controller.currentSteps.value == buildStep().length - 1) {
                   Get.offNamed(Routes.mainScreen);
                  } else {
                    controller.currentSteps.value++;
                  }
                },
                onStepCancel: () {
                  controller.currentSteps.value == 0
                      ? null
                      : controller.currentSteps.value--;
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: <Widget>[
                      if (controller.currentSteps.value != 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: mainColor,
                                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
                                  ),
                                  onPressed: details.onStepCancel,
                                  child: const Center(child: Icon(Icons.arrow_back_ios)),
                                ),
                              ),
                            ], //
                          ),
                        ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: mainColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
                            ),
                            onPressed: details.onStepContinue,
                            child: Icon(
                              controller.currentSteps.value ==
                                      buildStep().length - 1
                                  ? Icons.done_outline_outlined
                                  : Icons.arrow_forward_ios,

                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ));
  }

  List<Step> buildStep() {
    var phoneController = TextEditingController();
    return [
      Step(
          title: const Text('Shipping'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Shipping To',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return RadioShow(
                  title: 'Metro Station',
                  phone: paymentController.phoneNum.value,
                  address: 'Tahrer Station',
                  value: 1,
                  groupValue: radioContinerIndex,
                  color: color ? Colors.white : Colors.grey.shade300,
                  onChanged: (int? value) {
                    setState(() {
                      radioContinerIndex = value!;
                      color = !color;
                    });
                  },
                  icon: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Edit your Phone Number',
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: Colors.white,
                        textCancel: 'Cancel',
                        textConfirm: 'Confirm',
                        confirmTextColor: Colors.black,
                        cancelTextColor: Colors.black,
                        onConfirm: () {
                          Get.back();
                          paymentController.phoneNum.value =
                              phoneController.text;
                        },
                        buttonColor: mainColor,
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            maxLength: 11,
                            style: TextStyle(color: Colors.black),
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (phoneController.text.isEmpty) {
                                return 'can\'t be empty';
                              }
                            },
                            decoration:  InputDecoration(
                              label: Text('Add Phone',style: TextStyle(color: Colors.white)),
                              labelStyle:TextStyle(color: Colors.black) ,
                              floatingLabelStyle:
                                  TextStyle(color: Colors.black),
                              fillColor: Colors.grey.withOpacity(0.6),
                              filled: true,

                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:Get.isDarkMode?Colors.black: mainColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.phone,
                      size: 16,
                      color: Get.isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              RadioShow(
                title: 'Home',
                phone: paymentController.phoneNum.value,
                address: paymentController.address.value,
                value: 2,
                color: color ? Colors.grey.shade300 : Colors.white,
                onChanged: (int? value) {
                  setState(() {
                    radioContinerIndex = value!;
                    color = !color;
                    print(value);
                  });
                  paymentController.updatePosition();
                },
                groupValue: radioContinerIndex,
                icon: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Edit your Phone Number',
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.white,
                      textCancel: 'Cancel',
                      textConfirm: 'Confirm',
                      confirmTextColor: Colors.black,
                      cancelTextColor: Colors.black,
                      onConfirm: () {
                        Get.back();
                        paymentController.phoneNum.value = phoneController.text;
                      },
                      buttonColor: mainColor,
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLength: 11,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (phoneController.text.isEmpty) {
                              return 'can\'t be empty';
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text('Add Phone'),
                            floatingLabelStyle:
                                TextStyle(color: Colors.blueGrey),
                            fillColor: mainColor,
                            prefix: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.contact_mail_outlined,
                                  color: Colors.orange),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.phone,
                    size: 16,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          isActive: controller.currentSteps.value >= 0,
          state: controller.currentSteps.value > 0
              ? StepState.complete
              : StepState.editing),
      Step(
          title: const Text('Payment'),
          content: PaymentWidget(),
          isActive: controller.currentSteps.value >= 1,
          state: controller.currentSteps.value > 1
              ? StepState.complete
              : StepState.editing),
      Step(
          title: const Text('Finish Order'),
          content: Column(
            children: [
              const Text(' Thank You! ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              Image.network(
                  'https://cdn.dribbble.com/users/129972/screenshots/3964116/media/2dce85df72ed99399fc68d9bec519ce0.gif'),
              const Text('Every Thing was Done ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          isActive: controller.currentSteps.value >= 2,
          state: controller.currentSteps.value > 3
              ? StepState.complete
              : StepState.editing),
    ];
  }

  Widget RadioShow({
    required Color color,
    required int value,
    required int groupValue,
    required Function onChanged,
    required String title,
    required String phone,
    required String address,
    required Widget icon,
  }) {
    return Column(
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                )
              ]),
          child: Row(
            children: [
              Radio(
                activeColor: mainColor,
                value: value,
                groupValue: radioContinerIndex,
                onChanged: (int? value) {
                  onChanged(value);
                },
                fillColor:
                    MaterialStateColor.resolveWith((states) => mainColor),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'name: ${authcontroller.displayName}',
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          'phone: $phone',
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 90,
                        ),
                        SizedBox(
                          child: icon,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      'address: $address\n',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
