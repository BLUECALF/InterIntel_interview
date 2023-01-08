import "dart:io";

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushNotificationService extends GetxController{
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

Future initialize() async
{
  if(Platform.isIOS)
    {
      _fcm.requestPermission();
    }
  _fcm.subscribeToTopic("PrivPay");

}
}
