import 'package:chimba_wallet/app/core/utils/functions/global_controller.dart';
import 'package:chimba_wallet/app/modules/send/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldIconWidget extends StatelessWidget {
  final GlobalController _ = Get.put(GlobalController());
  final SendController h = Get.put(SendController());
  final String titleText;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function(String)? onShowHide;
  final TextEditingController? controller;
  final bool hideText;
  final String? initValue;
  final void Function(String)? evento;
  final void Function(String)? validator;
  TextFieldIconWidget(
      {Key? key,
      required this.titleText,
      this.onChanged,
      this.onShowHide,
      this.controller,
      required this.hideText,
      this.errorText,
      this.initValue,
      this.evento,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: TextFormField(
            validator: (value) {
              validator;
            },
            controller: controller,
            onChanged: onChanged,
            obscureText: hideText,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.qr_code_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  h.goQrScanner();
                },
              ),
              hintText: initValue,
              errorText: errorText,
              filled: true,
              fillColor: const Color(0xff282c34),
              labelText: titleText,
              labelStyle: const TextStyle(
                color: Color(0xff50dcd4),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xff50dcd4)),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xff50dcd4)),
                  borderRadius: BorderRadius.circular(16)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(16)),
              errorStyle: const TextStyle(color: Colors.red),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(16)),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            keyboardAppearance: Brightness.dark));
  }
}
