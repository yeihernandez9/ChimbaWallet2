import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/global_widgets/button_primary.dart';
import 'package:chimba_wallet/app/global_widgets/text_field_small_widget%20copy.dart';
import 'package:chimba_wallet/app/modules/verify_mnemonic/verify_mnemonic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/functions/responsive.dart';

class VerifyMnemonicPage extends StatelessWidget {
  const VerifyMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<VerifyMnemonicController>(
      init: VerifyMnemonicController(),
      builder: (_) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBarChild(
            buttonBack: true,
            nameTitle: 'Check the Mnemonic'.tr,
          ),
          body: Stack(
            children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(10),
                    responsive.inchPercent(2),
                    responsive.inchPercent(0)),
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Obx(() => Text(
                            _.statusButtonMsg.value, 
                            style: const TextStyle(
                              color: Colors.white
                            ),),
                          ),
                          Container(
                            height: 400,
                            color: Colors.transparent,
                            child: GridView.builder(
                              itemCount: _.mnemonicText.length,
                              padding: const EdgeInsets.all(30),
                              itemBuilder: (ctx, index) {
                                final int intMemonic = _.randomNumber[index];
                                return Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            '${intMemonic + 1}.',
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        TextFielSmalldWidget(
                                          hideText: false,
                                          onChanged: ((value) {
                                            _.onTextNemonicChanged(
                                                intMemonic, value);
                                          }),
                                          titleText: '',
                                        )
                                      ],
                                    ));
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                              ),
                            ),
                          ),
                          ButtonPrimary(
                            status: true,
                            typeIcon: Icons.navigate_next_outlined,
                            titleButton: 'Next'.tr,
                            fontSizeButton: 20.0,
                            callBack: () {
                              _.welcome();
                            },
                          ),
                          SizedBox(
                            height: responsive.inchPercent(5),
                          )
                        ]),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
