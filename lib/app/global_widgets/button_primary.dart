import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final Function callBack;
  final String titleButton;
  final double fontSizeButton;
  final bool status;
  final IconData? typeIcon;
  final bool? iconbtn;
  final double? width;
  final double? height;
  const ButtonPrimary(
      {Key? key,
      required this.callBack,
      required this.titleButton,
      required this.fontSizeButton,
      required this.status,
      this.typeIcon = Icons.account_balance_wallet_outlined,
      this.iconbtn = false,
      this.width = 400,
      this.height = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: iconbtn == true
            ? (OutlinedButton.icon(
                onPressed: status
                    ? () {
                        callBack();
                      }
                    : null,
                style: status
                    ? OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff50dcd4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)))
                    : OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff1C1C1C),
                        side: const BorderSide(
                            color: Color(0xff50dcd4), width: 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                label: status
                    ? AutoSizeText(
                        titleButton,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeButton,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      )
                    : AutoSizeText(
                        titleButton,
                        style: TextStyle(
                          color: const Color(0xff1C1C1C),
                          fontSize: fontSizeButton,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                icon: Icon(
                  typeIcon,
                  size: 26.0,
                  color: Colors.white,
                )))
            : OutlinedButton(
                onPressed: status
                    ? () {
                        callBack();
                      }
                    : null,
                style: status
                    ? OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff50dcd4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)))
                    : OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(
                            color: Color(0xff50dcd4), width: 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                child: status
                    ? AutoSizeText(
                        titleButton,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeButton,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      )
                    : AutoSizeText(
                        titleButton,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSizeButton,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
              ));
  }
}
