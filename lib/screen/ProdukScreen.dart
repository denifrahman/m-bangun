import 'package:apps/providers/BlocProduk.dart';
import 'package:apps/widget/Produk/WidgetListProduk.dart';
import 'package:apps/widget/filter/WIdgetFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class ProdukScreen extends StatefulWidget {
  final String namaKategori;
  final String idSubKategori;

  ProdukScreen({Key key, this.namaKategori, this.idSubKategori})
      : super(key: key);

  @override
  _ProdukScreenState createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen>
    with TickerProviderStateMixin {
  AnimationController _hideFabAnimation;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    BlocProduk blocProduk = Provider.of<BlocProduk>(context);
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.namaKategori),
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
        body: blocProduk.isLoading
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PKCardListSkeleton(
//              totalLines: 1,
                      ),
                ),
              )
            : blocProduk.listProducts.isEmpty
                ? Center(
                    child: Text(
                    'Tidak ada produk ..',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ))
                : Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: WidgetListProduk(
                            idSubKategori: this.widget.idSubKategori,
                          ),
                        ),
                      ],
                    ),
                  ),
        floatingActionButton: ScaleTransition(
          scale: _hideFabAnimation,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteTransition(
                    animationType: AnimationType.slide_up,
                    builder: (context) => WidgetFilter(),
                  ));
            },
            backgroundColor: Color(0xffb16a085),
            tooltip: 'Filter',
            icon: Icon(Icons.filter_list),
            label: Text("Filter",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1)),
          ),
        ),
      ),
    );
  }
}
