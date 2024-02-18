import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/logo_begining.dart';
import 'package:chimba_wallet/app/modules/beginning/beginning_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/BackgroundImage.dart';

class BeginningPage extends StatelessWidget {
  const BeginningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<BeginningController>(
      builder: (_) => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(''),
            iconTheme: const IconThemeData(
              color: Colors.white, // <-- SEE HERE
            ),
          ),
          body: Stack(children: [
            BackgroundImage(),
            Container(
              padding: EdgeInsets.fromLTRB(
                  responsive.inchPercent(2),
                  responsive.inchPercent(2),
                  responsive.inchPercent(2),
                  responsive.inchPercent(2)),
              alignment: Alignment.bottomCenter,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const LogoBegining(widthLogo: 250),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, responsive.inchPercent(02)),
                            alignment: Alignment.bottomCenter,
                            child: ButtonPrimary(
                              status: true,
                              iconbtn: true,
                              typeIcon: Icons.account_balance_wallet_outlined,
                              titleButton: "Create Wallet".tr,
                              fontSizeButton: 20.0,
                              callBack: () {
                                _.wallet();
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: ButtonPrimary(
                                status: true,
                                iconbtn: true,
                                typeIcon: Icons.import_export,
                                titleButton: "Import Wallet".tr,
                                fontSizeButton: 20.0,
                                callBack: () {
                                  _.importWallet();
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
