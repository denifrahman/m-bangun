import 'package:flutter/material.dart';

class KeranjangScreen extends StatefulWidget {
  KeranjangScreen({Key key}) : super(key: key);

  @override
  _KeranjangScreenState createState() {
    return _KeranjangScreenState();
  }
}

class _KeranjangScreenState extends State<KeranjangScreen> {
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
        title: Text('Keranjang'),
      ),
    );
  }
}
