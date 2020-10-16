import 'package:apps/Utils/WidgetErrorConnection.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/widget/Aktivity/Pembelian/WidgetMenuPembelian.dart';
import 'package:apps/widget/Aktivity/Pengajuan/widgetPengajuanList.dart';
import 'package:apps/widget/Aktivity/Penjualan/WidgetMenuPenjualan.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAdsScreen extends StatefulWidget {
  final int indexPage;

  MyAdsScreen({Key key, this.indexPage}) : super(key: key);

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.animateTo(widget.indexPage == null ? 0 : widget.indexPage, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    AppBar appBar = AppBar(
      elevation: 0.0,
      backgroundColor: Colors.cyan[700],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Color(0xffb16a085),
              unselectedLabelColor: Colors.white,
              indicatorPadding: EdgeInsets.all(10),
              indicatorColor: Color(0xffb16a085),
              indicator: new BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: Colors.grey[200],
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: [
                Tab(
                  child: Text(
                    'Pembelian',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Tab(
                  child: Text(
                    'Penjualan',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pengajuan Saya',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Aktivitas Saya',
            style: TextStyle(fontSize: 25, letterSpacing: 1, fontFamily: "WorkSansMedium", color: Colors.white),
          ),
        ],
      ),
    );
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return !blocAuth.connection
        ? WidgetErrorConection()
        : !blocAuth.isLogin
            ? Container(
                color: Colors.white,
                child: LoginWidget(
                  primaryColor: Colors.white,
                  backgroundColor: Colors.white,
                  page: '/BottomNavBar',
                ),
              )
            : DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: appBar,
                  body: Container(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(child: WidgetMenuPembelian()),
                        Container(child: WidgetMenuPenjualan()),
                        Container(child: WidgetPengajuanList()),
                      ],
                    ),
                  ),
                ),
              );
  }
}
