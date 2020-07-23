import 'package:apps/providers/DataProvider.dart';
import 'package:apps/screen/FavoriteScreen.dart';
import 'package:apps/screen/HomeScreen.dart';
import 'package:apps/screen/MyAdsScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:apps/screen/RequestScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';

class BottomAnimateBar extends StatefulWidget {
  @override
  _BottomAnimateBarState createState() => _BottomAnimateBarState();
}

class _BottomAnimateBarState extends State<BottomAnimateBar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    ProfileScreen(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen(); // Our first view in viewport

  _openRequest() {
    Navigator.push(
        context,
        PageRouteTransition(
          animationType: AnimationType.slide_up,
          builder: (context) => RequestScreen(),
        ));
  }

  Future<bool> _onWillPop() {
    if (currentTab == 0) {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Anda yakin!'),
              content: Text('Ingin keluar dari aplikasi?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  /*Navigator.of(context).pop(true)*/
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      setState(() {
        currentScreen = HomeScreen();
        currentTab = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 0),
          child: FloatingActionButton(
            tooltip: 'Panggil Tukang',
            backgroundColor: Color(0xfff9cf39),
            foregroundColor: Colors.redAccent,
            heroTag: Text('Book'),
            child: Image.asset(
              'assets/icons/worker.png',
              width: 25,
            ),
            onPressed: () => _openRequest(),
          ),
        ),
        backgroundColor: Colors.grey.withOpacity(0.3),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            dataProvider.getToken();
                            currentScreen = HomeScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.home,
                              size: 18,
                              color: currentTab == 0 ? Color(0xffb16a085) : Colors.grey[500],
                            ),
                            Text(
                              'Beranda',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 0 ? Color(0xffb16a085) : Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            dataProvider.getToken();
                            dataProvider.getAllFavoriteProdukByUserId();
                            currentScreen = FavoriteScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 18,
                              color: currentTab == 1 ? Color(0xffb16a085) : Colors.grey[500],
                            ),
                            Text(
                              'Favorit',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 1 ? Color(0xffb16a085) : Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          setState(() {
                            dataProvider.getToken();
                            currentScreen = MyAdsScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.boxOpen,
                              size: 18,
                              color: currentTab == 2 ? Color(0xffb16a085) : Colors.grey[500],
                            ),
                            Text(
                              'Aktivitas',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 2 ? Color(0xffb16a085) : Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 30,
                        onPressed: () {
                          dataProvider.getToken();
                          setState(() {
                            currentScreen = ProfileScreen(); // if user taps on this dashboard tab will be active
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 18,
                              color: currentTab == 3 ? Color(0xffb16a085) : Colors.grey[500],
                            ),
                            Text(
                              'Profil',
                              style: TextStyle(
                                fontSize: 11,
                                color: currentTab == 3 ? Color(0xffb16a085) : Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
