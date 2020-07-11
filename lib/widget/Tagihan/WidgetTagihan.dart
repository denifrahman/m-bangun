import 'package:flutter/material.dart';

class WidgetTagihan extends StatelessWidget {
  WidgetTagihan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text('Transfer'),
                        subtitle: Text('Metode Transfer melalui ATM, MOBILE'),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
