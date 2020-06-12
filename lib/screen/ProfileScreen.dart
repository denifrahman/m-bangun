import 'dart:convert';

import 'package:apps/Utils/BottomAnimation.dart';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/provider/Api.dart';
import 'package:apps/screen/UpdateAkunScreen.dart';
import 'package:apps/widget/Login/LoginWidget.dart';
import 'package:apps/widget/Profile/WidgetProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  bool isLogin = true;
  String title = '';
  String id;
  String siup;
  String akte;
  String userKategori;
  String produkkategoriid;
  String useraktivasiakunpremium;
  String userSubKategori;
  bool _saving = false;
  bool _status = true;
  String fotoUrl = '';
  TextEditingController inputEmailController = new TextEditingController();
  TextEditingController inputNamaController = new TextEditingController();
  TextEditingController inputNoTelpController = new TextEditingController();
  TextEditingController inputPasswordController = new TextEditingController();
  TextEditingController inputPinController = new TextEditingController();
  TextEditingController inputAlamatController = new TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  void getUserData() async {
    String dataSession = await LocalStorage.sharedInstance.readValue('session');
    if (dataSession != null) {
      setState(() {
        _saving = true;
        isLogin = true;
        title = 'Profile';
      });
      setState(() {
        id = json.decode(dataSession)['data']['data_user']['userid'];
        inputEmailController.text =
            json.decode(dataSession)['data']['data_user']['useremail'];
        inputAlamatController.text =
            json.decode(dataSession)['data']['data_user']['akunpasien_email'];
        inputNamaController.text =
            json.decode(dataSession)['data']['data_user']['usernamalengkap'];
        inputNoTelpController.text =
            json.decode(dataSession)['data']['akunpasien_no_telpn'];
      });
      String fotoProfile = json.decode(
          dataSession)['data']['data_user']['userfoto'];
      print(fotoProfile);
      setState(() {
        fotoUrl = fotoProfile;
      });
      getProfile();
    } else {
      setState(() {
        isLogin = false;
        title = 'Silahkan login';
      });
    }

  }
  getProfile() async {
    String tokenValid = await LocalStorage.sharedInstance.readValue('token');
    Api.getUserById(tokenValid, id).then((response) {
      var data = json.decode(response.body);
      print(data['data_user']);
      setState(() {
        siup = data['data']['data_user']['usersiup'];
        akte = data['data']['data_user']['userakteperusahaan'];
        userKategori = data['data']['data_user']['produkkategorinama'];
        userSubKategori = data['data']['data_user']['produkkategorisubnama'];
        useraktivasiakunpremium = data['data']['data_user']['useraktivasiakunpremium'];
        produkkategoriid = data['data']['data_user']['produkkategoriid'];
        _saving = false;
      });
      print(produkkategoriid);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 20,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w700),),
              InkWell(
                  onTap: () => _openSetting(),
                  child: Icon(Icons.settings))
            ],
          ),
        ),
        body: !isLogin ? LoginWidget(
            primaryColor: Color(0xFFb16a085),
            backgroundColor: Colors.white,
            page: '/BottomNavBar'
        ) : ModalProgressHUD(
          inAsyncCall: _saving,
          child: Container(
            padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 10),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => _openProfile(),
                    child: ListTile(
                      title: Text(inputNamaController.text,
                        style: TextStyle(fontSize: 18),),
                      trailing: Icon(Icons.mode_edit),
                      subtitle: Text(inputEmailController.text),
                      leading: new Container(
                          width: 50.0,
                          height: 50.0,
                          child: ClipOval(
                              child: Image.network(fotoUrl == null
                                  ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                                  : fotoUrl,
                                fit: BoxFit.cover,
                                scale: 1,
                                width: 150,
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 20),
                        child: Text( userKategori != null ? 'Akun '+userSubKategori:'Aktivasi', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.grey),))
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        userKategori == null ? InkWell(
                          onTap: () => _openAkunPremium(),
                          child: ListTile(
                              title: Text('Akun Premium', style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),),
                              trailing: Icon(Icons.arrow_forward_ios, size: 14),
                              subtitle: Text('apa itu akun premium, selengkapnya'),
                              leading: Icon(Icons.spellcheck, size: 30,)
                          ),
                        ):Container(
                          width: MediaQuery.of(context).size.width,
                            child: produkkategoriid == '1' ? buildPreviewAkun():produkkategoriid == '4' ? buildPreviewAkun():Container()),
//                InkWell(
//                  onTap: ()=>_openSetting(),
//                  child: ListTile(
//                    title: Text('Setting', style: TextStyle( fontSize: 14,fontWeight: FontWeight.w500 ),),
//                    trailing: Icon(Icons.arrow_forward_ios, size: 14),
//                    leading: Icon(Icons.settings, size: 30,)
//                  ),
//                ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 0,
                    child: InkWell(
                      onTap: () => keluar(),
                      child: Container(
                        height: 50,
                        decoration: new BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: new BorderRadius.all(
                                Radius.circular(20))),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Keluar', style: TextStyle(fontSize: 15,
                                letterSpacing: 1,
                                fontFamily: "WorkSansBold",
                                fontWeight: FontWeight.w700,
                                color: Colors.red),)),
                      ),
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  Widget buildPreviewAkun(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Scan Surat Izin Usaha',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.grey),
          ),
          Container(
            height: 20,
          ),
          Image.network(
            siup ==
                null
                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                : siup,
            width: MediaQuery.of(context).size.width,
          ), Container(
            height: 20,
          ),
          Text(
            'Scan Akte Perusahaan',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.grey),
          ),
          Container(
            height: 20,
          ),
          Image.network(
            akte ==
                null
                ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                : akte,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
  void keluar() {
    LocalStorage.sharedInstance.deleteValue('session');
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return BottomAnimateBar();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
            (Route route) => false);
  }

  _openProfile() {
    Navigator.push(
      context,
      SlideRightRoute(page: WidgetProfile()),
    ).then((value) {
      getUserData();
      getProfile();
    });
  }

  _openSetting() {
//    Navigator.push(
//      context,
//      ScaleRoute(page: setting()),
//    );
  }

  _openAkunPremium() {
    Navigator.push(context, SlideRightRoute(page: UpdateAkunScreen()));
  }
}