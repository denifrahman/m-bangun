import 'package:flutter/material.dart';
import 'package:apps/Utils/values/colors.dart';

class SearchBlankWidget extends StatelessWidget {
  void onBackPressed(BuildContext context) {}

  void onFilterPressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 145,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 44,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 44,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 32),
                                child: Text(
                                  "9:41",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontFamily: "SF Pro Display",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 18,
                                height: 12,
                                margin: EdgeInsets.only(right: 4),
                                child: Image.asset(
                                  "assets/images/cellular-connection-2-clipped.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                              Container(
                                width: 16,
                                height: 12,
                                margin: EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  "assets/images/wifi-2-clipped.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                              Container(
                                width: 25,
                                height: 12,
                                margin: EdgeInsets.only(right: 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 12,
                                        margin: EdgeInsets.only(right: 1),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              child: Image.asset(
                                                "assets/images/border-clipped-2.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                            Positioned(
                                              left: 2,
                                              right: 2,
                                              child: Image.asset(
                                                "assets/images/capacity-clipped.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 4,
                                      child: Image.asset(
                                        "assets/images/cap-clipped.png",
                                        fit: BoxFit.none,
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
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 20, top: 3, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 22,
                            height: 21,
                            margin: EdgeInsets.only(top: 9),
                            child: FlatButton(
                              onPressed: () => this.onBackPressed(context),
                              color: Color.fromARGB(0, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                              textColor: Color.fromARGB(255, 0, 0, 0),
                              padding: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/back.png",
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Text(
                              "Search",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w700,
                                fontSize: 34,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 20,
                            height: 14,
                            margin: EdgeInsets.only(top: 13),
                            child: FlatButton(
                              onPressed: () => this.onFilterPressed(context),
                              color: Color.fromARGB(0, 0, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                              ),
                              textColor: Color.fromARGB(255, 0, 0, 0),
                              padding: EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/filter.png",
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 45,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(17.5)),
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 272,
                height: 161,
                margin: EdgeInsets.only(top: 141),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 3,
                      right: 0,
                      child: Image.asset(
                        "assets/images/background-2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 49,
                      right: 10,
                      child: Image.asset(
                        "assets/images/objects.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 253,
                height: 116,
                margin: EdgeInsets.only(top: 25, right: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 22),
                        child: Text(
                          "No Result Found",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      child: Text(
                        "You didn't made any conversation yet,",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 1),
                        child: Text(
                          "please select username.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 77),
                        child: Text(
                          "Refine Search",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "SF Pro Display",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 130,
                height: 4,
                margin: EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentElement,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
