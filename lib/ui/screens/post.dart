import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final Widget head;
  final Widget body;
  final Widget footer;
  Post({this.body,this.footer,this.head});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          shadowColor: Colors.grey,
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              //header
              widget.head,
              //Body
              widget.body,
              //Footer
              widget.footer
            ],
          ),
        ),
      ),
    );
  }
}
