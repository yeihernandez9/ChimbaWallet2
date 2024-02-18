import 'package:chimba_wallet/app/modules/create_book/create_book_controller.dart';
import 'package:get/get.dart';

class CreateBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateBookController());
  }
}
