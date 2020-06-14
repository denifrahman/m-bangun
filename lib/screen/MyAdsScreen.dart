import 'package:apps/widget/Pengajuan/widgetPengajuanList.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';

class MyAdsScreen extends StatefulWidget {
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
//        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
//          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  labelColor: Color(0xffb16a085),
                  unselectedLabelColor: Colors.grey,
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
                style: TextStyle(fontSize: 25, letterSpacing: 1, fontFamily: "WorkSansMedium"),
              ),
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              Container(child: WidgetPengajuanList()),
            ],
          ),
        ),
      ),
    );
  }
}
