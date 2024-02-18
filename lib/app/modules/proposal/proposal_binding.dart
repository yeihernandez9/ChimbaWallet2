import 'package:chimba_wallet/app/modules/proposal/proposal_controller.dart';
import 'package:get/get.dart';

class ProposalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProposalController());
  }
}
