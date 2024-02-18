import 'package:auto_size_text/auto_size_text.dart';
import 'package:chimba_wallet/app/core/utils/functions/responsive.dart';
import 'package:flutter/material.dart';

class ButtonsFee extends StatelessWidget {
  final Function callBack;
  final double fontSizeButton;
  final bool status;
  final String title;
  final String money;
  final String amount;

  const ButtonsFee({
    Key? key,
    required this.callBack,
    required this.fontSizeButton,
    required this.status,
    required this.title,
    required this.money,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.on(context);

    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          callBack();
        },
        style: status
            ? OutlinedButton.styleFrom(
                backgroundColor: const Color(0xff50dcd4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)))
            : OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              responsive.inchPercent(0),
              responsive.inchPercent(0.3),
              responsive.inchPercent(0),
              responsive.inchPercent(0.3)),
          child: Column(
            children: [
              AutoSizeText(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeButton,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
              ),
              AutoSizeText(
                money,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeButton * 0.65,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
              ),
              AutoSizeText(
                amount,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeButton * 0.65,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
