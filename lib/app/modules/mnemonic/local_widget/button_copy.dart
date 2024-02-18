import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class ButtonCopy extends StatelessWidget {
  final String titleButton;
  final String textCopy;
  const ButtonCopy({
    Key? key,
    required this.titleButton,
    required this.textCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        FlutterClipboard.copy(textCopy).then(
          (value) {
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Mnemonic copiados!'),
              ),
            );
          },
        );
      },
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xff282c34),
          side: const BorderSide(color: Color(0xff50dcd4), width: 1)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 30),
        child: Text(
          titleButton,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
