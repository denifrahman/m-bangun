import 'dart:io';

import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/screen/TopCardMenu/presentation/pages/HeaderMenu.dart';
import 'package:apps/widget/Home/WidgetLokasi.dart';
import 'package:apps/widget/Home/WidgetNews.dart';
import 'package:apps/widget/home/WidgetIklanTokoLink.dart';
import 'package:apps/widget/home/WidgetOffialStore.dart';
import 'package:apps/widget/home/WidgetSLider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
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
  String PLAY_STORE_URL = 'https://play.google.com/apps';
  String APP_STORE_URL = 'https://play.google.com/store/apps/details?id=com.bangun.apps';
  String namaProfile;
  String deskripsi;
  bool disabledTap = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    _showVersionDialog();
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.cyan[700],
      elevation: 0,
      title: WidgetLokasi(),
    );
    double height = appBar.preferredSize.height;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Scaffold(
        appBar: appBar,
        body: !blocAuth.connection
            ? WidgetErrorConection()
            : ModalProgressHUD(
              inAsyncCall: Provider.of<BlocAuth>(context).isLoading,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                color: Colors.white10.withOpacity(0.2),
                child: Stack(
                  children: [
                    // HeaderAnimation(),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      height: MediaQuery.of(context).size.height - height - MediaQuery.of(context).padding.top - 50,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            HeaderMenu(),
                            WidgetIklanTokoLink(
                              blocProduk: blocProduk,
                            ),
                            WidgetSlider(
                              blocProduk: blocProduk,
                            ),
                            // ListChannel(),
                            WidgetOffialStore(
                              blocProduk: blocProduk,
                            ),
                            WidgetNews(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  _showVersionDialog() async {
//    await new Future.delayed(const Duration(seconds: 1));
    BlocAuth blocAuth = Provider.of(context);
    final PackageInfo info = await PackageInfo.fromPlatform();
    var currentVersion = info.version;
    var newVersion = blocAuth.newVersion;
    if (blocAuth.showVersionDialog) {
      blocAuth.setShowVersionDialog(false);
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

  Future<bool> onRefresh() async {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    final blocProduk = Provider.of<BlocProduk>(context);
    await blocAuth.checkSession();
    await blocAuth.getNotification();
    await blocProduk.getRecentProduct();
    await blocProduk.getOfficialStore();
    await blocProduk.getIklanTokoLink();
    await blocProduk.getIklan();
    await blocOrder.getCountSaleByParam(blocAuth.idToko.toString());
    return true;
  }
}
