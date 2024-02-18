import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class NotificationController extends GetxController {
  RxString _message = 'no-data'.obs;
  RxString get message => _message;
  @override
  void onReady() {
    getNotification();
    // TODO: implement onReady
    super.onReady();
  }

  getNotification() {
    
    Get.arguments;
    print('Notificacion: ${Get.arguments}');
    _message.value = Get.arguments;
  }

  goHome(){
    Get.offAllNamed(AppRoutes.WALLET_CHANGE, arguments: true);
  }
}
