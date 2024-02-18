import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  final Function callBack;
  final String titleButton;
  final double fontSizeButton;
  final bool status;
  final IconData typeIcon;
  final double? width;
  const ButtonCircle(
      {Key? key,
      required this.callBack,
      required this.titleButton,
      required this.fontSizeButton,
      required this.status,
      required this.typeIcon,
      this.width = 120})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: status
              ? () {
                  callBack();
                }
              : null,

          child: Column(
            children: [
              status ? 
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff50dcd4),
                    border: Border.all(color: Colors.white, width: 0.2)),
                child: Icon(
                  typeIcon,
                  size: 26.0,
                  color: Colors.white,
                ),
              ):Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 81, 102, 101),
                    border: Border.all(color: Colors.white, width: 0.2)),
                child: Icon(
                  typeIcon,
                  size: 26.0,
                  color: Colors.white,
                ),
              ),
              AutoSizeText(
                titleButton,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizeButton,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ));
  }
}
