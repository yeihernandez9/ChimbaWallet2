import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/logo_begining.dart';
import 'package:chimba_wallet/app/modules/import_wallet/import_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/functions/responsive.dart';
import '../../global_widgets/BackgroundImage.dart';

class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<ImportWalletController>(
      builder: (_) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBarChild(
            buttonBack: true,
            nameTitle: 'Import Wallet'.tr,
          ),
          body: Stack(
            children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(10),
                    responsive.inchPercent(2),
                    responsive.inchPercent(10)),
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const LogoBegining(widthLogo: 250),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonPrimary(
                          status: true,
                          iconbtn: true,
                          typeIcon: Icons.import_export_outlined,
                          titleButton: 'Importar Mnemonic'.tr,
                          fontSizeButton: 20.0,
                          callBack: () {
                            _.importMmemonic();
                          },
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
