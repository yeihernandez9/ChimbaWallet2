import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/functions/responsive.dart';

class MyRewardsWidget extends StatelessWidget {
  MyRewardsWidget({Key? key}) : super(key: key);

  final _ = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return Obx(() => Container(
        decoration: _.status.value
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xff121A23))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromARGB(255, 3, 18, 35)),
        child: InkWell(
          child: ListTile(
            leading: Image.asset(
              'assets/images/recompensa.png',
              width: responsive.widthPercent(10),
            ),
            title: Text(
              'CMBA ${'My rewards'.tr}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w200),
            ),
            subtitle: _.reward.value == '0'
                ? Container(
                    width: 30,
                    height: 35,
                    alignment: Alignment.centerRight,
                    child: const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)))
                : AutoSizeText(
                    '${_.reward}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
          ),
          onTap: () {
            if (_.status.value) _.goRewards();
          },
        )));
  }
}
