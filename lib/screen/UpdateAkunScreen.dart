import 'package:apps/widget/Profile/WidgetUpdateAkun.dart';
import 'package:flutter/material.dart';

class UpdateAkunScreen extends StatelessWidget {
  UpdateAkunScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Update Akun'),
      ),
      body: WidgetUpdateAkun(),
    );
  }
}
