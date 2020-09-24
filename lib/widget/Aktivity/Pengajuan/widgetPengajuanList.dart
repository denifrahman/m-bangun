import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/providers/BlocAuth.dart';
import 'package:apps/providers/BlocProject.dart';
import 'package:apps/widget/Aktivity/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetPengajuanList extends StatefulWidget {
  WidgetPengajuanList({Key key}) : super(key: key);

  @override
  _WidgetPengajuanListState createState() {
    return _WidgetPengajuanListState();
  }
}

class _WidgetPengajuanListState extends State<WidgetPengajuanList> {
  var dataList = ['Menunggu Pembayaran', 'Survey', 'Penawaran', 'Proses', 'Selesai'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
//        shrinkWrap: true,
        itemCount: dataList.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          var title = dataList[index].toString().toLowerCase();
          var statusProject = title == 'menunggu pembayaran' ? 'baru' : title == 'penawaran' ? 'setuju' : title == 'negosiasi' ? 'setuju' : title.toLowerCase();
          var statusPembayaran = title == 'menunggu pembayaran' ? 'menunggu_pembayaran' : title == 'penawaran' ? 'terbayar' : 'terbayar';
          return Card(
            child: InkWell(
              onTap: () => _openPengajuan(statusProject, statusPembayaran, title),
              child: ListTile(
                  title: Text(dataList[index]),
                  leading: dataList[index] == 'Menunggu Pembayaran'
                      ? Icon(
                          Icons.new_releases,
                          size: 30,
                          color: Colors.blue,
                        )
                      : dataList[index] == 'Penawaran'
                          ? Icon(
                              Icons.watch_later,
                              size: 30,
                              color: Colors.amber,
                            )
                          : dataList[index] == 'Survey'
                              ? Icon(
                                  Icons.backup,
                                  size: 30,
                                  color: Colors.green,
                                )
                              : dataList[index] == 'Negosiasi'
                                  ? Icon(
                                      Icons.account_balance_wallet,
                                      size: 30,
                                      color: Colors.red,
                                    )
                                  : dataList[index] == 'Proses'
                                      ? Icon(
                                          Icons.style,
                                          color: Colors.orange,
                                          size: 30,
                                        )
                                      : Icon(
                                          Icons.done_all,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
          );
        },
      ),
    );
  }

  _openPengajuan(statusProject, statusPembayaran, title) {
    BlocProject blocProject = Provider.of<BlocProject>(context);
    BlocAuth blocAuth = Provider.of<BlocAuth>(context);
    var param = {'id_user_login': blocAuth.idUser.toString(), 'status': statusProject.toString(), 'status_pembayaran_survey': statusPembayaran.toString()};
    print(param);
    blocProject.getProjectByParam(param);
    Navigator.push(context, SlideRightRoute(page: WidgetPengajuanByParamList(param: param, title: title)));
  }
}
