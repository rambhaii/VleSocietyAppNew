import 'dart:io';

import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vlesociety/AppConstant/AppConstant.dart';
import 'package:vlesociety/Dashboard/controller/DashboardController.dart';
import 'package:vlesociety/Dashboard/controller/NotificationController.dart';

import '../Dashboard/view/CommunityDetails.dart';

class NotificationServices
{

  FirebaseMessaging messaging = FirebaseMessaging.instance ;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();
  void requestNotificationPermission()async
  {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true ,
        announcement: true ,
        badge: true ,
        carPlay:  true ,
        criticalAlert: true ,
        provisional: true ,
        sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    }else {
      AppSettings.openNotificationSettings();
      print('user denied permission');
    }
  }


  void initLocalNotifications(BuildContext context, RemoteMessage message)async
  {


    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings
      (
        android: androidInitializationSettings ,
        iOS: iosInitializationSettings
       );

    await _flutterLocalNotificationsPlugin.initialize
      (
        initializationSetting,
        onDidReceiveNotificationResponse: (payload)
        {

          handleMessage(context, message);
        }
    );
  }

  Future<void> firebaseInit(BuildContext context)
  async
  {

  print("sdhfjfgjh");




    FirebaseMessaging.onMessage.listen((message)
    {
      if (kDebugMode)
      {
        DashboardController controller=Get.find();
        controller.counter();
        print("sdfdsfg"+message.toString());
        print("sdkfjhfkj"+message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());

        print(message.data['id']);
        print("dsfhfdg"+message.data['image']);
        print(message.data['community_id']);
       /* DashboardController controller=Get.find();
        controller.counter();*/
      }

      //show notifications when app is active
      if(Platform.isAndroid)
      {
        //calling this function to handle internation
        initLocalNotifications(context , message);

        showNotification(message);
      }else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message)async
  {
    AndroidNotificationChannel channel = AndroidNotificationChannel
      (
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.max
      );


    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails
      (
        channel.id.toString(),
        channel.name.toString() ,
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high ,
        ticker: 'ticker'
      );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true ,
        presentBadge: true ,
        presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){_flutterLocalNotificationsPlugin.
    show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });

  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }


  Future<void> setupInteractMessage(BuildContext context)async{

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();


    if(initialMessage != null)
    {
      handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onBackgroundMessage( (message)
    async
    {

     } );


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event)
    {

      handleMessage(context, event);

    });

  }


  void handleMessage(BuildContext context, RemoteMessage message)
  {
  /* print("dfhdfgfgfghfhgkj");
   print(message.data['type']);
   print("dfhdfgfgfghfhgkj");
    if(int.parse(message.data['type'].toString()) <=3)
   {*/
     Get.to(() => CommunityDetails(cid: message.data['community_id'],));

     /* Navigator.push(context,
          MaterialPageRoute(builder: (context) => MessageScreen
          (
            id: message.data['id'] ,
          )));*/
   // }
  }


}