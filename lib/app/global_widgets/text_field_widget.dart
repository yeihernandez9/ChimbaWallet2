import 'package:chimba_wallet/app/core/utils/functions/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  final GlobalController _ = Get.put(GlobalController());
  final String titleText;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function(String)? onShowHide;
  final TextEditingController? controller;
  final bool hideText;
  final String? initValue;
  final void Function(String)? validar;
  final TextInputType? typeInput;
  TextFieldWidget(
      {Key? key,
      required this.titleText,
      this.onChanged,
      this.onShowHide,
      this.controller,
      required this.hideText,
      this.errorText,
      this.initValue,
      this.validar,
      this.typeInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        child: hideText
            ? Obx(() => TextFormField(
                validator: (value) {
                  validar;
                },
                controller: controller,
                onChanged: onChanged,
                keyboardType: typeInput,
                obscureText: _.isPasswordHidden.value,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: initValue,
                  errorText: errorText,
                  filled: true,
                  fillColor: const Color(0xff282c34),
                  labelText: titleText,
                  suffixIcon: Obx(() => IconButton(
                        icon: Icon(_.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          _.showHidenPasswd(_.isPasswordHidden.value);
                        },
                        color: Color(0xff50dcd4),
                      )),
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
                keyboardAppearance: Brightness.dark))
            : TextField(
                controller: controller,
                onChanged: onChanged,
                obscureText: hideText,
                keyboardType: typeInput,
                cursorColor: Colors.white,
                decoration: InputDecoration(
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
