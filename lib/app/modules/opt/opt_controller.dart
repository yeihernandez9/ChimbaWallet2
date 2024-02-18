// ignore_for_file: unused_local_variable, avoid_print, prefer_final_fields

import 'package:chimba_wallet/app/data/model/createToken.dart';
import 'package:chimba_wallet/app/data/model/request_code_validate.dart';
import 'package:chimba_wallet/app/data/model/resentOpt.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:get/get.dart';

class OptController extends GetxController {
  final WalletRepository _requestWallet = Get.put(WalletRepository());
  var arguments = Get.arguments;

  RxInt _phoneNumber = 0.obs;
  RxInt get phoneNumber => _phoneNumber;

  RxString _tokenAPi = ''.obs;
  RxString get tokenAPi => _tokenAPi;

  RxInt _codeVrify = 0.obs;
  RxInt get codeVrify => _codeVrify;

  RxBool _validateWallet = false.obs;
  RxBool get validateWallet => _validateWallet;

  RxString _msgError = ''.obs;
  RxString get msgError => _msgError;

  RxBool _msgErrorBool = false.obs;
  RxBool get msgErrorBool => _msgErrorBool;

  RxString _validateNumber = ''.obs;
  RxString get validateNumber => _validateNumber;

  @override
  void onInit() async {
    print('arguments ${Get.arguments}');
    await getToken();
    getPhoneNumber();
    super.onInit();
  }

  @override
  void onReady() async {
    update();
    super.onReady();
  }

  getPhoneNumber() {
    if (arguments is int) {
      print('es int phoneNumber');
      phoneNumber.value = Get.arguments;
      resendCode();
    } else {
      final argumentsMap = arguments as Map<String, dynamic>?;

      if (argumentsMap != null && argumentsMap.containsKey("phoneNumber")) {
        phoneNumber.value = argumentsMap["phoneNumber"];
      }
    }
  }

  getToken() async {
    RequestCreateToken requestCreateToken = await _requestWallet.createToken();
    _tokenAPi.value = requestCreateToken.token;
    print('tokenn${_tokenAPi.value}');
  }

  resendCode() async {
    ResendOpt resendOpt = await _requestWallet.resendCode(
        phoneNumber: phoneNumber.value, token: _tokenAPi.value);
  }

  onChangeCode(code) {
    _codeVrify.value = int.parse(code);
  }

  verifyCode() async {
    RequestCodeValidate requestCodeValidate =
        await _requestWallet.getCodeValidate(
            token: _tokenAPi.value,
            code: _codeVrify.value,
            phoneNumber: phoneNumber.value);
    if (requestCodeValidate.phoneNumber == phoneNumber.value) {
      _validateWallet.value == true;
      Get.toNamed(AppRoutes.VERIFIED_WALLET);
    } else {
      validateWallet.value == false;
      _msgErrorBool.value = true;
    }
  }
}
