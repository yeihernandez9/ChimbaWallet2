import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/buttons_fee.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/button_primary.dart';
import '../../global_widgets/text_field_widget.dart';
import 'unstaking_controller.dart';

class UnstakingPage extends StatelessWidget {
  const UnstakingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<UnstakingController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBarChild(nameTitle: 'Unstaking'.tr, buttonBack: true),
            body: Stack(children: [
              BackgroundImage(),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      responsive.inchPercent(1),
                      responsive.inchPercent(5),
                      responsive.inchPercent(1),
                      responsive.inchPercent(0)),
                  alignment: Alignment.bottomCenter,
                  child: Center(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                        Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Maximo a reclamar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                                Text(
                                  "${_.delegate.value} CMBA",
                                  style: const TextStyle(
                                      color: Colors.white38, fontSize: 18),
                                ),
                                SizedBox(
                                  width: responsive.widthPercent(80),
                                  child: const AutoSizeText(
                                    "La desvinculación no se puede cancelar, y no obtendrás ninguna recompensa de apuesta mientras desvinculas estos tokens. La liberación durará 21 días.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFieldWidget(
                          titleText: 'Amount'.tr,
                          hideText: false,
                          onChanged: (value) {
                            _.onChangeAmount(value);
                          },
                          typeInput: const TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFieldWidget(
                          titleText: '${'Memo'.tr} (${'Optional'.tr})',
                          hideText: false,
                          onChanged: ((value) {
                            _.onChangeMemo(value);
                          }),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        SizedBox(
                          child: Text(
                            'Fee'.tr,
                            style: const TextStyle(
                                color: Color(0xff50dcd4), fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: responsive.widthPercent(82),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonsFee(
                                fontSizeButton: 20,
                                status: _.selectedFee.value == 1 ? true : false,
                                title: "Min".tr,
                                money: "\$0,00125",
                                amount: "0,00025CMBA",
                                callBack: (() {
                                  _.onChangeFee(1);
                                }),
                              ),
                              ButtonsFee(
                                fontSizeButton: 20,
                                status: _.selectedFee.value == 2 ? true : false,
                                title: "Down".tr,
                                money: "\$0,0125",
                                amount: "0,0025CMBA",
                                callBack: (() {
                                  _.onChangeFee(2);
                                }),
                              ),
                              ButtonsFee(
                                fontSizeButton: 20,
                                status: _.selectedFee.value == 3 ? true : false,
                                title: "Average".tr,
                                money: "\$0,125",
                                amount: "0,025CMBA",
                                callBack: (() {
                                  _.onChangeFee(3);
                                }),
                              ),
                              
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ButtonPrimary(
                          status: _.delegateAmount.value > 0 ? true : false,
                          titleButton: "Unstaking".tr,
                          fontSizeButton: 20.0,
                          callBack: () {
                            _.staking();
                          },
                        ),
                      ]))))
            ])));
  }
}
