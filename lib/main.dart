import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/ThemeChanger.dart';
import 'package:apps/models/DeviceInfo.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:apps/widget/DetailNotification/WidgetDetailNotification.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

const kAndroidUserAgent = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'https://flutter.io';
final Map<String, Item> _items = <String, Item>{};

Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))..status = data['status'];
  return item;
}

class Item {
  Item({this.itemId});

  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();

  Stream<Item> get onChanged => _controller.stream;

  String _status;

  String get status => _status;

  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};

  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => WidgetDetailNotification(
          itemId: itemId,
        ),
      ),
    );
  }
}

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  var initializationSettingsAndroid = AndroidInitializationSettings('ic_stat_name');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
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
//    print(BlocAuth().currentUser.email.toString());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider<BlogCategories>(
          create: (_) => BlogCategories(),
        ),
        ChangeNotifierProvider<BlocAuth>(
          create: (_) => BlocAuth(),
        ),
        ChangeNotifierProvider<BlocProduk>(
          create: (_) => BlocProduk(),
        ),
        ChangeNotifierProvider<BlocProfile>(
          create: (_) => BlocProfile(),
        ),
        ChangeNotifierProvider<BlocOrder>(
          create: (_) => BlocOrder(),
        ),
        ChangeNotifierProvider<BlocProject>(
          create: (_) => BlocProject(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Theme Provider',
        theme: light,
        home: SplashScreen(),
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginScreen(),
          '/request': (context) => RequestScreen(),
          '/profile': (context) => ProfileScreen(),
          '/BottomNavBar': (context) => BottomAnimateBar(),
          '/New': (context) => WidgetPengajuanByParamList(),
        },
      ),
    );
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
