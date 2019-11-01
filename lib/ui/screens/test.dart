import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Card(
        child: Column(
          children: <Widget>[

              //mainAxisAlignment: MainAxisAlignment.center,

                Expanded(
                  child: Container(
                    child: Text("hello"),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text("hello"),
                  ),
                )
          ],
        )
      ),
    );
  }
}
