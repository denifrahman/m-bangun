import 'package:carousel_pro/carousel_pro.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class WidgetNewsDetail extends StatefulWidget {
  final String title;
  final String deskripsi;
  final String tumbhnail;

  WidgetNewsDetail({Key key, this.deskripsi, this.title, this.tumbhnail})
      : super(key: key);

  @override
  _WidgetNewsDetailState createState() {
    return _WidgetNewsDetailState();
  }
}

class _WidgetNewsDetailState extends State<WidgetNewsDetail> {
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
      body: NestedScrollView(
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
                title: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  strutStyle: StrutStyle(fontSize: 14.0),
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                      ),
                      text: widget.title),
                ),
                background: Carousel(
                  autoplay: false,
                  overlayShadow: false,
                  noRadiusForIndicator: true,
                  images: [
                    Image.network(
                      widget.tumbhnail == null
                          ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                          : widget.tumbhnail,
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
                ExpansionTileCard(
                  initiallyExpanded: true,
                  title: Text(widget.title),
                  children: <Widget>[
                    Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          widget.deskripsi,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
