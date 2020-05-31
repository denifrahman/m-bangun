import 'dart:convert';
import 'dart:io';
import 'package:apps/models/DataChart.dart';
import 'package:apps/models/StatusM.dart';
import 'package:apps/models/chekVersion.dart';
import 'package:apps/provider/Akun.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:apps/models/CountKota.dart';
import 'package:apps/models/ODP.dart';
import 'package:apps/models/PDP.dart';
import 'package:apps/models/Positif.dart';
import 'package:apps/models/Sehat.dart';
import 'package:apps/provider/Dashboard.dart';
import 'package:apps/widget/DashboardWidget/PieChart.dart';
import 'package:apps/widget/DashboardWidget/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
//import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
//  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    testDevices: testDevice != null ? <String>[testDevice] : null,
//    keywords: <String>['foo', 'bar'],
//    contentUrl: 'http://foo.com/bar.html',
//    childDirected: true,
//    nonPersonalizedAds: true,
//  );
//  InterstitialAd _interstitialAd;
//  InterstitialAd createInterstitialAd() {
//    return InterstitialAd(
//      adUnitId: 'ca-app-pub-4655963065602426/6814895332',
//      targetingInfo: targetingInfo,
//      listener: (MobileAdEvent event) {
//        print("InterstitialAd event $event");
//      },
//    );
//  }
//
//  BannerAd _bannerAd;
//  int _coins = 0;
//  BannerAd createBannerAd() {
//    return BannerAd(
//      adUnitId: "ca-app-pub-4655963065602426/4875460845",
//      size: AdSize.banner,
//      targetingInfo: targetingInfo,
//      listener: (MobileAdEvent event) {
//        print("BannerAd event $event");
//      },
//    );
//  }

  String newVersion;
  String deskripsi;
  String PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.idwebdesainer.c19';
  var dataChart = new List<DataChart>();
  var dataStatus = new List<StatusM>();
  var dataSehat = new List<Sehat>();
  var dataODP = new List<ODP>();
  var dataPDP = new List<PDP>();
  var dataPositif = new List<Positif>();
  var dataPerKota = new List<CountKota>();
  List<double> valueData = [];
  var labelData = [];
  DateTime dariDate = DateTime.now().add(Duration(days: -8));
  DateTime sampaiDate = DateTime.now();
  @override
  void initState() {
    super.initState();
//    FirebaseAdMob.instance
//        .initialize(appId: "ca-app-pub-4655963065602426~1945712030");
//    versionCheck(context);
//    _getData();
//    _getDataPerKota();
//    RewardedVideoAd.instance.load(
//        adUnitId: "ca-app-pub-4655963065602426/2815246043",
//        targetingInfo: targetingInfo);
//
//    RewardedVideoAd.instance.listener =
//        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
//      print("RewardedVideoAd event $event");
//      if (event == RewardedVideoAdEvent.rewarded) {
//        setState(() {
//          _coins += rewardAmount;
//        });
//      }
//    };
  }

  @override
  void dispose() {
    super.dispose();
//    _interstitialAd?.dispose();
  }

  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));
    print(currentVersion);
    Akun.getNewVersion().then((response) {
      final Map parsed = json.decode(response.body)['data'];
      final data = ChekVersion.fromMap(parsed);
      setState(() {
        newVersion = data.versionNumber;
        deskripsi = data.deksripsi;
      });
      double newVersionData =
          double.parse(data.versionNumber.trim().replaceAll(".", ""));
      if (newVersionData > currentVersion) {
        _showVersionDialog(context);
      } else {}
    });
  }

  _showVersionDialog(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    var currentVersion = info.version;
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Pembaruan baru tersedia";
        String message =
            "Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion";
        String btnLabel = "Perbarui";
        String btnLabelCancel = "Nanti";
        return !Platform.isIOS
            ? WillPopScope(
                onWillPop: () {},
                child: new CupertinoAlertDialog(
                  title: Text(title),
                  content: Column(
                    children: <Widget>[
                      Text(
                          "Pembaruan versi tersedia! $newVersion, versi saat ini adalah $currentVersion"),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(btnLabel),
                      onPressed: () => _launchURL(PLAY_STORE_URL),
                    ),
                  ],
                ))
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(PLAY_STORE_URL),
                  ),
                  FlatButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getData() {
    Dashboard.getGrafikPerBulan().then((value) {
      var result = json.decode(value.body);
      print(result);
      if (result['meta']['success'] == true) {
        setState(() {
          Iterable odp = result['data_odp'];
          dataODP = odp.map((model) => ODP.fromMap(model)).toList();
          Iterable sehat = result['data_sehat'];
          dataSehat = sehat.map((model) => Sehat.fromMap(model)).toList();
          Iterable positif = result['data_positif'];
          dataPositif = positif.map((model) => Positif.fromMap(model)).toList();
          Iterable pdp = result['data_pdp'];
          dataPDP = pdp.map((model) => PDP.fromMap(model)).toList();
//          Iterable data = result['data'];
//          dataChart = data.map((model) => DataChart.fromMap(model)).toList();
//          Iterable status = result['status'];
//          dataStatus = status.map((model) => StatusM.fromMap(model)).toList();
        });
      }
    });
  }

  _getDataPerKota() {
    Dashboard.getPerKota().then((value) {
      var result = json.decode(value.body);
      print(result['data_pdp']);
      if (result['meta']['success'] == true) {
        setState(() {
          Iterable data = result['data_pdp'];
          dataPerKota = data.map((model) => CountKota.fromMap(model)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//    final format = DateFormat.yMd().format(dariDate);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Dashboard'),
        actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.refresh),
//              onPressed: (){
//                _getData();
//              },
//            )
        ],
      ),
      body: SingleChildScrollView(
        child: dataSehat == null
            ? Container()
            : Container(
                padding: EdgeInsets.all(17),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Perhari',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('dari', style: TextStyle(fontSize: 11)),
                              Container(
                                width: 10,
                              ),
                              Text(
                                DateFormat('dd/MMM/yyyy')
                                    .format(dariDate)
                                    .toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                              IconButton(
                                  icon: Icon(Icons.date_range),
                                  onPressed: () => _dari(context)),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('Sampai', style: TextStyle(fontSize: 11)),
                              Container(
                                width: 10,
                              ),
                              Text(
                                  DateFormat('dd/MMM/yyyy')
                                      .format(sampaiDate)
                                      .toString(),
                                  style: TextStyle(fontSize: 12)),
                              IconButton(
                                  icon: Icon(Icons.date_range),
                                  onPressed: () => _sampai(context)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(child: Card(child: sample3())),
//              Container(
//                  child: Card(child: sample4())),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Persentase Global',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(child: PieChartSample2()),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Jumlah Perkota',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
//                                      RewardedVideoAd.instance.show();
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          barrierColor:
                                              Colors.grey.withOpacity(0.7),
                                          context: context,
                                          builder: (builder) {
                                            final format =
                                                DateFormat("yyyy-MM-dd");
                                            return new Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2.3,
                                                decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: new BorderRadius
                                                            .only(
                                                        topLeft: const Radius
                                                            .circular(10.0),
                                                        topRight: const Radius
                                                            .circular(10.0))),
                                                child: Column(
                                                  children: <Widget>[
                                                    Center(
                                                      child: Container(
                                                        decoration: new BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .all(
                                                                    const Radius
                                                                            .circular(
                                                                        10.0))),
                                                        width: 50,
                                                        height: 10,
                                                        margin: EdgeInsets.only(
                                                            top: 10, bottom: 5),
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      child: ListView.builder(
                                                          itemCount: dataPerKota
                                                              .length,
                                                          itemBuilder:
                                                              (context, i) {
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Text(dataPerKota[
                                                                          i]
                                                                      .namaKabkota),
                                                                  Indicator(
                                                                    color: Colors
                                                                        .green,
                                                                    text: dataPerKota[
                                                                            i]
                                                                        .Sehat,
                                                                    isSquare:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Indicator(
                                                                    color: Colors
                                                                        .blue,
                                                                    text: dataPerKota[
                                                                            i]
                                                                        .ODP,
                                                                    isSquare:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Indicator(
                                                                    color: Colors
                                                                        .orange,
                                                                    text: dataPerKota[
                                                                            i]
                                                                        .PDP,
                                                                    isSquare:
                                                                        true,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Indicator(
                                                                    color: Colors
                                                                        .red,
                                                                    text: dataPerKota[
                                                                            i]
                                                                        .POSITIF,
                                                                    isSquare:
                                                                        true,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ));
                                          });
                                    },
                                    child: Text(
                                      'Buka',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<Null> _dari(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: -8)),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dariDate)
      setState(() {
        dariDate = picked;
      });
  }

  Future<Null> _sampai(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != sampaiDate)
      setState(() {
        sampaiDate = picked;
      });
  }

  Widget sample3() {
    final toDate = sampaiDate;
    final fromDate = dariDate;
    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          fromDate: fromDate,
          bezierChartScale: BezierChartScale.WEEKLY,
          toDate: toDate,
          onIndicatorVisible: (val) {
            print("Indicator Visible :$val");
          },
          onDateTimeSelected: (datetime) {
            print("selected datetime: $datetime");
          },
          selectedDate: toDate,
          //this is optional
          footerDateTimeBuilder: (DateTime value, BezierChartScale scaleType) {
            final newFormat = intl.DateFormat('MMM');
            return newFormat.format(value);
          },
          series: [
            dataSehat.length != 0
                ? BezierLine(
                    label: "Sehat",
                    lineColor: Colors.green,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataSehat.map((e) {
                      return DataPoint<DateTime>(
                          value: double.parse(e.value),
                          xAxis: DateTime.parse(e.label));
                    }).toList())
                : BezierLine(
                    label: "Sehat",
                    lineColor: Colors.green,
                    dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataODP.length != 0
                ? BezierLine(
                    label: "ODP",
                    lineColor: Colors.blue,
                dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataODP.map((a) {
                      return DataPoint<DateTime>(
                          value: double.parse(a.value == null ? 0 : a.value),
                          xAxis: DateTime.parse(
                              a.label == null ? DateTime.now() : a.label));
                    }).toList())
                : BezierLine(
                    label: "ODP",
                    lineColor: Colors.blue,
                dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataPDP.length != 0
                ? BezierLine(
                    label: "PDP",
                    lineColor: Colors.orange,
                dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataPDP.map((d) {
                      return DataPoint<DateTime>(
                          value: double.parse(d.value),
                          xAxis: DateTime.parse(d.label));
                    }).toList())
                : BezierLine(
                    label: "PDP",
                    lineColor: Colors.orange,
                dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
            dataPositif.length != 0
                ? BezierLine(
                    label: "POSITIF",
                    lineColor: Colors.red,
                dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: dataPositif.map((q) {
                      return DataPoint<DateTime>(
                          value: double.parse(q.value),
                          xAxis: DateTime.parse(q.label));
                    }).toList())
                : BezierLine(
                    label: "POSITIF",
                    lineColor: Colors.red,
                dataPointFillColor: Colors.white,
                    lineStrokeWidth: 3,
                    data: [
                        DataPoint<DateTime>(value: 0, xAxis: DateTime.now()),
                      ]),
          ],
          config: BezierChartConfig(
            displayDataPointWhenNoValue: true,
            verticalIndicatorStrokeWidth: 3.0,
            pinchZoom: true,
            physics: ClampingScrollPhysics(),
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            displayYAxis: true,
            xAxisTextStyle: TextStyle(color: Colors.black, fontSize: 11),
            yAxisTextStyle: TextStyle(color: Colors.black, fontSize: 11),
            verticalIndicatorFixedPosition: true,
            backgroundColor: Colors.grey[300],
          ),
        ),
      ),
    );
  }

//SAMPLE DATE - MONTHLY

  Widget sample4() {
    final fromDate = DateTime(2017, 11, 22);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));

    final date3 = DateTime.now().subtract(Duration(days: 35));
    final date4 = DateTime.now().subtract(Duration(days: 36));

    final date5 = DateTime.now().subtract(Duration(days: 65));
    final date6 = DateTime.now().subtract(Duration(days: 64));

    return Center(
      child: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: BezierChart(
          bezierChartScale: BezierChartScale.MONTHLY,
          fromDate: fromDate,
          toDate: toDate,
          selectedDate: toDate,
          series: [
            BezierLine(
              label: "Duty",
              onMissingValue: (dateTime) {
                if (dateTime.month.isEven) {
                  return 10.0;
                }
                return 5.0;
              },
              data: [
                DataPoint<DateTime>(value: 10, xAxis: date1),
                DataPoint<DateTime>(value: 50, xAxis: date2),
                DataPoint<DateTime>(value: 20, xAxis: date3),
                DataPoint<DateTime>(value: 80, xAxis: date4),
                DataPoint<DateTime>(value: 14, xAxis: date5),
                DataPoint<DateTime>(value: 30, xAxis: date6),
              ],
            ),
          ],
          config: BezierChartConfig(
            verticalIndicatorStrokeWidth: 3.0,
            verticalIndicatorColor: Colors.black26,
            showVerticalIndicator: true,
            verticalIndicatorFixedPosition: false,
            backgroundColor: Colors.red,
            footerHeight: 35.0,
          ),
        ),
      ),
    );
  }
}
