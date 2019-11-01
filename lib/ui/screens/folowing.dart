import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/models/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String>follow=List<String>();

class Flowing extends StatefulWidget {
  @override
  _FlowingState createState() => _FlowingState();
}

class _FlowingState extends State<Flowing> {
  curdMethods crud = new curdMethods();

  int loveState=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Flow",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: crud.getCoaches(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                final Coaches = snapshot.data.documents;
                return Container(
                    child: ListView.builder(
                      itemCount:Coaches.length,
                      itemBuilder: (BuildContext context, int Index) {
                        return Content(Coaches: Coaches,Index: Index,);
                      },
                    ));
              },
            ),
            flex: 5,
          ),
          Container(
            height: 50.0,
            child: RaisedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                Firestore.instance
                    .collection(prefs.getString('role'))
                    .document(prefs.getString('user'))
                    .updateData({'follow': follow}).then((val) {
                  Navigator.pushNamed(context, 'home');
                  follow.removeRange(0, follow.length-1);
                });
              },
              child: Text(
                'GO',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
  final Coaches;
  final int Index;
  Content({this.Coaches,this.Index});
}

class _ContentState extends State<Content> {
  int loveState =0;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage:  NetworkImage( widget.Coaches[widget.Index].data['pic']),
      ),
      title: Text( widget.Coaches[widget.Index].data['name']),
      subtitle: Text('ismailia'),
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
                follow.add( widget.Coaches[widget.Index].data['uid']);
                print(follow[0]);
                // print(follow[1]);
              });
            } else {
              setState(() {
                loveState = 0;
                follow.remove(widget.Coaches[widget.Index].data['uid']);
              });
            }
          }),
    );
  }
}

