import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/global_widgets/BackgroundImage.dart';
import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/modules/staking_dashboard/staking_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StakingDashboardPage extends StatelessWidget {
  const StakingDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);
    return GetBuilder<StakingDashboardController>(
        builder: (_) => Scaffold(
              backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
              appBar: AppBarChild(
                  nameTitle: 'Staking Dashboard'.tr, buttonBack: true),
                  body: Stack(children: [
              BackgroundImage(),
              Container(
                  padding: EdgeInsets.fromLTRB(
                      responsive.inchPercent(1),
                      responsive.inchPercent(5),
                      responsive.inchPercent(1),
                      responsive.inchPercent(0)),
                  alignment: Alignment.bottomCenter,
                  child: Center(child: SingleChildScrollView()))
            ])
            ));
  }
}
