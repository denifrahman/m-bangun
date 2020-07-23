import 'dart:io';

import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/Properti.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/widget/Home/WidgetLokasi.dart';
import 'package:apps/widget/Home/WidgetNews.dart';
import 'package:apps/widget/home/WidgetHomeKategoriGroupFlag.dart';
import 'package:apps/widget/home/WidgetRecentProduk.dart';
import 'package:apps/widget/home/WidgetRecentProject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info/package_info.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  AnimationController _hideFabAnimation;
  String PLAY_STORE_URL = 'https://play.google.com/apps';
  String APP_STORE_URL = 'https://play.google.com/store/apps/details?id=com.bangun.apps';
  String namaProfile;
  String deskripsi;
  bool disabledTap = false;

  @override
  void initState() {
    super.initState();
    _hideFabAnimation = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
//    syncVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        _hideFabAnimation.forward();
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    _showVersionDialog();
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: WidgetLokasi(),
        ),
        body: dataProvider.isLoading
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PKCardListSkeleton(),
                ),
              )
            : !dataProvider.connection
                ? Center(
                    child: InkWell(
                        onTap: () {
                          dataProvider.getToken();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.network_check,
                              color: Colors.grey,
                              size: 50,
                            ),
                            Text('Tidak Ada Koneksi Internet'),
                            Container(
                              height: 10,
                            ),
                            Container(
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  dataProvider.getToken();
                                },
                                child: Text(
                                  'Coba Lagi',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 50),
                    color: Colors.white10.withOpacity(0.2),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          WidgetHomeKategoriGroupFlag(),
                          WidgetRecentProduk(),
                          dataProvider.userProdukKategoriSubId == null ? Container() : WidhetRecentProject(),
                          SizedBox(
                            height: 8,
                          ),
                          PropertiAds(),
                          WidgetNews(),
                        ],
                      ),
                    ),
                  ),
//        floatingActionButton: !dataProvider.connection
//            ? null
//            : ScaleTransition(
//                scale: _hideFabAnimation,
//                alignment: Alignment.bottomCenter,
//                child: FloatingActionButton.extended(
//                  onPressed: () => _openRequest(),
//                  backgroundColor: Color(0xffb16a085),
//                  tooltip: 'Posting Iklan Anda',
//                  icon: Icon(Icons.add_a_photo),
//                  label: Text("Request"),
//                ),
//              ),
      ),
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

  syncVersion() async {
    await new Future.delayed(const Duration(seconds: 1));
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var newVersion = await dataProvider.newVersion;
    if (newVersion > dataProvider.currentVersion) {
      _showVersionDialog();
    }
  }

  _showVersionDialog() async {
    await new Future.delayed(const Duration(seconds: 1));
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    final PackageInfo info = await PackageInfo.fromPlatform();
    var currentVersion = info.version;
    var newVersion = dataProvider.newVersion;
    if (dataProvider.showVersionDialog) {
      dataProvider.setShowVersionDialog(false);
      await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          String title = "Pembaruan baru tersedia";
          String message = "Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion";
          String btnLabel = "Perbarui";
          String btnLabelCancel = "Nanti";
          return Platform.isIOS
              ? WillPopScope(
            onWillPop: () {},
            child: new CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                children: <Widget>[
                  Text("Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion"),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () => _launchURL(APP_STORE_URL),
                ),
              ],
            ),
          )
              : WillPopScope(
            onWillPop: () {},
            child: new CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                children: <Widget>[
                  Text("Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion"),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(btnLabel),
                  onPressed: () => _launchURL(PLAY_STORE_URL),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
