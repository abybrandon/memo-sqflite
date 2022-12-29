import 'package:flutter/material.dart';

class Dummy extends StatelessWidget {
  final Color color;
  Dummy({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: color),
    );
  }
}
