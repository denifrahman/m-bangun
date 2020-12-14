import 'package:apps/providers/BlocChatting.dart';
import 'package:apps/screen/KonsultasiScreen/presentation/widgets/WidgetListBidangKeahlian.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KonsultasiScreen extends StatelessWidget {
  KonsultasiScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = Provider.of<BlocChatting>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat dengan ahlinya'),
      ),
        body:  ListBidangKeahlian());
  }
}
