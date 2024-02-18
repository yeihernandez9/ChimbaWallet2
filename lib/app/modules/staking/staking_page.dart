import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/buttons_fee.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_icon_max2_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/button_primary.dart';
import '../../global_widgets/text_field_widget.dart';
import 'staking_controller.dart';

class StakingPage extends StatelessWidget {
  const StakingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<StakingController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBarChild(nameTitle: 'Staking'.tr, buttonBack: true),
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
                        SizedBox(
                          width: responsive.widthPercent(80),
                          child: const AutoSizeText(
                            "Una vez que reclame sus CHIMBA comisionados, tendrá que esperar 21 días para que sus tokens sean liberados.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Obx(() => TextFieldIconMax2Widget(
                              controller: _.myAmountController,
                              titleText: 'Amount'.tr,
                              hideText: false,
                              initValue: _.amountBalance.value,
                              typeInput: const TextInputType.numberWithOptions(
                                  decimal: true, signed: false),
                              onChanged: (value) {
                                _.onChangeAmount(value);
                              },
                            )),
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
                          status: _.stakeAmount.value > 0 ? true : false,
                          titleButton: "Stake".tr,
                          fontSizeButton: 20.0,
                          callBack: () {
                            _.staking();
                          },
                        ),
                      ]))))
            ])));
  }
}
