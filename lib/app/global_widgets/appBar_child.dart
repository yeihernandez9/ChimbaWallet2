import 'package:flutter/material.dart';

class AppBarChild extends StatelessWidget implements PreferredSizeWidget {
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final String nameTitle;
  final bool buttonBack;
  const AppBarChild(
      {Key? key, required this.nameTitle, required this.buttonBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: buttonBack,
      centerTitle: true,
      elevation: 0,
      title: Text(nameTitle),
      iconTheme: const IconThemeData(
        color: Colors.white, // <-- SEE HERE
      ),
    );
  }
}
