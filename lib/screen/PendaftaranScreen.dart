import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:flutter/material.dart';

class PendaftaranScreen extends StatefulWidget {
  PendaftaranScreen({Key key}) : super(key: key);

  @override
  _PendaftaranScreenState createState() {
    return _PendaftaranScreenState();
  }
}

class _PendaftaranScreenState extends State<PendaftaranScreen> {
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
        title: Text('Pendaftaran'),
      ),
      body: WidgetPendaftaran(),
    );
  }
}
