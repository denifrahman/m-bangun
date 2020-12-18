import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetViewPdf extends StatefulWidget {
  WidgetViewPdf({Key key, this.urlPdf}) : super(key: key);

  final String urlPdf;

  @override
  _WidgetViewPdfState createState() {
    return _WidgetViewPdfState();
  }
}

class _WidgetViewPdfState extends State<WidgetViewPdf> {
  bool _isLoading = true;
  PDFDocument document;
  @override
  void initState() {
    loadDocument();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  loadDocument() async {
    await new Future.delayed(const Duration(seconds: 3));
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    document = await PDFDocument.fromURL(baseURL + '/api/assets/pdf/file_rab_' + dataProvider.getdataProdukById['data'][0]['produkid'] + '.pdf');
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('RAB'),
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
