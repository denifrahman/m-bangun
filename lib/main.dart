import 'dart:io';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/ThemeChanger.dart';
import 'package:apps/screen/ActivityScreen.dart';
import 'package:apps/screen/DasboardScreen.dart';
import 'package:apps/screen/HistoryScreen.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
//  double getSmartBannerHeight(MediaQueryData mediaQuery) {
//    // https://developers.google.com/admob/android/banner#smart_banners
//    if (Platform.isAndroid) {
//      if (mediaQuery.size.height > 720) return 90.0;
//      if (mediaQuery.size.height > 400) return 50.0;
//      return 32.0;
//    }
//    // https://developers.google.com/admob/ios/banner#smart_banners
//    // Smart Banners on iPhones have a height of 50 points in portrait and 32 points in landscape.
//    // On iPads, height is 90 points in both portrait and landscape.
//    if (Platform.isIOS) {
//      // TODO use https://pub.dartlang.org/packages/device_info to detect iPhone/iPad?
//      // if (iPad) return 90.0;
//      if (mediaQuery.orientation == Orientation.portrait) return 50.0;
//      return 32.0;
//    }
//    // No idea, just return a common value.
//    return 50.0;
//  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Theme Provider',
            theme: light,
            home: BottomAnimateBar(),
            initialRoute: '/',
            routes: {
              '/splace-screen': (context) => SplaceScreen(),
              '/login': (context) => LoginScreen(),
              '/dashboard': (context) => DashboardScreen(),
              '/activity': (context) => ActivityScreen(),
              '/history': (context) => HistoryScreen(),
              '/profile': (context) => ProfileScreen(),
            },
//            builder: (BuildContext context, Widget widget) {
//              final mediaQuery = MediaQuery.of(context);
//              return new Padding(
//                child: widget,
//                padding: new EdgeInsets.only(
//                    bottom: getSmartBannerHeight(mediaQuery)),
//              );
//            },
          );
        },
      ),
    );
  }
}






