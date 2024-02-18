import 'package:chimba_wallet/app/core/utils/helpers/dataBookAddressHelper.dart';
import 'package:chimba_wallet/app/data/model/book_address.dart';
import 'package:get/get.dart';

class CreateBookController extends GetxController {
  final RxString _nickname = ''.obs;
  RxString get nickname => _nickname;

  final RxString _address = ''.obs;
  RxString get address => _address;

  final RxString _description = ''.obs;
  RxString get description => _description;

  final RxBool _msgErrorName = false.obs;
  RxBool get msgErrorName => _msgErrorName;

  final RxBool _msgErrorAddress = false.obs;
  RxBool get msgErrorAddress => _msgErrorAddress;

  final RxBool _wrongAddress = false.obs;
  RxBool get wrongAddress => _wrongAddress;

  RxList userBookAddress = [].obs;

  onChangeNickname(String text) {
    _msgErrorName.value = false;
    _nickname.value = text;
  }

  onChangeAddress(String text) {
    _msgErrorAddress.value = false;
    _address.value = text;
  }

  onChangeDescription(String text) {
    _description.value = text;
  }

  save() async {
    if (_nickname.value.isEmpty) {
      _msgErrorName.value = true;
    } else if (_address.value.isEmpty) {
      _msgErrorAddress.value = true;
    } else if (!_address.value.startsWith('chimba')) {
      _wrongAddress.value = true;
    } else {
      var dataBookAddress = BookAddress(
        nickname: _nickname.value,
        address: _address.value,
        description: _description.value,
      );

      addBookAddress(dataBookAddress);
    }
    update();
  }

  addBookAddress(BookAddress bookAddress) async {
    try {
      DataBookAddressHelper.db
          .insertBookAddress(bookAddress)
          .then((value) => userBookAddress.add(bookAddress));
      Get.back();
    } catch (e) {
      print(e);
    }
  }
}
