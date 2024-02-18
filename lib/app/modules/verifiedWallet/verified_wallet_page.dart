import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/logo_begining.dart';
import 'package:chimba_wallet/app/modules/verifiedWallet/verified_wallet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class VerifiedWalletPage extends StatelessWidget {
  const VerifiedWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<VerifiedWalletController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackgroundImage(),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  responsive.inchPercent(2),
                  responsive.inchPercent(10),
                  responsive.inchPercent(2),
                  responsive.inchPercent(20),
                ),
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const LogoBegining(widthLogo: 250),
                      SizedBox(
                        height: responsive.inchPercent(1),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        child: const AutoSizeText(
                          'Verificacion Exitosa',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34.0,
                            color: Color(0xff50dcd4),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonPrimary(
                          status: true,
                          titleButton: 'Done'.tr,
                          fontSizeButton: 20.0,
                          callBack: _.goHome,
                        ),
                      ),
                      SizedBox(
                          height: responsive.inchPercent(
                              5)), // Espacio adicional si es necesario
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
