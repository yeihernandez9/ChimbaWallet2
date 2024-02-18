import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/logo_begining.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<LoginController>(
        builder: (_) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg-secondary.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(2),
                    responsive.inchPercent(2),
                    responsive.inchPercent(0)),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const LogoBegining(widthLogo: 250),
                    SizedBox(
                      height: responsive.heightPercent(15),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  0, 0, 0, responsive.inchPercent(3)),
                              alignment: Alignment.bottomCenter,
                              child: Obx(
                                () => TextFieldWidget(
                                    hideText: true,
                                    titleText: 'Password'.tr,
                                    onChanged: (value) {
                                      _.onchangePassword(value);
                                    },
                                    errorText: _.errorPassword.value == false
                                        ? 'Invalid password'.tr
                                        : null),
                              )),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: ButtonPrimary(
                                status: true,
                                titleButton: "Sign in".tr,
                                fontSizeButton: 20.0,
                                callBack: () {
                                  _.login();
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsive.inchPercent(2),
                    )
                  ],
                )),
              ),
            ));
  }
}
