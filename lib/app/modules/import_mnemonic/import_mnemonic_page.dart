import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_area_widget.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_widget.dart';
import 'package:chimba_wallet/app/modules/import_mnemonic/import_mnemonic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/functions/responsive.dart';
import '../../global_widgets/BackgroundImage.dart';

class ImportMnemonicPage extends StatelessWidget {
  const ImportMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<ImportMnemonicController>(
      init: ImportMnemonicController(),
      builder: (_) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBarChild(
              nameTitle: 'Import Existing Wallet'.tr, buttonBack: true),
          body: Stack(children: [
            BackgroundImage(),
            Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(5),
                    responsive.inchPercent(2),
                    responsive.inchPercent(0)),
                height: responsive.heightPercent(100),
                child: SingleChildScrollView(
                  child: Container(
                    height: responsive.heightPercent(75),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFieldAreaWidget(
                          titleText: 'Mnemonic seed'.tr,
                          controller: _.pageEditingController,
                          onChanged: _.onChangeMnemonic,
                          errorText: _.errorMnemonics.value
                              ? 'faild mnemonics'.tr
                              : null,
                        ),
                        Column(
                          children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => TextFieldWidget(
                                        titleText: 'Wallet Name'.tr,
                                        hideText: false,
                                        onChanged: _.onChangeWallet,
                                        errorText: _.errorWallet.value
                                            ? 'You must fill in the field'.tr
                                            : null,
                                      )),
                                  SizedBox(
                                    height: responsive.heightPercent(2),
                                  ),
                                  Obx(() => Visibility(
                                      visible: _.status != 2 ? true : false,
                                      child: TextFieldWidget(
                                        titleText: 'Password'.tr,
                                        hideText: true,
                                        onChanged: _.onChangePassword,
                                        errorText: _.errorPassword.value
                                            ? 'You must fill in the Password'.tr
                                            : null,
                                      ))),
                                  SizedBox(
                                    height: responsive.heightPercent(2),
                                  ),
                                  Obx(() => Visibility(
                                      visible: _.status != 2 ? true : false,
                                      child: TextFieldWidget(
                                        titleText: 'Confirm Password'.tr,
                                        hideText: true,
                                        onChanged: _.onChangePasswordConfirm,
                                        errorText: _.errorPasswordConfirm.value
                                            ? 'You must fill in the Confirm Password'
                                                .tr
                                            : (_.password.value !=
                                                    _.confirmPassword.value)
                                                ? 'Passwords are not equal'.tr
                                                : null,
                                      ))),
                                ])
                          ],
                        ),
                        ButtonPrimary(
                          status: true,
                          typeIcon: Icons.keyboard_double_arrow_right_rounded,
                          titleButton: 'Next'.tr,
                          fontSizeButton: 20.0,
                          callBack: () {
                            _.verifyMnemonic();
                          },
                        ),
                      ],
                    )),
                  ),
                )),
          ])),
    );
  }
}
