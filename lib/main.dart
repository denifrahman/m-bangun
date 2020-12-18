import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/MultiProviders.dart';
import 'package:apps/Utils/ThemeChanger.dart';
import 'package:apps/Utils/routes.dart';
import 'package:apps/models/DeviceInfo.dart';
import 'package:apps/providers/BlocChatService.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  var initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_name');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  await Firebase.initializeApp();
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}
//runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        await FlutterSession().set('deviceData', json.encode(deviceData));
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        await FlutterSession().set('deviceData', json.encode(deviceData));
      }
    } on PlatformException {
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProviders,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Theme Provider',
          theme: light,
          // builder: (context, widget) {
          //   return Consumer<ChatModel>(builder: (context, chatModel, child) {
          //     return StreamChat(
          //       streamChatThemeData: StreamChatThemeData.fromTheme(light).copyWith(
          //         ownMessageTheme: MessageTheme(
          //           messageBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
          //           messageText: TextStyle(
          //             color: Colors.white,
          //           ),
          //           avatarTheme: AvatarTheme(
          //               // borderRadius: BorderRadius.circular(8),
          //               ),
          //         ),
          //         otherMessageTheme: MessageTheme(
          //           messageBackgroundColor: Theme.of(context).primaryColor,
          //           messageText: TextStyle(
          //             color: Colors.white,
          //           ),
          //           avatarTheme: AvatarTheme(
          //               // borderRadius: BorderRadius.circular(8),
          //               ),
          //         ),
          //       ),
          //       child: widget,
          //       client: chatModel.client,
          //     );
          //   });
          // },
          home: SplashScreen(),
          initialRoute: '/',
          routes: routes),
    );
  }
}

