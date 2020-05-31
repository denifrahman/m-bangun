import 'package:apps/widget/Home/kategori/WidgetCari.dart';
import 'package:apps/widget/Home/kategori/WidgetKategoriHome.dart';
import 'package:apps/widget/Home/kategori/WidgetLokasi.dart';
import 'package:apps/widget/Home/kategori/WidgetRecentUpload.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
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
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'M-Bangun',
            textAlign: TextAlign.left,
            style: TextStyle(fontFamily: 'OpenSans-Semibold'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                WidgetLokasi(),
                WidgetCari(),
                WidgetKategoriHome(),
                WidgetRecentUpload()
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.red,
          tooltip: 'Posting Iklan Anda',
          icon: Icon(Icons.add_a_photo),
          label: Text("New Ads"),
        )
    );
  }
}
