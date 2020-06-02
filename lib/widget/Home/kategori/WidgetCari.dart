import 'dart:convert';

import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/provider/Api.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class WidgetCari extends StatefulWidget {
  WidgetCari({Key key}) : super(key: key);

  @override
  _WidgetCariState createState() {
    return _WidgetCariState();
  }
}

class _WidgetCariState extends State<WidgetCari> {
  var dataProdukList = new List<ProdukListM>();
  String idKecamatan = '';
  String idKota = '';
  String idProvinsi = '';
  String idSubKategori = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getProdukByParam(key) async {
    String token = await LocalStorage.sharedInstance.readValue('token');
    Api.getAllProdukByParam(
            token, idKecamatan, idKota, idProvinsi, idSubKategori, key)
        .then((response) {
      var result = json.decode(response.body)['data'];
      if (result == []) {
        setState(() {
          dataProdukList = [];
        });
      } else {
        Iterable list = json.decode(response.body)['data'];
        setState(() {
          dataProdukList =
              list.map((model) => ProdukListM.fromMap(model)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Cari'),
//      ),
        body: FloatingSearchBar.builder(
          pinned: true,
          itemCount: dataProdukList.length,
          padding: EdgeInsets.only(top: 10.0),
          itemBuilder: (BuildContext context, int j) {
            var harga = dataProdukList[j].produkharga;
            return Container(
              height: 320,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () => _openDetailNews(dataProdukList[j]),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: ListTile(
                          title: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            strutStyle:
                            StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 11
                              ),
                              text: '${dataProdukList[j].produknama}',),
                          ),
                          trailing: Icon(Icons.favorite_border, size: 14,),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          dataProdukList[j].produkthumbnail == null
                              ? 'https://previews.123rf.com/images/urfandadashov/urfandadashov1809/urfandadashov180901275/109135379-photo-not-available-vector-icon-isolated-on-transparent-background-photo-not-available-logo-concept.jpg'
                              : dataProdukList[j].produkthumbnail,
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: ListTile(
                            title: Row(
                              children: <Widget>[
                                Text('Rp ', style: TextStyle(fontSize: 12),),
                                Text(harga == null ? '-' : harga,
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            subtitle: Text(
                              Jiffy(dataProdukList[j].produkcreate).fromNow(),
                              style: TextStyle(fontSize: 10),),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
            );
          },
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)},),
          onChanged: (String value) => _onSearch(value),
          onTap: () {},
          decoration: InputDecoration.collapsed(
            hintText: "Search...",
          ),
        )
    );
  }

  _onSearch(String value) {
    if (value.isNotEmpty) {
      _getProdukByParam(value);
    }
    {
      setState(() {
        dataProdukList = [];
      });
    }
  }

  _openDetailNews(ProdukListM dataProdukList) {}
}