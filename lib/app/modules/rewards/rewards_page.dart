import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/buttons_fee.dart';
import 'package:chimba_wallet/app/modules/rewards/rewards_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<RewardsController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBarChild(nameTitle: 'My rewards'.tr, buttonBack: true),
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
                    child: Column(children: [
                      Obx(() => ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Maximo a reclamar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                            subtitle: Text(
                              _.reward.value + " CMBA",
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 18),
                            ),
                          )),
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
                        status: _.rewardAmount.value > 0 ? true : false,
                        width: 110,
                        height: 45,
                        titleButton: "Claim".tr,
                        fontSizeButton: 16.0,
                        callBack: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                'Confirm Claim Reward'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              backgroundColor:
                                  const Color(0xff303a47).withOpacity(1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              content: Text(
                                  "Do you wish to proceed with the transaction?"
                                      .tr,
                                  style: TextStyle(color: Colors.white)),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text(
                                    'Cancel'.tr,
                                    style: TextStyle(color: Color(0xff50dcd4)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(
                                      context,
                                      'OK',
                                    ),
                                    _.rewards()
                                  },
                                  child: Text('OK'.tr,
                                      style:
                                          TextStyle(color: Color(0xff50dcd4))),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ]),
                  )))
            ])));
  }
}
