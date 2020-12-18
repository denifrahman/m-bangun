import 'dart:async';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IntruksiPembayaran extends StatefulWidget {
  final url;

  IntruksiPembayaran({Key key, this.url}) : super(key: key);

  @override
  _IntruksiPembayaranState createState() => _IntruksiPembayaranState();
}

class _IntruksiPembayaranState extends State<IntruksiPembayaran> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  PDFDocument document;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    await new Future.delayed(const Duration(seconds: 3));
    document = await PDFDocument.fromURL(widget.url);
    // print(document);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cara Pembayaran'),
      ),
      body: Center(
        child:
        _isLoading
            ?
        Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1, //uncomment below line to preload all pages
              ),
      ),
    );
  }
}
