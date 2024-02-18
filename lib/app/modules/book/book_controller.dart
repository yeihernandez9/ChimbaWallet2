import 'package:chimba_wallet/app/core/utils/helpers/dataBookAddressHelper.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  RxList _booksAddres = [].obs;
  RxList get booksAddres => _booksAddres;

  RxBool _status = false.obs;
  RxBool get status => _status;

  @override
  void onReady() {
    fechtBookAddress();
    // TODO: implement onInit
    super.onInit();
  }

  fechtBookAddress() async {
    DataBookAddressHelper.db
        .getBookAddressMapList()
        .then((bookAdresList) => {_booksAddres.value = bookAdresList});

    update();
  }

  delete(int id) {
    DataBookAddressHelper.db.deleteBookAddress(id);

    DataBookAddressHelper.db
        .getBookAddressMapList()
        .then((bookAdresList) => {_booksAddres.value = bookAdresList});

    update();
  }

  goCreateBook() {
    Get.toNamed(AppRoutes.CREATEBOOK);
  }

  sendToSaved(dynamic address) {
    Get.offNamed(AppRoutes.SEND, arguments: [
      {
        "code": address,
      }
    ]);
  }
}
