import 'package:flutter/material.dart';

class ButtonSmall extends StatelessWidget {
  ButtonSmall({Key key ,this.onPressed, this.title, this.color}) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 30,
        width: 70,
        decoration: BoxDecoration(
        color: color,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: FlatButton(onPressed: onPressed, child: Text(title, style: TextStyle(color: Colors.white),),color: color,));
  }
}
