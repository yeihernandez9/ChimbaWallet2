import 'package:chimba_wallet/app/modules/book/book_controller.dart';
import 'package:get/get.dart';

class BookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookController());
  }
}
