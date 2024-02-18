import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/modules/successful_transaction/successful_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/logo_begining.dart';

class SuccessfulTransactionPage extends StatelessWidget {
  const SuccessfulTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<SuccessfulTransactionController>(
      builder: (_) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            BackgroundImage(),
            Container(
              padding: EdgeInsets.fromLTRB(
                  responsive.inchPercent(2),
                  responsive.inchPercent(10),
                  responsive.inchPercent(2),
                  responsive.inchPercent(5)),
              alignment: Alignment.bottomCenter,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const LogoBegining(widthLogo: 250),
                  SizedBox(
                    height: responsive.inchPercent(1),
                  ),
                  AutoSizeText(
                    'Transferencia exitosa',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 34.0,
                        color: Color(0xff50dcd4),
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  Text(
                    'Hash',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Color(0xff50dcd4),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: responsive.inchPercent(1),
                  ),
                  Obx((() => InkWell(
                        child: AutoSizeText(
                          _.hash.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Color(0xff50dcd4),
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        onTap: () {
                          _.goUrl(_.hash.value);
                        },
                      ))),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonPrimary(
                      status: true,
                      titleButton: 'Done'.tr,
                      fontSizeButton: 20.0,
                      callBack: () {
                        _.gohome();
                      },
                    ),
                  )),
                ],
              )),
            )
          ])),
    );
  }
}
