import 'dart:async';

import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocOrder.dart';
import 'package:apps/providers/BlocProfile.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetDetailPengajuanKontrak.dart';
import 'package:apps/widget/Tagihan/WidgetTagihanProject.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:money2/money2.dart';
import 'package:provider/provider.dart';
import 'package:sup/sup.dart';

class WidgetPengajuanByParamList extends StatefulWidget {
  final Map<String, String> param;
  final title;

  WidgetPengajuanByParamList({Key key, this.param, this.title}) : super(key: key);

  @override
  _WidgetPengajuanByParamListState createState() => _WidgetPengajuanByParamListState();
}

class _WidgetPengajuanByParamListState extends State<WidgetPengajuanByParamList> {
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
    print(widget.param);
    Provider.of<BlocProject>(context).getProjectByParam(widget.param);
    print(widget.param);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    BlocProject blocProject = Provider.of<BlocProject>(context);
    BlocOrder blocOrder = Provider.of<BlocOrder>(context);
    BlocProfile blocProfile = Provider.of<BlocProfile>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var today = DateTime.now();
    initializeDateFormatting('in', null);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final IDR = Currency.create('IDR', 0, symbol: 'Rp', invertSeparators: true, pattern: 'S ###.###');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title),
      ),
      body: ModalProgressHUD(
        inAsyncCall: blocProject.isLoading,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 25,
              child: RefreshIndicator(
                onRefresh: refreshList,
                key: refreshKey,
                child: blocProject.listProjects.length == 0
                    ? Center(
                        child: Sup(
                          title: Text('Belum ada proyek !!!'),
                          image: Image.asset(
                            'assets/img/sad.png',
                            height: 150,
                          ),
                          subtitle: Text('Ajukan proyek sekarang'),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: blocProject.listProjects.length,
                        itemBuilder: (context, index) {
                          var noOrder = blocProject.listProjects[index].noOrder;
                          DateTime tanggal_booking = DateTime.parse(blocProject.listProjects[index].tglMaxBid.toString());
                          var budget = blocProject.listProjects[index].budget;
                          var budgetFormat = Money.fromInt(budget == null ? 0 : int.parse(budget), IDR);
                          return InkWell(
                            onTap: () {
                              if (widget.param['status_pembayaran_survey'] == 'menunggu_pembayaran') {
                                var param = {
                                  'no_order': noOrder.toString(),
                                };
                                blocOrder.getProjectByOrder(param);
                                blocOrder.getTransaksiStatus(blocProject.listProjects[index].noOrder);
                                Navigator.push(context, SlideRightRoute(page: WidgetTagihanProject())).then((value) {
                                  blocProject.getProjectByParam(widget.param);
                                });
                              } else {
                                blocProject.getProjectByOrder({
                                  'no_order': noOrder.toString(),
                                });
                                blocProject.getTagihanByParam({'id_proyek': blocProject.listProjects[index].id});
                                blocProfile.getSubDistrictById(blocProject.listProjects[index].idKecamatan);
                                Navigator.push(
                                    context,
                                    SlideRightRoute(
                                        page: WidgetDetailPengajuanKontrak(
                                      param: widget.param,
                                    ))).then((value) {
                                  blocProject.getProjectByParam(widget.param);
                                });
                              }
                            },
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  elevation: 2,
                                  margin: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.cyan[500], borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                    padding: EdgeInsets.all(5),
                                    child: ListTile(
                                      title: Text(
                                        blocProject.listProjects[index].nama,
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                                        maxLines: 2,
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          (blocProject.listProjects[index].status == 'baru' || blocProject.listProjects[index].status == 'survey')
                                          ? Icon(
                                        FontAwesomeIcons.exclamationCircle,
                                        color: Colors.amber,
                                        size: 20,
                                      )
                                          : Icon(
                                        FontAwesomeIcons.solidCheckCircle,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        blocProject.listProjects[index].status,
                                        style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 60.0),
                              child: Card(
                                  elevation: 2,
                                  margin: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100], borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ListTile(
                                        title: Container(
                                          height: 70,
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Html(
                                            data: blocProject.listProjects[index].deskripsi == null ? '' : blocProject.listProjects[index].deskripsi,
                                          ),
                                        ),
                                        subtitle: Text(
                                          DateFormat("EEE, dd MMMM yyyy", 'in').format(tanggal_booking),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 75.0, left: 20, right: 15),
                              child: DottedLine(
                                dashLength: 10,
                                lineThickness: 2,
                                dashColor: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
