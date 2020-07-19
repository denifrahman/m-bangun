import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/models/NewsM.dart';
import 'package:apps/providers/Api.dart';
import 'package:apps/screen/NewsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_animations/loading_animations.dart';

class WidgetNews extends StatefulWidget {
  WidgetNews({Key key}) : super(key: key);

  @override
  _WidgetNewsState createState() {
    return _WidgetNewsState();
  }
}

class _WidgetNewsState extends State<WidgetNews> {
  var dataNews = new List<NewsM>();
  bool _saving = false;

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
    setState(() {
      _saving = true;
    });
    Api.getToken().then((value) {
      var data = json.decode(value.body);
      LocalStorage.sharedInstance.writeValue(key: 'token', value: data['data']['token']);
      _getAllNews();
    });
  }

  void _getAllNews() async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllNews(token).then((response) {
      Iterable list = json.decode(response.body)['data'];
      setState(() {
        dataNews = list.map((model) => NewsM.fromMap(model)).toList();
        _saving = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        dataNews.isEmpty
            ? Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(child: LoadingDoubleFlipping.square(size: 30, backgroundColor: Colors.red)),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('News', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'SUNDAY')),
                      InkWell(
                        child: Text(
                          'Semua',
                          style: TextStyle(fontSize: 12, color: Color(0xffb16a085)),
                        ),
                      ),
                    ],
                  ),
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
                          flex: 2,
                          child: Image.network(
                            dataNews[index].newsthumbnail == null
                                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                : dataNews[index].newsthumbnail,
                            fit: BoxFit.cover,
                            width: 150,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 150,
                            padding: EdgeInsets.all(10),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              strutStyle: StrutStyle(fontSize: 10.0),
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 12
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
                id: param.newsid
            )));
  }
}
