import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/providers/Api.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';

class WidgetNewsDetail extends StatefulWidget {
  final String title;
  final String deskripsi;
  final String tumbhnail;
  final String id;

  WidgetNewsDetail({Key key, this.deskripsi, this.title, this.tumbhnail, this.id}) : super(key: key);

  @override
  _WidgetNewsDetailState createState() {
    return _WidgetNewsDetailState();
  }
}

class _WidgetNewsDetailState extends State<WidgetNewsDetail> {
  String Deskripsi = '';

  @override
  void initState() {
    super.initState();
    getNewsById();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getNewsById() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getNewsById(token, widget.id).then((value) {
      var result = json.decode(value.body)['data'];
      setState(() {
        Deskripsi = result['newsdeskripsi'];
      });
    });
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
                        text: widget.title),
                  ),
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
                      fit: BoxFit.fitWidth,
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
                          child: Html(
                            style: {
                              "html": Style(fontSize: FontSize(18)
//              color: Colors.white,
                                  ),
                              "h1": Style(textAlign: TextAlign.center, fontSize: FontSize(14)),
                              "table": Style(
                                backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                              ),
                              "tr": Style(
                                border: Border(bottom: BorderSide(color: Colors.grey)),
                              ),
                              "th": Style(
                                padding: EdgeInsets.all(6),
                                backgroundColor: Colors.grey,
                              ),
                              "td": Style(
                                padding: EdgeInsets.all(6),
                              ),
                              "var": Style(fontFamily: 'serif'),
                            },
                            customRender: {
                              "flutter": (RenderContext context, Widget child, attributes, _) {
                                return FlutterLogo(
                                  style: (attributes['horizontal'] != null) ? FlutterLogoStyle.horizontal : FlutterLogoStyle.markOnly,
                                  textColor: context.style.color,
                                  size: context.style.fontSize.size * 5,
                                );
                              },
                            },
                            shrinkWrap: true,
                            data: Deskripsi,
                          )),
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
