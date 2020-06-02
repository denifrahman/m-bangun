import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/NewsM.dart';
import 'package:apps/provider/Api.dart';
import 'package:apps/screen/NewsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetNews extends StatefulWidget {
  WidgetNews({Key key}) : super(key: key);

  @override
  _WidgetNewsState createState() {
    return _WidgetNewsState();
  }
}

class _WidgetNewsState extends State<WidgetNews> {
  var dataNews = new List<NewsM>();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getToken() async {
    Api.getToken().then((value) {
      var data = json.decode(value.body);
      LocalStorage.sharedInstance
          .writeValue(key: 'token', value: data['data']['token']);
      _getKategori();
    });
  }

  void _getKategori() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllNews(token).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataNews = list.map((model) => NewsM.fromMap(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('News',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              InkWell(
                child: Text(
                  'Semua',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              itemCount: dataNews.length,
              itemBuilder: (context, index) {
                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () => _openDetailNews(dataNews[index]),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Image.network(
                            dataNews[index].newsthumbnail == null
                                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                : dataNews[index].newsthumbnail,
                            fit: BoxFit.cover,
                            width: 180,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 180,
                            padding: EdgeInsets.all(10),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              strutStyle: StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                  text: dataNews[index].newstitle),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                );
              }),
        )
      ],
    );
  }

  _openDetailNews(param) {
    Navigator.push(
        context,
        SlideRightRoute(
            page: NewsDetailScreen(
          title: param.newstitle,
          deskripsi: param.newsdeskripsi,
          tumbhnail: param.newsthumbnail,
        )));
  }
}
