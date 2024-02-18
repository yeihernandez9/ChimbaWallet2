import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxBool _isPasswordHidden = true.obs;
  RxBool get isPasswordHidden => _isPasswordHidden;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('Global onInit');
  }

  showHidenPasswd(bool status) {
    if (status) {
      _isPasswordHidden.value = false;
    } else {
      _isPasswordHidden.value = true;
    }
  }
}
