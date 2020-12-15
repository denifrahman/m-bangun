import 'dart:convert';

import 'package:apps/Utils/SettingApp.dart';
import 'package:apps/Utils/SnacbarLauncher.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/Categories.dart';
import 'package:apps/screen/CheckoutScreenProject.dart';
import 'package:apps/screen/TopCardMenu/data/models/HeaderMenuModel.dart';
import 'package:apps/widget/Pendaftaran/WidgetPendaftaran.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderMenu extends StatelessWidget {
  HeaderMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final provider = Provider.of<BlogCategories>(context);
    return Container(
      decoration: BoxDecoration(color: Colors.cyan[700], borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          crossAxisCount: 3,
          children: List.generate(provider.listDataHeaderMenu.length, (j) {
            var item = provider.listDataHeaderMenu;
            return Card(
              child: InkWell(
                onTap: () {
                  onPress(context, item[j]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 60,
                        child: Container(
                          child: ClipOval(
                            child: new Center(
                              child: Image.network(
                                baseURL + '/' + pathBaseUrl + '/assets/kategori/' + provider.listDataHeaderMenu[j].icon,
                                // height: 80,
                                // width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, urlImage, error) {
                                  return Image.asset(
                                    'assets/logo.png',
                                    height: 80,
                                    width: 80,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          text: provider.listDataHeaderMenu[j].nama,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  onPress(context, HeaderMenuModel item) {
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    if (item.link == 'request') {
      if (blocAuth.currentUserLogin['email'] == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WidgetPendaftaran()));
        Flushbar(
          title:  "Kesahalan",
          message:  "Silahkan lengkapi profile anda terlebih dahulu",
          backgroundColor:Colors.red ,
          duration:  Duration(seconds: 5),
        )..show(context);
      } else {
        Navigator.pushNamed(context, '/' + item.link.toString()).then((value) {
          print(value);
          if (value != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreenProject(
                  body: value,
                  subtotal: int.parse(json.decode(value)['biaya_survey']),
                ),
              ),
            );
          }
        });
      }
    }else{
      Navigator.pushNamed(context, '/' + item.link.toString()).then((value) {
        if (value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreenProject(
                body: value,
                subtotal: int.parse(json.decode(value)['biaya_survey']),
              ),
            ),
          );
        }
      });
    }
  }
}
