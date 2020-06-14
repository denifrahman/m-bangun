import 'package:apps/Utils/navigation_right.dart';
import 'package:apps/widget/Pengajuan/WidgetPengajuanByParamList.dart';
import 'package:flutter/material.dart';

class WidgetPengajuanList extends StatefulWidget {
  WidgetPengajuanList({Key key}) : super(key: key);

  @override
  _WidgetPengajuanListState createState() {
    return _WidgetPengajuanListState();
  }
}

class _WidgetPengajuanListState extends State<WidgetPengajuanList> {
  var dataList = ['New', 'Review', 'Publish', 'Negosiasi', 'Progress', 'Finish'];

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
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: dataList.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () => _openPengajuan(dataList[index]),
              child: ListTile(
                  title: Text(dataList[index]),
                  leading: dataList[index] == 'New'
                      ? Icon(
                          Icons.new_releases,
                          color: Colors.blue,
                        )
                      : dataList[index] == 'Review'
                          ? Icon(
                              Icons.watch_later,
                              color: Colors.amber,
                            )
                          : dataList[index] == 'Publish'
                              ? Icon(
                                  Icons.backup,
                                  color: Colors.green,
                                )
                              : dataList[index] == 'Negosiasi'
                                  ? Icon(
                                      Icons.assignment,
                                      color: Color(0xffff7675),
                                    )
                                  : dataList[index] == 'Progress'
                                      ? Icon(
                                          Icons.work,
                                          color: Color(0xffff7675),
                                        )
                                      : Icon(Icons.done_all, color: Color(0xff00cec9)),
                  trailing: Icon(Icons.arrow_forward_ios)),
            ),
          );
        },
      ),
    );
  }

  _openPengajuan(param) {
    for (int i = 0; i < dataList.length; i++) {
      if (param == dataList[i]) {
        Navigator.push(
            context,
            SlideRightRoute(
                page: WidgetPengajuanByParamList(
              param: param,
            )));
      }
    }
  }
}
