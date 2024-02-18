import 'package:chimba_wallet/app/data/model/request_governance.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class GovernanceController extends GetxController {
  List<RequestGovernance> _statusVoting = [];
  List<RequestGovernance> get statusVoting => _statusVoting;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    leerData();
  }

  leerData() {
    _statusVoting = Get.arguments;
    update();
  }

  goStatusGovenance(String? id) {
    Get.toNamed(AppRoutes.PROPOSAL, arguments: id);
  }
}
