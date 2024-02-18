import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _messageStreamController = StreamController<String>.broadcast();
  Stream<String> get message => _messageStreamController.stream;

  initNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _firebaseMessaging.getToken().then((token) async => { 
          if (token != null) {print('token: $token')},
    });
    

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      String argument = 'no-data';
      if (Platform.isAndroid) {
        argument = message.data['data'] ?? 'no-data';
      }

      if (Platform.isIOS) {
        argument = message.data['data'] ?? 'no-data';
      }

      _messageStreamController.sink.add(argument);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the onMessageOpenedApp!');
      print('Message data: ${message.data}');
      String argument = 'no-data';
      if (Platform.isAndroid) {
        argument = message.data['data'] ?? 'no-data';
      }

      if (Platform.isIOS) {
        argument = message.data['data'] ?? 'no-data';
      }

      _messageStreamController.sink.add(argument);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print('Got a message whilst in the onBackgroundMessage!');
      print('Message data: ${message.data}');
      String argument = 'no-data';
      if (Platform.isAndroid) {
        argument = message.data['data'] ?? 'no-data';
      }

      if (Platform.isIOS) {
        argument = message.data['data'] ?? 'no-data';
      }

      _messageStreamController.sink.add(argument);
    });
  }

  Future<String?> getToken() async{
     String? token = await _firebaseMessaging.getToken();
     return token;
  }
}
