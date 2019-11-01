import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym/models/user.dart';
import 'package:gym/models/user_manegment.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class MoreInfo extends StatefulWidget {
  final User user;

  MoreInfo({this.user});

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  int roleGroup = 0;
  int genderGroup = 0;

  String downlaodUri;

  File sampleImage;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  void printUser() {
    String name = widget.user.getName();
    String phone = widget.user.getPhone();
    String email = widget.user.getEmail();
    String role = widget.user.getRole();
    String gender = widget.user.getGender();
    String uri = widget.user.getUrl();
   // String id = widget.user.getid();
    print(
        'user name : $name user phone : $phone  user email : $email  user role : $role  user gender : $gender  user pic : $uri');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                          image: sampleImage == null
                              ? AssetImage('assets/user.png')
                              : FileImage(sampleImage),
                          fit: BoxFit.cover),
                      color: Colors.white),
                ),
              ),
              Positioned(
                right: (MediaQuery.of(context).size.width / 2 - 80.0),
                top: 135.0,
                child: new RawMaterialButton(
                  fillColor: Colors.lightBlue,
                  shape: new CircleBorder(),
                  elevation: 3.0,
                  child: new Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    getImage().then((val) {
                      uploadPic();
                    });
                  },
                ),
              ),
              //info
              Positioned(
                top: 190.0,
                left: 30.0,
                child: Column(
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
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                         widget.user.getName(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                         widget.user.getEmail(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
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
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                widget.user.getPhone(),
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          //  SizedBox(width: 50.0,),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.group,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  widget.user.getGender(),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(width: 50.0,),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                 widget.user.getRole(),
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              color:Color.fromRGBO(212, 20, 15, 1.0),
              onPressed: () async{
                String id;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                //  Navigator.pushNamed(context, 'home');
                getuser().then((user){
                  id=user.uid.toString();
                });
                prefs.setString('user',id);
                UserManagement()
                    .StoreNewUser(widget.user, context, await getuser());
                printUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/back.png'),
                        primaryColor: Color.fromRGBO(212, 20, 15, 1.0),
                        isNew: true,
                      )),
                );
              },
              child: Text(
                'Done',
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white),
              ),
            ),
          ),
        /*  Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "DONE",
              textColor: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              splashColor: Colors.black12,
              borderColor: Color.fromRGBO(212, 20, 15, 1.0),
              borderWidth: 0,
              color: Color.fromRGBO(212, 20, 15, 1.0),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                //  Navigator.pushNamed(context, 'home');
                prefs.setBool('user', true);
                UserManagement()
                    .StoreNewUser(widget.user, context, await getuser());
                printUser();
                Navigator.pushNamed(context, 'flow');
              },
            ),
          ),*/
        ],
      ),
    );
  }

  Future<FirebaseUser> getuser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future uploadPic() async {
FirebaseUser user=await getuser();
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profile/${user.uid.toString()}.jpg');
    final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);

    task.onComplete.then((value) {
      value.ref.getDownloadURL().then((val) {
        print(val);
        setState(() {
          downlaodUri = val;
          widget.user.profilePic = downlaodUri;
        });
      });
    });

  }
}
