import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/models/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth _auth=FirebaseAuth.instance;
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userData;
  String userName;
  String userEmail;
  String userPhone;
  String userRole;
  String userGender;
  String urlPic;

  FirebaseAuth auth=FirebaseAuth.instance;

  curdMethods crudObj =new curdMethods();


String id;

Future<String> getId()async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
 setState(() {
   id = prefs.get('user');
 });
 print(id);
 print( prefs.getString('user'));
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getId().then((val){
      getInfo();
    });
   /*crudObj.search(id).then((result){
     setState(() {
       userData=result;
     });
    });*/
   //
  }
  void getInfo()async{
  SharedPreferences pref=await SharedPreferences.getInstance();

   await Firestore.instance.collection(pref.getString('role')).document(id).get().then((ds){
      setState(() {
        userName=ds.data['name'];
        userEmail=ds.data['email'];
        userGender=ds.data['gender'];
        userRole=ds.data['role'];
        userPhone=ds.data['phone'];
        urlPic=ds.data['pic'];
      });
    });

   // print(userName);
    
  }
  @override
  Widget build(BuildContext context) {
    return userName==null? Center(child: CircularProgressIndicator(backgroundColor: Colors.red,),):Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 350.0,
                  width: double.infinity,
                ),
                Container(
                  height: 200.0,
                  width: double.infinity,
                  color: Color.fromRGBO(212, 20, 15, 1.0),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    child: Text('Log out',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      _auth.signOut().then((val)async{
                        SharedPreferences prefs= await SharedPreferences.getInstance();
                        prefs.remove('user');
                        prefs.remove('role');
                        Navigator.pushNamed(context, '/root');
                      });
                    },
                  ),
                ),
                //info container
                Positioned(
                  top: 125.0,
                  left: 15.0,
                  right: 15.0,
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(7.0),
                    child: Container(
                      height: 215.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          color: Colors.white),
                    ),
                  ),
                ),
                //image
                Positioned(
                  top: 75.0,
                  left: (MediaQuery.of(context).size.width / 2 - 50.0),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        image: DecorationImage(
                            image:urlPic==null?AssetImage('assets/user.png'): NetworkImage(urlPic),
                            fit: BoxFit.cover)),
                  ),
                ),
                //info
                Positioned(
                  top: 190.0,
                  left: 30.0,
                  child:userName==null?  CircularProgressIndicator(backgroundColor: Colors.red,):Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                           // mainAxisAlignment: MainAxisAlignment.start,
                           //crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Icon(
                               Icons.assignment_ind,
                               color: Colors.grey,
                             ),
                             SizedBox(width: 8.0,),
                             Text(userName??'',style: TextStyle(fontSize: 20.0),),
                           ],
                          ),
                          SizedBox(height: 15.0,),
                          Row(
                            children: <Widget>[
                              Icon(
                                  Icons.email,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 8.0,),
                              Text(userEmail??'',style: TextStyle(fontSize: 20.0),),
                            ],
                          ),
                          SizedBox(height: 15.0,),
                          Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 8.0,),
                                    Text(userPhone??'',style: TextStyle(fontSize: 20.0),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.0,),

                            ],
                          ),
                          SizedBox(height: 15.0,),
                          Container(
                            width: 350,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                //  SizedBox(width: 50.0,),
                                  Container(
                                    child:  Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.group,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 8.0,),
                                        Text(userGender??'',style: TextStyle(fontSize: 20.0),),
                                      ],
                                    ),
                                  ),
                                  //SizedBox(width: 50.0,),
                                  Container(
                                    child:   Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 8.0,),
                                        Text(userRole??'',style: TextStyle(fontSize: 20.0),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ),

                        ],
                      )
                )
              ],
            ),
            SizedBox(height: 50.0,),
          // Text(id??'no user to print'),
           /* Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlatButton(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                color: Colors.red,
                onPressed: () {},
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.white),
                ),
              ),
            )*/
          ],
        ));
  }
}
