import 'dart:async';
import 'dart:convert';
import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/models/ProdukListM.dart';
import 'package:apps/providers/Api.dart';
import 'package:apps/providers/DataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class WidgetApplyBidList extends StatefulWidget {
  final param;

  WidgetApplyBidList({Key key, this.param}) : super(key: key);

  @override
  _WidgetApplyBidListState createState() => _WidgetApplyBidListState();
}

class _WidgetApplyBidListState extends State<WidgetApplyBidList> {
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    Provider.of<DataProvider>(context).getProdukListByUserId(widget.param);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    var today = DateTime.now();
    initializeDateFormatting('in', null);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.param),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: ModalProgressHUD(
          inAsyncCall: dataProvider.isLoading,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 25,
                child: dataProvider.ListBidByUserIdAndStatusId.length == 0
                    ? Container(
                      child: Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.watch_later,
                              color: Colors.grey.withOpacity(0.4),
                              size: 50,
                            ),
                            Text('Tidak Ada Data')
                          ],
                        )),
                    )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataProvider.ListBidByUserIdAndStatusId.length,
                        itemBuilder: (context, index) {
                          DateTime bidCreate = DateTime.parse(dataProvider.ListBidByUserIdAndStatusId[index].bidcreate.toString());
                          return dataProvider.ListBidByUserIdAndStatusId.length != 0
                              ? InkWell(
//                      onTap: ()=>_getPedaftaranByPendaftaranId(dataProvider.ListBidByUserIdAndStatusId[index].pendaftaranId),
                                  child: Stack(
                                  children: <Widget>[
                                    Card(
                                      elevation: 2,
                                      margin: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        height: 90,
                                        decoration: BoxDecoration(color: Colors.cyan[500], borderRadius: BorderRadius.all(Radius.circular(10))),
                                        padding: EdgeInsets.all(5),
                                        child: ListTile(
                                          title: Text(
                                            dataProvider.ListBidByUserIdAndStatusId[index].produknama,
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                            maxLines: 2,
                                          ),
                                          subtitle: Text(DateFormat("EEE, dd MMMM yyyy", 'in').format(bidCreate),
                                              style: TextStyle(color: Colors.grey[300])),
                                          trailing: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              (dataProvider.ListBidByUserIdAndStatusId[index].statusnama == 'New' ||
                                                      dataProvider.ListBidByUserIdAndStatusId[index].statusnama == 'Review')
                                                  ? Icon(
                                                      FontAwesomeIcons.exclamationCircle,
                                                      color: Colors.amber,
                                                      size: 25,
                                                    )
                                                  : dataProvider.ListBidByUserIdAndStatusId[index].statusnama == 'Ditolak' ? Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ):Icon(
                                                FontAwesomeIcons.exclamationCircle,
                                                color: Colors.amber,
                                                size: 25,
                                              ),
                                              Text(
                                                dataProvider.ListBidByUserIdAndStatusId[index].statusnama,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 80.0),
                                      child: Card(
                                        elevation: 2,
                                        margin: EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                        ),
                                        child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                            padding: EdgeInsets.all(10),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: ListTile(
                                                title: Text(
                                                  dataProvider.ListBidByUserIdAndStatusId[index].bidprice == null
                                                      ? ''
                                                      : dataProvider.ListBidByUserIdAndStatusId[index].bidprice,
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                                subtitle: Text(
                                                    dataProvider.ListBidByUserIdAndStatusId[index].biddeskripsi == null
                                                        ? ''
                                                        : dataProvider.ListBidByUserIdAndStatusId[index].biddeskripsi,
                                                    style: TextStyle(color: Colors.grey[700])),
                                                trailing: Column(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: new BoxDecoration(
                                                          color: Colors.cyan[700], //new Color.fromRGBO(255, 0, 0, 0.0),
                                                          borderRadius: new BorderRadius.all(Radius.circular(100.0))),
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          dataProvider.ListBidByUserIdAndStatusId[index].bidwaktupengerjaan,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 18,
                                                              fontFamily: "WorkSansSemiBold",
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Bids',
                                                      style: TextStyle(fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ))
                              : Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Data tidak ada',
                                    style: TextStyle(color: Colors.black),
                                  ));
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
