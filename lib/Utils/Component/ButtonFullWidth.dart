import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ButtonFullWidth extends StatelessWidget {
  ButtonFullWidth({Key key, this.onPressed, this.title, this.color, this.btnController}) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final RoundedLoadingButtonController btnController;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      height: 50,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
              height: 40,
              child: RoundedLoadingButton(
                child: Text(title, style: TextStyle(color: Colors.white)),
                color: color,
                controller: btnController,
                onPressed: onPressed
              )),
        ],
      ),
    );
  }
}
