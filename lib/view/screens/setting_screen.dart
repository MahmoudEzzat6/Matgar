import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_test/constant/strings.dart';
import 'package:getx_test/constant/theme.dart';
import 'package:getx_test/logic/controller/main_controller.dart';
import 'package:getx_test/view/widgets/profile_widget/profile_widget.dart';

import '../../logic/controller/auth_controller.dart';
import '../../logic/controller/setting_controller.dart';
import '../widgets/components.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final controllers = Get.find<MainController>();

    final authcontrollers = Get.find<AuthController>();
    bool isSwitch = controllers.isDark;

    final controllerSetting = Get.put(SettingController());
    final controller = Get.find<SettingController>();
    final dir=controller.langLocal;
    return Directionality(
      textDirection: dir=='english'? TextDirection.ltr:TextDirection.rtl ,
      child: GetBuilder<MainController>(builder: (_) {
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.6,
                    height: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                   Text('Settings'.tr,
                       style: const TextStyle(
                           fontWeight: FontWeight.w300,
                           color: mainColor,
                           fontSize: 22)),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: isSwitch
                              ? Colors.white
                              : Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Dark Mode'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16)),
                        const Spacer(),
                        Switch(
                          value: isSwitch ? true : false,
                          activeColor: isSwitch ? Colors.white : Colors.black,
                          inactiveTrackColor: Colors.black,
                          activeTrackColor: Colors.white,
                          hoverColor: isSwitch ? Colors.white : Colors.black,
                          inactiveThumbColor: Colors.black54,
                          onChanged: (s) {
                            controllers.switchChange();
                            isSwitch = !isSwitch;
                          },
                        ),
                      ],
                    ),
                  ),
                  divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  GetBuilder<SettingController>(
                      init: SettingController(),
                      builder: (_) {
                        return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language_outlined,
                                  color: isSwitch
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('Language'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                const Spacer(),
                                Row(
                                  children: [
                                    DropdownButton<String>(
                                        items: [
                                          DropdownMenuItem(
                                              child: const Text('EN'),
                                              value: english),
                                          DropdownMenuItem(
                                              child: const Text("العربيه"),
                                              value: arabic),
                                        ],
                                        value: controller.langLocal,
                                        onChanged: (value) {
                                          Get.updateLocale(Locale(value!));
                                          controller.changeLanguage(value);
                                        }),
                                  ],
                                ),
                              ],
                            ));
                      }),
                  divider(),
                  GetBuilder<AuthController>(builder: (_) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            onConfirm: () {
                              authcontrollers.signOut();
                            },
                            textConfirm: 'yes',
                            title: 'LogOut?',
                            middleText: 'Are You Sure To LogOut?',
                            textCancel: 'No',
                            buttonColor: isSwitch ? Colors.white : mainColor,
                            cancelTextColor: mainColor,
                            confirmTextColor: isSwitch ? mainColor : Colors.white,
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.login_outlined,
                              color: isSwitch
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('LogOut'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16)),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
