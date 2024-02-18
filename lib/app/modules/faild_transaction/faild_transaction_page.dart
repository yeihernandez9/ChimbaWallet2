import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/logo_begining.dart';
import 'package:chimba_wallet/app/modules/faild_transaction/faild_transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class FaildTransactionPage extends StatelessWidget {
  const FaildTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<FaildTransacctionController>(
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
                  const AutoSizeText(
                    'Transferencia Fallida',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 34.0,
                        color: Color(0xfff32f8b),
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: responsive.inchPercent(1),
                  ),
                  const AutoSizeText(
                    'Por favor valida la dirección y gas usado para esta transferencia.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                    maxLines: 2,
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonPrimary(
                      status: true,
                      titleButton: 'Retry'.tr,
                      fontSizeButton: 20.0,
                      callBack: () {
                        _.goBack();
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
