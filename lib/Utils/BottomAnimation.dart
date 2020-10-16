import 'dart:async';

import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/ChekListScreen.dart';
import 'package:apps/screen/HomeScreen.dart';
import 'package:apps/screen/MyAdsScreen.dart';
import 'package:apps/screen/Notification.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:rxdart/subjects.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();
NotificationAppLaunchDetails notificationAppLaunchDetails;

class BottomAnimateBar extends StatefulWidget {
  @override
  _BottomAnimateBarState createState() => _BottomAnimateBarState();
}

class _BottomAnimateBarState extends State<BottomAnimateBar> {
  // Properties & Variables needed
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _topicController = TextEditingController(text: 'topic');
  String _homeScreenText = "Waiting for token...";
  bool _topicButtonsDisabled = false;

  @override
  void initState() {
    _requestIOSPermissions();
    _initializeTimer();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
//        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
//        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      await FlutterSession().set('fcm_token', token);
      assert(token != null);
    });
    super.initState();
  }

  Timer timer;

  void _initializeTimer() {
    timer = Timer.periodic(const Duration(seconds: 50), (__) {
      BlocOrder blocOrder = Provider.of<BlocOrder>(context);
      BlocAuth blocAuth = Provider.of<BlocAuth>(context);
      blocAuth.checkSession();
      blocOrder.setIdUser();
    });
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream.listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null ? Text(receivedNotification.title) : null,
          content: receivedNotification.body != null ? Text(receivedNotification.body) : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    print('select');
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationScreen()),
      );
    });
  }

  Future<void> _showNotification(message) async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['notification']['title'], message['notification']['body'], platformChannelSpecifics, payload: 'item x');
    blocAuth.getNotification();
  }

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    ProfileScreen(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen(); // Our first view in viewport
  void _showItemDialog(Map<String, dynamic> message) {
    print(message);
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message['notification']['title']),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah anda yakin ?'),
                Text('Menyelesaikan proyek ini'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Setuju'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _openRequest() {
    Navigator.push(
        context,
        PageRouteTransition(
          animationType: AnimationType.slide_up,
          builder: (context) => RequestScreen(),
        ));
  }

  Future<bool> _onWillPop() {
    if (currentTab == 0) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Anda yakin!'),
          content: Text('Ingin keluar dari aplikasi?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              /*Navigator.of(context).pop(true)*/
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
          false;
    } else {
      setState(() {
        currentScreen = HomeScreen();
        currentTab = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    int countAktivitas = 0;
    countAktivitas = blocOrder.countMenunggu +
        blocOrder.countMenungguKonfirmasi +
        blocOrder.countDikemas +
        blocOrder.countDikirim +
        blocOrder.countSaleMenungguKonfirmasi +
        blocOrder.countSaleDikemas +
        blocOrder.countSaleDikirim;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: Container(
          child: FloatingActionButton(
            onPressed: () {
              _openRequest();
            },
            tooltip: 'Panggil Tukang',
            backgroundColor: Colors.white,
            foregroundColor: Colors.redAccent,
            heroTag: Text('Book'),
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(bottom: 6, top: 6),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                gradient: new LinearGradient(
                    colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                    begin: const FractionalOffset(7.0, 10.1),
                    end: const FractionalOffset(0.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: new Center(
                child: Image(width: 35, fit: BoxFit.fill, image: new AssetImage('assets/logo.png')),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.3),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.cyan[700],
          shape: CircularNotchedRectangle(),
          notchMargin: 3,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            currentScreen = HomeScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  size: 25,
                                  color: currentTab == 0 ? Colors.white : Colors.grey[400],
                                ),
                              ],
                            ),
                            Text(
                              'Beranda',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 0 ? Colors.white : Colors.grey[400],
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
//                          blocAuth.checkSession();
                          blocOrder.getCart();
//                          blocOrder.getCountSaleByParam({'id_toko': blocAuth.idToko.toString()});
                          setState(() {
                            currentScreen = CheckListScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.shopping_cart,
                                  size: 25,
                                  color: currentTab == 1 ? Colors.white : Colors.grey[400],
                                ),
                                blocOrder.listCart.isEmpty
                                    ? Container()
                                    : Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                    alignment: Alignment.center,
                                    child: Text(
                                      blocOrder.listCart.length.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Keranjang',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 1 ? Colors.white : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 25, right: 15),
                    child: Text(
                      'Project',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 0, right: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            blocOrder.setIdUser();
                            currentScreen = MyAdsScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.local_activity,
                                  size: 25,
                                  color: currentTab == 2 ? Colors.white : Colors.grey[400],
                                ),
                                countAktivitas == 0
                                    ? Icon(
                                  Icons.local_activity,
                                  size: 25,
                                  color: currentTab == 2 ? Colors.white : Colors.grey[400],
                                )
                                    : new Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                                    alignment: Alignment.center,
                                    child: Text(
                                      countAktivitas.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              'Aktivitas',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 2 ? Colors.white : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            currentScreen = ProfileScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: 28,
                                  color: currentTab == 3 ? Colors.white : Colors.grey[400],
                                ),
                              ],
                            ),
                            Text(
                              'Profil',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 3 ? Colors.white : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
