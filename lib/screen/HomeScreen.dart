import 'package:apps/screen/RequestScreen.dart';
import 'package:apps/widget/Home/WidgetKategoriHome.dart';
import 'package:apps/widget/Home/WidgetLokasi.dart';
import 'package:apps/widget/Home/WidgetNews.dart';
import 'package:apps/widget/WidgetSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:route_transitions/route_transitions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();
  AnimationController _hideFabAnimation;

  @override
  void initState() {
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
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
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
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
    return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: WidgetLokasi(),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: WidgetSearch(),
                    ),
                    WidgetNews(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WidgetKategoriHome(),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: ScaleTransition(
              scale: _hideFabAnimation,
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton.extended(
                onPressed: () => _openRequest(),
                backgroundColor: Color(0xffb16a085),
                tooltip: 'Posting Iklan Anda',
                icon: Icon(Icons.add_a_photo),
                label: Text("Request"),
              ),
            )
        )
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
}
