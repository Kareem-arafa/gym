import 'package:flutter/material.dart';
import 'package:gym/models/user.dart';

class ListContent extends StatefulWidget {

  final String name;
  final String city;
 final String url;
 final String id;

  ListContent({this.name,this.city,this.url,this.id});

  @override
  _ListContentState createState() => _ListContentState();
}


class _ListContentState extends State<ListContent> {
  int loveState=0;
  List<String>follow=List<String>();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage:  NetworkImage(widget.url),
      ),
      title: Text(widget.name),
      subtitle: Text(widget.city),
      trailing: IconButton(
          icon: loveState == 0
              ? Icon(
            Icons.favorite_border,
            size: 30.0,
          )
              : Icon(Icons.favorite,
              size: 30.0, color: Colors.red),
          onPressed: () {
            if (loveState == 0) {
              setState(() {
                loveState = 1;
                follow.add(widget.id);
                print(follow[0]);
                print(follow[1]);
                User().follow=follow;
              });
            } else {
              setState(() {
                loveState = 0;
                follow.remove(widget.id);
               User().follow=follow;
              });
            }
          }),
    );
  }
}