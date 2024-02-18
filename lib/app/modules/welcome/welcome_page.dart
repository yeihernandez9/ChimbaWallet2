import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/modules/welcome/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/functions/responsive.dart';
import '../../global_widgets/BackgroundImage.dart';
import '../../global_widgets/logo_begining.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<WelcomeController>(
      builder: (_) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(10),
                    responsive.inchPercent(2),
                    responsive.inchPercent(2)),
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const LogoBegining(widthLogo: 250),
                      SizedBox(
                        height: responsive.inchPercent(2),
                      ),
                      Text(
                        'all_Ready'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 34.0,
                            color: Color(0xff50dcd4),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: responsive.inchPercent(2),
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                              onTap: () {},
                              title: Text(
                                'Use biometric authentication'.tr,
                                style: const TextStyle(
                                    color: Color(0xff50dcd4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Obx(
                                () => Switch(
                                    inactiveThumbColor: const Color(0xff50dcd4),
                                    inactiveTrackColor:
                                        Color.fromARGB(255, 214, 240, 239),
                                    activeColor: const Color(0xff50dcd4),
                                    onChanged: (val) => _.toggle(),
                                    value: _.on.value),
                              )),
                        ],
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonPrimary(
                          status: _.enableBtn.value,
                          titleButton: 'Done'.tr,
                          fontSizeButton: 20.0,
                          callBack: () {
                            _.getHome();
                          },
                        ),
                      )),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
