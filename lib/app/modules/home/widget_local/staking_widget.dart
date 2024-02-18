import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StakingWidget extends StatelessWidget {
  StakingWidget({Key? key}) : super(key: key);

  final _ = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
        width: 600,
        height: 140,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(0xff303a47),
            border: Border.all(color: Colors.white, width: 0.2)),
        child: Column(
          children: [
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              onTap: _.goStakingDashboard,
              title: Text(
                'Staking'.tr,
                style: const TextStyle(
                    color: Color(0xff50dcd4),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 34,
              ),
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              title: Text('Total staked'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              trailing: const Text('0 CHIMBA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -3),
              title: Text('Total unstaking'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
              trailing: const Text('0 CHIMBA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
          ],
        ));
  }
}
