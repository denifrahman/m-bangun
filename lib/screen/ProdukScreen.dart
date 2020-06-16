import 'package:apps/widget/Produk/WidgetListProduk.dart';
import 'package:apps/widget/WidgetSearch.dart';
import 'package:apps/widget/filter/WidgetButtonFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProdukScreen extends StatefulWidget {
  final String namaKategori;
  final String idSubKategori;

  ProdukScreen({Key key, this.namaKategori, this.idSubKategori}) : super(key: key);

  @override
  _ProdukScreenState createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> with TickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  AnimationController _hideFabAnimation;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideFabAnimation = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(this.widget.namaKategori),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.grey,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(height: 50, padding: EdgeInsets.only(bottom: 10), child: WidgetSearch()),
                    Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: MediaQuery.of(context).size.width,
                      child: WidgetListProduk(
                        idSubKategori: this.widget.idSubKategori,
                      ),
                    ),
                  ],
                ),
              ),
              ScaleTransition(
                scale: _hideFabAnimation,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WidgetButtonFilter(),
                    )),
              )
            ],
          ),
        ),
//        floatingActionButton: ScaleTransition(
//          scale: _hideFabAnimation,
//          alignment: Alignment.bottomCenter,
//          child: FloatingActionButton.extended(
//            onPressed: () {
//              Navigator.push(
//                  context,
//                  PageRouteTransition(
//                    animationType: AnimationType.slide_up,
//                    builder: (context) => WidgetFilter(),
//                  ));
//            },
//            backgroundColor: Color(0xffb16a085),
//            tooltip: 'Filter',
//            icon: Icon(Icons.filter_list),
//            label: Text("Filter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 1)),
//          ),
//        ),
      ),
    );
  }
}
