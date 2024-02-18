import 'package:flutter/material.dart';

class TextFielSmalldWidget extends StatelessWidget {
  final String? titleText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool hideText;
  const TextFielSmalldWidget({
    Key? key,
    this.titleText,
    this.onChanged,
    this.controller,
    required this.hideText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        child: TextField(
            controller: controller,
            onChanged: onChanged,
            obscureText: hideText,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xff1C1C1C),
              labelText: "",
              labelStyle: const TextStyle(
                color: Colors.white,
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
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            keyboardAppearance: Brightness.dark));
  }
}
