import 'package:chimba_wallet/app/global_widgets/appBar_child.dart';
import 'package:chimba_wallet/app/modules/walletCange/wallet_change_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../core/utils/functions/responsive.dart';

class WalletChangePage extends StatelessWidget {
  const WalletChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return GetBuilder<WalletChangeController>(
        init: WalletChangeController(),
        builder: (_) => Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: const AppBarChild(
              buttonBack: true,
              nameTitle: '',
            ),
            body: Stack(
              children: [
                Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()),
              ],
            )));
  }
}
