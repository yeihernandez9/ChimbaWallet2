import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_widget.dart';
import 'package:chimba_wallet/app/modules/create_book/create_book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBookPage extends StatelessWidget {
  const CreateBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<CreateBookController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text('Create book'.tr),
            ),
            body: Stack(children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(10),
                    responsive.inchPercent(2),
                    responsive.inchPercent(0)),
                child: Column(children: [
                  SizedBox(
                    height: responsive.heightPercent(30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFieldWidget(
                              hideText: false,
                              titleText: 'NickName'.tr,
                              onChanged: (text) {
                                _.onChangeNickname(text);
                              },
                              errorText: _.msgErrorName.value == true
                                  ? 'Este campo es obligatorio'
                                  : null),
                          TextFieldWidget(
                              hideText: false,
                              titleText: 'Address'.tr,
                              onChanged: (text) {
                                _.onChangeAddress(text);
                              },
                              errorText: _.msgErrorAddress.value == true
                                  ? 'Este campo es obligatorio'
                                  : _.wrongAddress.value == true
                                      ? 'Esta dirección no es válida'
                                      : null),
                          TextFieldWidget(
                            hideText: false,
                            titleText: 'Description'.tr,
                            onChanged: (text) {
                              _.onChangeDescription(text);
                            },
                          ),
                        ]),
                  ),
                  Container(
                    height: responsive.heightPercent(10),
                    alignment: Alignment.bottomCenter,
                    child: ButtonPrimary(
                      status: true,
                      titleButton: 'Save'.tr,
                      fontSizeButton: 20.0,
                      callBack: () {
                        _.save();
                      },
                    ),
                  )
                ]),
              )
            ])));
  }
}
