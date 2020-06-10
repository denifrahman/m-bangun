import 'package:apps/screen/BookingScreen.dart';
import 'package:apps/screen/HomeScreen.dart';
import 'package:apps/screen/InboxScreen.dart';
import 'package:apps/screen/KategoriScreen.dart';
import 'package:apps/screen/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  _openBoodking() {
    Navigator.of(context).push(PageRouteTransition(
        animationType: AnimationType.slide_up,
        builder: (context) => BookingScreen()));
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),

//        floatingActionButton: Container(
//          margin: EdgeInsets.only(top: 20),
//          child: FloatingActionButton(
//            tooltip: 'Booking',
//            backgroundColor:  Color(0xffb16a085),
//            foregroundColor: Colors.redAccent,
//            heroTag: Text('Book'),
//            child: Icon(
//              FontAwesomeIcons.stethoscope,
//              color: Colors.white,
//              size: 24,
//            ),
//            onPressed: () => _openBoodking(),
//          ),
//        ),
//        backgroundColor: Colors.grey[100],
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
//          shape: CircularNotchedRectangle(),
          notchMargin: 3,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          HomeScreen(); // if user taps on this dashboard tab will be active
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.home,
                        size: 18,
                        color: currentTab == 0
                            ? Color(0xffb16a085)
                            : Colors.grey[500],
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 11,
                          color: currentTab == 0
                              ? Color(0xffb16a085)
                              : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          KategoriScreen(); // if user taps on this dashboard tab will be active
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.layerGroup,
                        size: 18,
                        color: currentTab == 1
                            ? Color(0xffb16a085)
                            : Colors.grey[500],
                      ),
                      Text(
                        'Kategori',
                        style: TextStyle(
                          fontSize: 11,
                          color: currentTab == 1
                              ? Color(0xffb16a085)
                              : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          InboxScreen(); // if user taps on this dashboard tab will be active
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.boxOpen,
                        size: 18,
                        color: currentTab == 2
                            ? Color(0xffb16a085)
                            : Colors.grey[500],
                      ),
                      Text(
                        'My ADS',
                        style: TextStyle(
                          fontSize: 11,
                          color: currentTab == 2
                              ? Color(0xffb16a085)
                              : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 30,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          ProfileScreen(); // if user taps on this dashboard tab will be active
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 18,
                        color: currentTab == 3
                            ? Color(0xffb16a085)
                            : Colors.grey[500],
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 11,
                          color: currentTab == 3
                              ? Color(0xffb16a085)
                              : Colors.grey[500],
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
