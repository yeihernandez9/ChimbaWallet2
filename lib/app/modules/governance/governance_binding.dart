import 'package:chimba_wallet/app/modules/governance/governance_controller.dart';
import 'package:get/get.dart';

class GovernanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GovernanceController());
  }
}
