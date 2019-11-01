import 'package:flutter/material.dart';


class Header extends StatelessWidget {
  final String name;
  final String city;
  final String dateTime;
  final AssetImage image;
  Header({this.image,this.city,this.dateTime,this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // height: 50,
        // width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: image,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name),
                      Text(
                        city,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Text(dateTime)
          ],
        ),
      ),
    );
  }
}
