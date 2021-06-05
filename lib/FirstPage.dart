import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("First Page", style: TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
