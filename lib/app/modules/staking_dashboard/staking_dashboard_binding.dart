import 'package:chimba_wallet/app/modules/staking_dashboard/staking_dashboard_controller.dart';
import 'package:get/get.dart';

class StakingDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StakingDashboardController());
  }
}
