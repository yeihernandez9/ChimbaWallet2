import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
const AlertDialogWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
                              title: Text(
                                'Confirm Claim Reward',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              backgroundColor: const Color(0xff303a47).withOpacity(1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              content: Text(
                                  "Do you wish to proceed with the transaction?",
                                  style: TextStyle(color: Colors.white)),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('Cancel', style: TextStyle(color: Color(0xff50dcd4)),),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'OK',)
                                  },
                                  child: Text('OK', style: TextStyle(color: Color(0xff50dcd4))),
                                ),
                              ],
                            );
  }
}