import 'package:chimba_wallet/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class VerifyMnemonicController extends GetxController {
  List<String> _mnemonic = [];
  List<String> get mnemonic => _mnemonic;

  List<String> _mnemonicText = [];
  List<String> get mnemonicText => _mnemonicText;

  List _randomNumber = [];
  List get randomNumber => _randomNumber;

  List _compare = [];
  List get compare => _compare;

  RxBool _statusButton = false.obs;
  RxBool get statusButton => _statusButton;

  RxString _statusButtonMsg = ''.obs;
  RxString get statusButtonMsg => _statusButtonMsg;

  int _posi = 0;
  int get posi => _posi;

  Map<String, TextEditingController> _controllerMap = Map();
  Map<String, TextEditingController> get controllerMap => _controllerMap;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getMnemonic();
  }

  void getMnemonic() {
    _mnemonic = Get.arguments["walleData"]["mnemonic"];
    int randomNumber;
    for (int i = 0; i < 4; i++) {
      // generate random number from 0 to length of arrayString

      randomNumber = Random().nextInt(_mnemonic.length);
      while (_randomNumber.contains(randomNumber)) {
        randomNumber = Random().nextInt(_mnemonic.length);
      }
      _randomNumber.add(randomNumber);
      // add random item from arrayString to randomItems
      _mnemonicText.add(_mnemonic[randomNumber]);
    }

    update();
  }

  void onTextNemonicChanged(int val, String text) {
    int index = _randomNumber.indexOf(val);
    String tempText = text.toLowerCase().trim();

    if (_compare.length < 4) {
      _compare.insert(index, tempText);
    } else {
      _compare[index] = tempText;
    }

    verifyList();
  }

  void verifyList() {
    if (_compare.length == 4) {
      int cont = 0;
      for (var i = 0; i < 4; i++) {
        if (_compare[i].compareTo(_mnemonicText[i]) == 0) {
          cont++;
        }
      }
      _statusButton.value = cont == 4 ? true : false;
    }
  }

  TextEditingController getControllerOf(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController(text: name);
      _controllerMap[name] = controller;
    }
    return controller;
  }

  void welcome() {
    if(_statusButton.value){
      Get.toNamed(AppRoutes.WELCOME, arguments: {
        "walleData": {
          "mnemonic": Get.arguments["walleData"]["mnemonic"],
          "nameWallet": Get.arguments["walleData"]["nameWallet"],
          "password": Get.arguments["walleData"]["password"]
        },
        "walletStatus": Get.arguments["walletStatus"]
      });
    }else{
      _statusButtonMsg.value = "Por favor, introduce los mnemónicos correspondientes.";
    }
  }
}
