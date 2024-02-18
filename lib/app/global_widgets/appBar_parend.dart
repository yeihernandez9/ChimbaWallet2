import 'package:chimba_wallet/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarParend extends StatelessWidget implements PreferredSizeWidget {
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final _ = Get.find<HomeController>();
  final String nameTitle;
  final bool buttonBack;
  final List<Widget>? actions;

  AppBarParend(
      {Key? key,
      required this.nameTitle,
      required this.buttonBack,
      this.actions})
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
      actions: actions ??
          [
            IconButton(
              icon: const Icon(Icons.qr_code_rounded),
              tooltip: 'Scanner QR',
              onPressed: () {
                _.goQrScanner();
              },
            )
          ],
      actionsIconTheme:
          const IconThemeData(size: 30.0, color: Colors.white, opacity: 10.0),
    );
  }
}
