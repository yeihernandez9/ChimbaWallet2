import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            'assets/images/bg-secondary.png'), // Replace with your own image path
        fit: BoxFit.cover,
      ),
    ));
  }
}
