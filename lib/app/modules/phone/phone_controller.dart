// ignore_for_file: avoid_print, unrelated_type_equality_checks, unnecessary_brace_in_string_interps, unused_local_variable

import 'package:chimba_wallet/app/data/model/createToken.dart';
import 'package:chimba_wallet/app/data/model/create_verified_wallet.dart';
import 'package:chimba_wallet/app/data/model/observe_verified_wallets.dart';
import 'package:chimba_wallet/app/data/services/repository/wallet_repository.dart';
import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController {
  final WalletRepository _requestWallet = Get.put(WalletRepository());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  String initialCountry = 'CO';
  PhoneNumber number = PhoneNumber(isoCode: 'CO');

  var addressValue = Get.arguments;

  final RxBool _validateNumber = false.obs;
  RxBool get validateNumber => _validateNumber;

  final RxString _phoneNumber = '0'.obs;
  RxString get phoneNumber => _phoneNumber;

  final RxString _phonePrefix = '0'.obs;
  RxString get phonePrefix => _phonePrefix;

  final RxString _tokenApi = '0'.obs;
  RxString get tokenApi => _tokenApi;

  final RxBool _verifyNumber = false.obs;
  RxBool get verifyNumber => _verifyNumber;

  // final RxBool _emptyInput = true.obs;
  // RxBool get emptyInput => _emptyInput;

  List<int> phoneNumbers = [];

  @override
  void onInit() async {
    getToken();
    update();
    super.onInit();
  }

  onInputChanged(PhoneNumber number) {
    _phonePrefix.value = number.dialCode!;
    _phoneNumber.value =
        number.phoneNumber!.replaceAll(number.dialCode as Pattern, '');
    this.number = number;
  }

  void onInputValidated(bool value) async {
    // _emptyInput.value == false;
    _validateNumber.value = value;
    // _emptyInput.value = _validateNumber.value;
    print('NumeroCorrecto $value');
    if (value == true) {
      varifyPhoneNumber();
    }
  }

  getToken() async {
    RequestCreateToken requestCreateToken = await _requestWallet.createToken();
    _tokenApi.value = requestCreateToken.token;
  }

  varifyPhoneNumber() async {
    ObserveVerifidWallet observeVerifidWallet =
        await _requestWallet.getVerifiedWalletRquest(token: _tokenApi.value);
    for (var element in observeVerifidWallet.data) {
      phoneNumbers.add(element.phoneNumber);
    }
    _verifyNumber.value = phoneNumbers.contains(int.parse(_phoneNumber.value));

    if (phoneNumbers.contains(int.parse(_phoneNumber.value))) {
      print('Numero ya registrado');
    }
  }

  verifiedWallet() async {
    CreateVerifidWallet createVerifidWallet =
        await _requestWallet.getNumberUser(
            phonePrefix: _phonePrefix.value,
            phoneNumber: int.parse(_phoneNumber.value),
            address: addressValue,
            token: _tokenApi.value);
  }

  void validateForm() async {
    formKey.currentState?.validate();
    if (validateNumber.value && !verifyNumber.value) {
      _validateNumber.value = false;
      _verifyNumber.value = false;
      verifiedWallet();
      Get.offAllNamed(AppRoutes.OPT, arguments: {
        "phoneNumber": int.parse(_phoneNumber.value),
        "originNumber": "phoneController"
      });
    } else {
      print('No pasa');
    }
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    this.number = number;
    update();
  }

  void saveForm() {
    formKey.currentState?.save();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
