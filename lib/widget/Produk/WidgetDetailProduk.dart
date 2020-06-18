import 'package:apps/widget/Produk/component/WidgetDeskripsiProduk.dart';
import 'package:apps/widget/Produk/component/WidgetDetailBahanProduk.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class WidgetDetailProduk extends StatefulWidget {
  WidgetDetailProduk({Key key}) : super(key: key);

  @override
  _WidgetDetailProdukState createState() {
    return _WidgetDetailProdukState();
  }
}

class _WidgetDetailProdukState extends State<WidgetDetailProduk> {
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
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      collapseMode: CollapseMode.parallax,
                      title: Container(
                        padding: EdgeInsets.only(left: 50, right: 20),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          strutStyle: StrutStyle(fontSize: 14.0),
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 14,
                              ),
                              text: 'Title'),
                        ),
                      ),
                      background: Carousel(
                        autoplay: false,
                        overlayShadow: false,
                        noRadiusForIndicator: true,
                        images: [
                          Image.network(
                            'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg' ==
                                    null
                                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                : 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg',
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                        dotSize: 4.0,
                        dotSpacing: 15.0,
                        dotColor: Colors.lightGreenAccent,
                        indicatorBgPadding: 3.0,
                        dotBgColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      WidgetDeskripsiProduk(),
                      WidgetDetailBahanProduk(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.grey,
                  hoverColor: Colors.grey,
                  focusColor: Colors.grey,
                  onPressed: () {
                    print('love');
                  },
                ),
                Container(
                  child: Center(
                      child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  )),
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(color: Colors.cyan[600], borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
