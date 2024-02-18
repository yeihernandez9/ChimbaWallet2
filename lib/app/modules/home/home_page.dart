import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_parend.dart';
import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:chimba_wallet/app/modules/home/widget_local/balance_widget.dart';
import 'package:chimba_wallet/app/modules/home/widget_local/govenance_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/functions/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBarParend(
            buttonBack: false,
            nameTitle: '',
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              BackgroundImage(),
              Container(
                padding: EdgeInsets.fromLTRB(
                    responsive.inchPercent(2),
                    responsive.inchPercent(6),
                    responsive.inchPercent(2),
                    responsive.inchPercent(0)),
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: RefreshIndicator(
                        onRefresh: () async {
                          _.getBalance();
                        },
                        child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                              BalanceWidget(),
                              SizedBox(
                                height: responsive.heightPercent(2),
                              ),
                              // StakingWidget(), fue incluido en el balanceWidget
                              SizedBox(
                                height: responsive.heightPercent(1),
                              ),
                              GovenanceWidget(),
                              SizedBox(
                                height: responsive.heightPercent(13),
                              ),
                            ])))),
              )
            ],
          )),
    );
  }
}
