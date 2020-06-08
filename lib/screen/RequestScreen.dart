import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Pengajuan/WidgetPengajuan.dart';
import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({Key key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  bool isLogin = false;
  String title = '';

  @override
  void initState() {
//    LocalStorage.sharedInstance.deleteValue('session');
    _chekSession();
    super.initState();
  }

  _chekSession() async {
    String session = await LocalStorage.sharedInstance.readValue('session');
    print(session);
    if (session != null) {
      setState(() {
        isLogin = true;
        title = 'Buat Permintaan';
      });
    } else {
      setState(() {
        isLogin = false;
        title = 'Silahkan login';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: !isLogin
            ? LoginWidget(
                primaryColor: Color(0xFFb16a085),
                backgroundColor: Colors.white,
                page: '/request',
              )
            : WidgetPengajuan(),
      ),
    );
  }
}
