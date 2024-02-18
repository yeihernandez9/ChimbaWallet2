import 'package:flutter/material.dart';

class LogoBegining extends StatelessWidget {
  final double widthLogo;

  const LogoBegining({
    Key? key,
    required this.widthLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logoChimba.png',
      width: widthLogo,
    );
  }
}
