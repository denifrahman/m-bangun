import 'package:apps/providers/DataProvider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class WidgetTagihan extends StatelessWidget {
  WidgetTagihan({Key key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    // TODO: implement build
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    AppBar appBar = AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.cyan[600],
      title: Text(
        'Metode Pembayaran',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.cyan[600],
              height: (height * 0.29) - appBar.preferredSize.height - statusBarHeight,
              width: width,
              child: Column(
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(width: 40, fit: BoxFit.fill, image: new AssetImage('assets/logo.png')),
                      )),
                  Text(
                    'm-Bangun',
                    style: TextStyle(fontFamily: 'SUNDAY', color: Colors.white, fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
              height: height * 0.71,
              child: dataProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataProvider.dataMetodeTransfer.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        dataProvider.getAllBank();
                        _showDialog(context, dataProvider.dataMetodeTransfer[index]);
                      },
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                          child: ListTile(
                            title: Text(dataProvider.dataMetodeTransfer[index].metodeTransferNama),
                            subtitle: Text(
                              dataProvider.dataMetodeTransfer[index].metodeTransferDeskripsi,
                              style: TextStyle(fontSize: 12),
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              margin: EdgeInsets.only(bottom: 6),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                gradient: new LinearGradient(
                                    colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                                    begin: const FractionalOffset(7.0, 10.1),
                                    end: const FractionalOffset(0.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                              child: new Center(
                                child: Image.network(
                                  dataProvider.dataMetodeTransfer[index].metodeTransferIcon,
                                  fit: BoxFit.cover,
                                  width: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(context, param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    if (dataProvider.userId_ == null) {
      Flushbar(
        title: "Error",
        message: "Silahkan login / daftar member",
        duration: Duration(seconds: 15),
        backgroundColor: Colors.red,
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(
          Icons.assignment_turned_in,
          color: Colors.white,
        ),
      )
        ..show(context);
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            autovalidate: false,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.7,
              padding: EdgeInsets.only(top: 0,),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Daftar Rekening Bank',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.clear))
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataProvider.dataBank.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: ListTile(
                                title: Text(dataProvider.dataBank[index].bankNama),
                                subtitle: Text(
                                  dataProvider.dataBank[index].bankNomorRek,
                                  style: TextStyle(fontSize: 12),
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(bottom: 6),
                                  decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    gradient: new LinearGradient(
                                        colors: [Color(0xffb16a085).withOpacity(0.1), Colors.white],
                                        begin: const FractionalOffset(7.0, 10.1),
                                        end: const FractionalOffset(0.0, 0.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                  ),
                                  child: new Center(
                                    child: Image.network(
                                      dataProvider.dataBank[index].bankLogo,
                                      fit: BoxFit.cover,
                                      width: 35,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {
                                    Clipboard.setData(new ClipboardData(text: dataProvider.dataBank[index].bankNomorRek));
                                    Flushbar(
                                      title: "Copied",
                                      message: "Rekening telah di copy",
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.grey,
                                      flushbarPosition: FlushbarPosition.BOTTOM,
                                      icon: Icon(
                                        Icons.content_copy,
                                        color: Colors.white,
                                      ),
                                    )
                                      ..show(context);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
