import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<dynamic> follow = List<dynamic>();

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<DocumentSnapshot> data = List<DocumentSnapshot>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocument().then((val) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            "Favorite",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: data.isEmpty == false
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int Index) {
                  return Info(
                    ds: data[Index],
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ));
  }

  getDocument() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Firestore.instance
        .collection(preferences.getString('role'))
        .document(preferences.getString('user'))
        .get()
        .then((ds) {
      follow = ds.data['follow'];
    });
  }

  void getData() {
    for (String id in follow) {
      Firestore.instance.collection('Coach').document(id).get().then((ds) {
        setState(() {
          data.add(ds);
        });
      });
    }
  }
}

class Info extends StatefulWidget {
  final DocumentSnapshot ds;

  Info({this.ds});

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int loveState = 1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(widget.ds.data['pic']),
      ),
      title: Text(widget.ds.data['name']),
      subtitle: Text('ismailia'),
      trailing: IconButton(
          icon: loveState == 0
              ? Icon(
                  Icons.favorite_border,
                  size: 30.0,
                )
              : Icon(Icons.favorite, size: 30.0, color: Colors.red),
          onPressed: () {
            if (loveState == 0) {
              setState(() {
                loveState = 1;
                follow.add(widget.ds.data['uid']);
                print(follow[0]);
                // print(follow[1]);
              });
            } else {
              setState(() {
                loveState = 0;
                follow.remove(widget.ds.data['uid']);
              });
            }
          }),
    );
  }
}
