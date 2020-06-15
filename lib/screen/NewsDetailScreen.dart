import 'package:apps/widget/News/WidgetNewsDetail.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String deskripsi;
  final String tumbhnail;
  final String id;

  NewsDetailScreen({Key key, this.deskripsi, this.title, this.tumbhnail, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WidgetNewsDetail(title: this.title, deskripsi: this.deskripsi, tumbhnail: this.tumbhnail,
        id: this.id
    );
  }
}
