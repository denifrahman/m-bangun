import 'dart:convert';

import 'package:apps/provider/Dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;
  double persentase_odp;
  double persentase_pdp;
  double persentase_sehat;
  double persentase_positif;

  String Stringpersentase_odp;
  String Stringpersentase_pdp;
  String Stringpersentase_sehat;
  String Stringpersentase_positif;

  String Stringpersentase_odp_total;
  String Stringpersentase_pdp_total;
  String Stringpersentase_sehat_total;
  String Stringpersentase_positi_totalf;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() {
    Dashboard.getAlldata().then((value) {
      var result = json.decode(value.body);
      print(result);
      setState(() {
        persentase_odp = double.parse(result['persentase_odp'].toString());
        persentase_pdp = double.parse(result['persentase_pdp'].toString());
        persentase_sehat = double.parse(result['persentase_sehat'].toString());
        persentase_positif =
            double.parse(result['persentase_positif'].toString());

        Stringpersentase_odp =
            int.parse(result['persentase_odp'].toString()).toString();
        Stringpersentase_pdp =
            int.parse(result['persentase_pdp'].toString()).toString();
        Stringpersentase_sehat =
            int.parse(result['persentase_sehat'].toString()).toString();
        Stringpersentase_positif =
            int.parse(result['persentase_positif'].toString()).toString();

        Stringpersentase_odp_total = result['total_odp'];
        Stringpersentase_pdp_total = result['total_pdp'];
        Stringpersentase_sehat_total = result['total_sehat'];
        Stringpersentase_positi_totalf = result['total_positif'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2,
                child: persentase_positif == null
                    ? Container()
                    : PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections()),
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'Odp ($Stringpersentase_odp_total)',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xfff8b250),
                    text: 'Pdp ($Stringpersentase_pdp_total)',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.red,
                    text: 'Positif ($Stringpersentase_positi_totalf)',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff13d38e),
                    text: 'Sehat ($Stringpersentase_sehat_total)',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: persentase_positif.isNaN ? 0 : persentase_positif,
            title: '$Stringpersentase_positif%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: persentase_pdp.isNaN ? 0 : persentase_pdp,
            title: '$Stringpersentase_pdp%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: persentase_odp.isNaN ? 0 : persentase_odp,
            title: '$Stringpersentase_odp%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: persentase_sehat.isNaN ? 0 : persentase_sehat,
            title: '$Stringpersentase_sehat%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
