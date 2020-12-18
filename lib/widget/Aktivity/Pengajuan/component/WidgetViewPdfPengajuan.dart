import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetViewPdfPengajuan extends StatefulWidget {
  WidgetViewPdfPengajuan({Key key, @required this.urlPdf, @required this.title}) : super(key: key);
  final String urlPdf;
  final String title;

  @override
  _WidgetViewPdfPengajuanState createState() {
    return _WidgetViewPdfPengajuanState();
  }
}

class _WidgetViewPdfPengajuanState extends State<WidgetViewPdfPengajuan> {
  bool _isLoading = true;
  PDFDocument document;
  Stream<FileResponse> fileStream;

  @override
  void initState() {
    DefaultCacheManager().emptyCache();
    loadDocument();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadDocument() async {
    await new Future.delayed(const Duration(seconds: 3));
    document = await PDFDocument.fromURL(widget.urlPdf);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(
                  Icons.cloud_download,
                  color: Colors.cyan[700],
                ),
                onPressed: () async {
                  var url = widget.urlPdf;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
          )
        ],
      ),
      body: Center(
        child:
        _isLoading
            ?
        Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
              ),
      )
    );
  }
}
