import 'dart:async';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

class PengajuanProject extends StatefulWidget {
  PengajuanProject({Key key}) : super(key: key);

  @override
  _PengajuanProjectState createState() => _PengajuanProjectState();
}

class _PengajuanProjectState extends State<PengajuanProject> {
  bool loading = true;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    loading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Pengajuan Proyek'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return WebviewScaffold(
            url: baseURLMobile + '/Projek?email=' + blocAuth.currentUserLogin['email'].toString(),
            withJavascript: true,
            displayZoomControls: false,
            withZoom: false,
            clearCache: true,
            javascriptChannels: <JavascriptChannel>[
              JavascriptChannel(
                  name: 'Print',
                  onMessageReceived: (JavascriptMessage msg) {
                    var result = msg.message;
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                  }),
            ].toSet(),
          );
        },
      ),
    );
  }
}
