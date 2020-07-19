import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:apps/screen/SubKategoriScreen.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';

class KategoriScreenNew extends StatelessWidget {
  KategoriScreenNew({Key key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
      ),
      body: dataProvider.dataKategoriFlag == []
          ? SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: PKCardPageSkeleton(
                  totalLines: 4,
                ),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  itemCount: dataProvider.dataKategoriFlag.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () => openSubkategori(context, dataProvider.dataKategoriFlag[index]),
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.network(
                              dataProvider.dataKategoriFlag[index].produkkategorithumbnail,
                              width: 45,
                            ),
                            title: Text(dataProvider.dataKategoriFlag[index].produkkategorinama),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  void openSubkategori(context, param) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    print(param.produkkategoriflag);
    if (param.produkkategoriflag == '2' || param.produkkategoriflag == '3' || param.produkkategoriflag == '4') {
      Navigator.push(
          context,
          SlideRightRoute(
              page: SubKategoriScreen(
            flag: param.produkkategoriflag,
            idKategori: int.parse(param.produkkategoriid),
            namaKategori: param.produkkategorinama,
          )));
    } else {
      print(dataProvider.isLogin);
      if (dataProvider.isLogin) {
        print(dataProvider.userKategori);
        if (dataProvider.userKategori == param.produkkategorinama) {
          Navigator.push(
              context,
              SlideRightRoute(
                  page: SubKategoriScreen(
                    flag: param.produkkategoriflag,
                    idKategori: int.parse(param.produkkategoriid),
                    namaKategori: param.produkkategorinama,
                  )));
        } else {
          Flushbar(
            title: "Error",
            message: "Silahkan login / member anda tidak sesuai",
            duration: Duration(seconds: 15),
            backgroundColor: Colors.red,
            flushbarPosition: FlushbarPosition.BOTTOM,
            icon: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
          )..show(context);
        }
      } else {
        Navigator.push(context, SlideRightRoute(page: LoginScreen()));
      }
    }
  }
}
