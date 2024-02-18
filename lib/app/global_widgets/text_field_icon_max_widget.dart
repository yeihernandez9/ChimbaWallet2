import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:chimba_wallet/app/modules/send/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldIconMaxWidget extends StatelessWidget {
  final SendController _ = Get.put(SendController());
  final String titleText;
  final String? errorText;
  final void Function(String)? onChanged;
  final void Function(String)? onShowHide;
  final TextEditingController? controller;
  final TextInputType? typeInput;
  final bool hideText;
  final String? initValue;

  TextFieldIconMaxWidget({
    Key? key,
    required this.titleText,
    this.onChanged,
    this.onShowHide,
    this.controller,
    required this.hideText,
    this.errorText,
    this.initValue,
    this.typeInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return SizedBox(
        width: 400,
        child: TextField(
            controller: controller,
            onChanged: onChanged,
            obscureText: hideText,
            keyboardType: typeInput,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Align(
                        child: Image.asset(
                      'assets/images/max.png',
                      width: responsive.inchPercent(10),
                    ))),
                onPressed: () {
                  _.getMax();
                },
              ),
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
