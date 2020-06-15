import 'package:apps/Utils/LocalBindings.dart';
import 'package:apps/screen/HomeScreen.dart';
import 'package:apps/screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:splashscreen/splashscreen.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key key}) : super(key: key);

  @override
  _SplaceScreenState createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  bool showIntro = false;

  @override
  void initState() {
    _getStting();
    super.initState();
  }

  _getStting() async {
    String themeData = await LocalStorage.sharedInstance.readValue('theme');
    if (themeData == null) {
      setState(() {
        showIntro = true;
      });
    } else {
      showIntro = false;
    }
  }

  @override
  Widget build(BuildContext context) {
//  return CustomSplash(
//    imagePath: 'assets/splace.gif',
//    backGroundColor: Colors.white,
////    animationEffect: 'zoom-out',
//    logoSize: 50,
//    home: LoginScreen3(),
//    duration: 4500,
//    type: CustomSplashType.StaticDuration,
//  );
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomeScreen(),
        image: new Image.asset(
          'assets/splace.gif',
          alignment: Alignment.center,
          width: 350,
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(color: Colors.green),
        photoSize: 200.0,
        loaderColor: Colors.white);
  }
}

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Sesnic",
        styleTitle: TextStyle(
            color: Colors.cyan,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/logo-icon.png",
      ),
    );
    slides.add(
      new Slide(
        title: "MUSEUM",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/logo.png",
      ),
    );
    slides.add(
      new Slide(
        title: "COFFEE SHOP",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Color(0xfffe9c8f),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/logo.png",
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        ModalRoute.withName('/portal'));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
