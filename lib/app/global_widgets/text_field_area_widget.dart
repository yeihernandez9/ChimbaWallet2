import 'package:chimba_wallet/app/modules/import_mnemonic/import_mnemonic_controller.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldAreaWidget extends StatelessWidget {
  final String titleText;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function(String)? clipCopy;
  final TextEditingController? controller;
  TextFieldAreaWidget({
    Key? key,
    required this.titleText,
    this.onChanged,
    this.controller,
    this.errorText,
    this.clipCopy,
  }) : super(key: key);

  final _ = Get.find<ImportMnemonicController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            controller: controller,
            onChanged: onChanged,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              errorText: errorText,
              filled: true,
              fillColor: const Color(0xff282c34),
              labelText: titleText,
              labelStyle: const TextStyle(
                color: Color(0xff50dcd4),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xff50dcd4)),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xff50dcd4)),
                  borderRadius: BorderRadius.circular(16)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(16)),
              errorStyle: TextStyle(
                color: Colors.red,
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(16)),
              suffixIcon: IconButton(
                padding: EdgeInsets.all(30.0),
                icon: const Icon(
                  Icons.paste,
                  size: 40.0,
                  color: Color(0xff50dcd4),
                ),
                onPressed: () {
                  FlutterClipboard.paste().then((value) => _.copyText(value));
                },
                color: Colors.white,
              ),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            keyboardAppearance: Brightness.dark));
  }
}
