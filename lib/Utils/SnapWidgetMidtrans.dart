import 'dart:async';
import 'dart:convert';

import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/widget/Invoice/WidgetWaitingPayment.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWidgetMidtrans extends StatefulWidget {
  final urlSnap;
  final tokenSnap;
  final bodyTransaction;
  final param;

  SnapWidgetMidtrans({Key key, this.urlSnap, this.tokenSnap, this.bodyTransaction, this.param}) : super(key: key);

  @override
  _SnapWidgetMidtransState createState() {
    return _SnapWidgetMidtransState();
  }
}

class _SnapWidgetMidtransState extends State<SnapWidgetMidtrans> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String url = "";
  double progress = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  bool buttonBack = true;
  Timer timer;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.urlSnap);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rincian Pembelian',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        elevation: 0,
        leading: Container(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: WebView(
              initialUrl: widget.urlSnap,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (url) {
                print(url);
              },
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage msg) {
                      var result = json.decode(msg.message);
                      print(result);
                      print('insert');
                      if (result['transaction_status'] != null) {
                        if (widget.param == 'project') {
                          var decodeData = json.decode(widget.bodyTransaction['data']);
                          Navigator.push(
                            context,
                            SlideRightRoute(
                              page: WidgetWaitingPayment(idOrder: decodeData['no_order'].toString(), body: widget.bodyTransaction, param: widget.param),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            SlideRightRoute(
                              page: WidgetWaitingPayment(idOrder: widget.bodyTransaction['data_order']['no_order'].toString(), body: widget.bodyTransaction, param: widget.param),
                            ),
                          );
                        }
                      }
                    }),
              ].toSet(),
            ),
          ),
        ],
      ),
    );
  }
}
