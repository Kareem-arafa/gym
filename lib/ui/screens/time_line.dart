import 'package:flutter/material.dart';
import 'package:gym/ui/screens/post.dart';
import 'package:gym/models/post_list.dart';

int bookState = 0;
int loveState = 0;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post>p=PostList().getPost();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Home"),
        ),
        body: ListView.builder(
          itemCount: p.length,
          itemBuilder: (BuildContext context, int index) {
            return p[index];
          },

        )/*ListView.(
          children: p,

        )*/);
  }
}
