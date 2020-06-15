import 'package:flutter/material.dart';

class WidgetFilter extends StatelessWidget {
  WidgetFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
