import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? msg;
  const LoadingDialog({Key? key, this.msg = "Transfiriendo"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff303a47).withOpacity(1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor:Color(0xff50dcd4),
          ),
          const SizedBox(width: 20),
          Text(msg!,style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
