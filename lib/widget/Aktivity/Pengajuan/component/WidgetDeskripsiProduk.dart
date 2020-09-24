import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class WidgetDeskripsiProduk extends StatelessWidget {
  final String nama, created, lokasi, jenisLayanan;

  const WidgetDeskripsiProduk({Key key, this.nama, this.created, this.lokasi, this.jenisLayanan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      Jiffy(created).fromNow(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_time,
                      color: Colors.orange,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(jenisLayanan),
                    Spacer(),
                    Icon(
                      Icons.business,
                      color: Colors.red,
                    ),
                  ],
                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  children: [
//                    Text('Test'),
//                    Spacer(),
//                    Icon(
//                      Icons.date_range,
//                      color: Colors.blue,
//                    ),
//                  ],
//                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
