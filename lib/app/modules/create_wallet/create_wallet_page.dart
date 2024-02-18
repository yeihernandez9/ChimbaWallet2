import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/logo_begining.dart';
import 'package:chimba_wallet/app/modules/create_wallet/create_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/functions/responsive.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<CreateWalletController>(
      builder: (_) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBarChild(
            buttonBack: true,
            nameTitle: 'Create Wallet'.tr,
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
                          iconbtn: false,
                          typeIcon: Icons.create_outlined,
                          titleButton: 'Create new Words'.tr,
                          fontSizeButton: 20.0,
                          callBack: () {
                            _.newNemonic();
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

//create two button outlinebutton?