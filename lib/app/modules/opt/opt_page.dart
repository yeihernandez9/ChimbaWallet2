import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_widget.dart';
import 'package:chimba_wallet/app/modules/opt/opt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class OptPage extends StatelessWidget {
  const OptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<OptController>(
        builder: (_) => Scaffold(
            extendBodyBehindAppBar: true,
            appBar: const AppBarChild(
                nameTitle: 'Codigo De verificacion', buttonBack: true),
            body: Stack(
              children: [
                BackgroundImage(),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      responsive.inchPercent(2),
                      responsive.inchPercent(12),
                      responsive.inchPercent(2),
                      responsive.inchPercent(0)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            responsive.inchPercent(1),
                            responsive.inchPercent(3),
                            responsive.inchPercent(1),
                            responsive.inchPercent(2)),
                        decoration: BoxDecoration(
                            color: const Color(0xff121A23),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(bottom: 30.0),
                              child: _.phoneNumber.value == 0
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white))
                                  : Text(
                                      'Se envió un código de verificación al número ${_.phoneNumber}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      )),
                            ),
                            TextFieldWidget(
                              hideText: false,
                              titleText: 'Ingresa el codigo',
                              onChanged: (code) => {_.onChangeCode(code)},
                              typeInput: const TextInputType.numberWithOptions(
                                  decimal: true, signed: false),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  responsive.inchPercent(0),
                                  responsive.inchPercent(1),
                                  responsive.inchPercent(0),
                                  responsive.inchPercent(0)),
                              margin: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: [
                                  ButtonPrimary(
                                    status: true,
                                    titleButton: 'Verificar',
                                    fontSizeButton: 20.0,
                                    callBack: _.verifyCode,
                                  ),
                                  const SizedBox(height: 10),
                                  ListTile(
                                    title: const Text(
                                      'Reenviar código',
                                      style: TextStyle(
                                          color: Color(0xff50dcd4),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: _.resendCode,
                                  ),
                                ],
                              ),
//
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

// ButtonPrimary(
//                                   status: true,
//                                   titleButton: 'Verificar',
//                                   fontSizeButton: 20.0,
//                                   callBack: () => {}),
