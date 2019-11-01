import 'package:flutter/material.dart';
int bookState ;
int loveState;

class Footer extends StatefulWidget {
  final String num;
  final bool isLove;
  final bool isBook;
  Footer({this.isBook,this.isLove,this.num});
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {

  void isLoved(){
    if(widget.isLove==true){
      setState(() {
        loveState=1;
      });
    }else{
      setState(() {
        loveState=0;
      });
    }
  }
  void isBooked(){
    if(widget.isBook==true){
      setState(() {
        bookState=1;
      });
    }else{
      setState(() {
        bookState=0;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoved();
    isBooked();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                IconButton(
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
                        });
                      } else {
                        setState(() {
                          loveState = 0;
                        });
                      }
                    }),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                 widget.num,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                      fontFamily: 'Comfortaa'),
                )
              ],
            ),
          ),
          IconButton(
            icon: bookState == 0
                ? Icon(Icons.bookmark_border, size: 30.0)
                : Icon(
              Icons.bookmark,
              size: 30.0,
              color: Colors.blue,
            ),
            onPressed: () {
              if (bookState == 0) {
                setState(() {
                  bookState = 1;
                });
              } else {
                setState(() {
                  bookState = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
