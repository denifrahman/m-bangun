import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/ThemeChanger.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/screen/SplashScreen.dart';
import 'package:apps/widget/Aktivity/WidgetPengajuanByParamList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (_) => DataProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Theme Provider',
        theme: light,
        home: SplashScreen(),
        initialRoute: '/',
        routes: {
//          '/splace-screen': (context) => SplaceScreen(),
          '/login': (context) => LoginScreen(),
          '/request': (context) => RequestScreen(),
          '/profile': (context) => ProfileScreen(),
          '/BottomNavBar': (context) => BottomAnimateBar(),
          '/New': (context) => WidgetPengajuanByParamList(),
        },
//            builder: (BuildContext context, Widget widget) {
//              final mediaQuery = MediaQuery.of(context);
//              return new Padding(
//                child: widget,
//                padding: new EdgeInsets.only(
//                    bottom: getSmartBannerHeight(mediaQuery)),
//              );
//            },
      ),
    );
  }
}
