import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class WidgetDeskripsiProduk extends StatelessWidget {
  const WidgetDeskripsiProduk({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      elevation: 2,
      colorCurve: Curves.easeInExpo,
      initiallyExpanded: true,
      leading: Icon(Icons.assignment),
      title: Text('Deskripsi'),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Rp 20.000.000',
                    style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.label,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('1 hourse ago'),
                  Spacer(),
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Surabaya'),
                  Spacer(),
                  Icon(
                    Icons.place,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Kontraktor'),
                  Spacer(),
                  Icon(
                    Icons.business,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
