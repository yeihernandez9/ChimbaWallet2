import 'package:chimba_wallet/app/modules/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
const NotificationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
  return GetBuilder<NotificationController>(
        builder: (_) => Scaffold(
          appBar: AppBar(
             backgroundColor: Colors.transparent,
            title: Text('Notification'.tr),
            actions: <Widget>[
            IconButton(onPressed: (){
              _.goHome();
            }, icon: Icon(Icons.close_rounded, color: Colors.white))
          ]),
           extendBodyBehindAppBar: false,
              backgroundColor: Colors.black,
              body: Center(
                child: 
                Obx(() => 
                Text(_.message.value , style: TextStyle(color: Colors.white, fontSize: 18),)
                )
              ),
        ));
        }
}