import 'package:firebase_messaging/firebase_messaging.dart';


class NotificationServices{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

 requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true ,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized){
      print("user granted permition");

    }else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print("user granted provisional permition");

    }else {
      print("user denied permition");
    }


  }


}