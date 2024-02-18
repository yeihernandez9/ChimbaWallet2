import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/modules/mnemonic/local_widget/button_copy.dart';
import 'package:chimba_wallet/app/modules/show_mnemonic/show_mnemonic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowMnemonicPage extends StatelessWidget {
  const ShowMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<ShowMnemonicController>(
        builder: (_) => Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black,
              appBar: AppBarChild(
                  buttonBack: true, nameTitle: 'View Mnemonic Seed'.tr),
              body: Stack(
                children: [
                  BackgroundImage(),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        responsive.inchPercent(2),
                        responsive.inchPercent(10),
                        responsive.inchPercent(2),
                        responsive.inchPercent(5)),
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 400,
                              color: Colors.transparent,
                              child: GridView.builder(
                                itemCount: _.mnemonic.length,
                                padding: const EdgeInsets.all(16),
                                itemBuilder: (ctx, index) {
                                  final String mnemonic = _.mnemonic[index];

                                  return Container(
                                    alignment: AlignmentDirectional.center,
                                    padding: EdgeInsets.all(
                                        responsive.inchPercent(0.5)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xff50dcd4)),
                                        color: Colors.transparent),
                                    child: AutoSizeText(
                                      '${index + 1}. $mnemonic',
                                      style: const TextStyle(
                                          fontSize: 25,
                                          color: Color(0xff50dcd4),
                                          fontWeight: FontWeight.normal),
                                      maxLines: 1,
                                    ),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 7,
                                  crossAxisCount: 3,
                                  childAspectRatio: 3,
                                ),
                              ),
                            ),
                            ButtonCopy(
                                titleButton: 'Copy mnemonic'.tr,
                                textCopy: _.textMnemonic),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
