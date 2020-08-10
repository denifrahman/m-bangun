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
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
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
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    return !dataProvider.connection
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
