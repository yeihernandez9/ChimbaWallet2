import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_parend.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/buttons_fee.dart';
import 'package:chimba_wallet/app/global_widgets/loading_dialog.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_icon_max_widget.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_icon_widget.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_widget.dart';
import 'package:chimba_wallet/app/modules/send/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<SendController>(
        builder: (_) => Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBarParend(
              nameTitle: 'Send'.tr,
              buttonBack: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.group),
                  tooltip: 'Agenda',
                  onPressed: () => _.goSchedule(),
                  padding: const EdgeInsets.only(right: 16),
                ),
              ],
            ),
            body: Obx(() => _.isLoading.value
                ? const LoadingDialog()
                : Stack(children: [
                    BackgroundImage(),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            responsive.inchPercent(1),
                            responsive.inchPercent(5),
                            responsive.inchPercent(1),
                            responsive.inchPercent(0)),
                        alignment: Alignment.bottomCenter,
                        child: Form(
                            key: _.formKey,
                            child: Center(
                                child: SingleChildScrollView(
                                    child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Obx(() => TextFieldIconWidget(
                                    controller: _.myAddressController,
                                    titleText: 'Recipient'.tr,
                                    initValue: _.address!.value,
                                    hideText: false,
                                    onChanged: _.onChangeRecipient,
                                    errorText: _.errorAddress.value
                                        ? _.messageAddress
                                        : null)),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Obx(() => TextFieldWidget(
                                      controller: _.myTokenController,
                                      titleText: 'Token'.tr,
                                      initValue: _.token.value,
                                      hideText: false,
                                      onChanged: _.onChangeToken,
                                    )),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Obx(() => TextFieldIconMaxWidget(
                                    controller: _.myAmountController,
                                    titleText: 'Amount'.tr,
                                    initValue: _.amountBalance.value,
                                    hideText: false,
                                    onChanged: (value) {
                                      _.onChangeAmount(value);
                                    },
                                    typeInput:
                                        const TextInputType.numberWithOptions(
                                            decimal: true, signed: false),
                                    errorText: _.errorAmount.value
                                        ? _.messageAmount
                                        : null)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ButtonsFee(
                                        fontSizeButton: 20,
                                        status: _.selectedFee.value == 1
                                            ? true
                                            : false,
                                        title: "Min".tr,
                                        money: "\$0,00125",
                                        amount: "0,00025CMBA",
                                        callBack: (() {
                                          _.onChangeFee(1);
                                        }),
                                      ),
                                      
                                      ButtonsFee(
                                        fontSizeButton: 20,
                                        status: _.selectedFee.value == 2
                                            ? true
                                            : false,
                                        title: "Down".tr,
                                        money: "\$0,0125",
                                        amount: "0,0025CMBA",
                                        callBack: (() {
                                          _.onChangeFee(2);
                                        }),
                                      ),
                                      ButtonsFee(
                                        fontSizeButton: 20,
                                        status: _.selectedFee.value == 3
                                            ? true
                                            : false,
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
                                  height: 150.0,
                                ),
                                ButtonPrimary(
                                  status: true,
                                  typeIcon: Icons.send,
                                  titleButton: 'Send'.tr,
                                  fontSizeButton: 20.0,
                                  callBack: () {
                                    _.sender();
                                  },
                                )
                              ],
                            )))))
                  ]))));
  }
}
