import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym/models/user.dart';
import 'package:gym/models/validate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'more_info.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  SignUpScreen({this.primaryColor, this.backgroundColor, this.backgroundImage});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _phone = new TextEditingController();

  int roleGroup = 0;
  int genderGroup = 0;

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  bool _autoValidate = false;

  String gender;
  String role;

  // String phoneNo;
  String smsCode;
  String verificationId;

  void roleEventHandler(int value) {
    setState(() {
      roleGroup = value;
    });
    if (value == 1) {
      role = 'Trainee';
    } else {
      role = 'Coach';
    }
  }

  void genderEventHandler(int value) {
    setState(() {
      genderGroup = value;
    });

    if (value == 1) {
      gender = 'Male';
    } else {
      gender = 'Female';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new ClipPath(
              clipper: MyClipper(),
              child: Container(
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: this.widget.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 90.0, bottom: 100.0),
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/logo.png'),
                      height: 200.0,
                      width: 150.0,
                      color: this.widget.primaryColor,
                    ),
                    Text(
                      "THOR GYM",
                      style: TextStyle(
                          fontFamily: 'Courgette',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: this.widget.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Name",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    //PASSWORD
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.assignment_ind,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        new Expanded(
                          child: TextFormField(
                            validator: Validator.validateName,
                            controller: _name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Phone",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    //PASSWORD
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        new Expanded(
                          child: TextFormField(
                            validator: Validator.validateNumber,
                            controller: _phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your phone',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  //EMAIL
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    //PASSWORD
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        new Expanded(
                          child: TextFormField(
                            validator: Validator.validateEmail,
                            controller: _email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  //PASSWORD
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    //PASSWORD
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.lock_open,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        new Expanded(
                          child: TextFormField(
                            validator: Validator.validatePassword,
                            controller: _password,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Role :",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            new Radio(
                              value: 1,
                              groupValue: roleGroup,
                              onChanged: roleEventHandler,
                              activeColor: Colors.redAccent,
                            ),
                            new Text(
                              'Trainee',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            new Radio(
                              value: 2,
                              groupValue: roleGroup,
                              onChanged: roleEventHandler,
                              activeColor: Colors.redAccent,
                            ),
                            new Text(
                              'Coach ',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Gender :",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            new Radio(
                              value: 1,
                              groupValue: genderGroup,
                              onChanged: genderEventHandler,
                              activeColor: Colors.redAccent,
                            ),
                            new Text(
                              'Male   ',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            new Radio(
                              value: 2,
                              groupValue: genderGroup,
                              onChanged: genderEventHandler,
                              activeColor: Colors.redAccent,
                            ),
                            new Text(
                              'Female',
                              style: new TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //signup with phone
            Container(
              margin: const EdgeInsets.only(top: 15.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      splashColor: this.widget.primaryColor,
                      color: this.widget.primaryColor,
                      child: new Row(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          new Expanded(
                            child: Container(),
                          ),
                          new Transform.translate(
                            offset: Offset(15.0, 0.0),
                            child: new Container(
                              padding: const EdgeInsets.all(5.0),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(28.0)),
                                splashColor: Colors.white,
                                color: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: this.widget.primaryColor,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                    verifyPhone();
                                    // Navigator.pushNamed(context, "info");
                                  } else {
                                    _autoValidate = true;
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          verifyPhone();
                          //  Navigator.pushNamed(context, "info");
                        } else {
                          _autoValidate = true;
                        }
                        //   Navigator.pushNamed(context, "profile");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
              child: Center(
                child: Text(
                  '---------------------- OR ----------------------',
                  style: TextStyle(color: Colors.grey, fontSize: 20.0),
                ),
              ),
            ),
            //log in with google
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      splashColor: Color(0xFF3B5998),
                      color: Color(0xff3B5998),
                      child: new Row(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "LOGIN WITH GOOGLE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          new Expanded(
                            child: Container(),
                          ),
                          new Transform.translate(
                            offset: Offset(15.0, 0.0),
                            child: new Container(
                              padding: const EdgeInsets.all(5.0),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(28.0)),
                                splashColor: Colors.white,
                                color: Colors.white,
                                child: Icon(
                                  const IconData(0xea90, fontFamily: 'icomoon'),
                                  color: Color(0xff3b5998),
                                ),
                                onPressed: () {
                                  _signIn().then((FirebaseUser user) {
                                    Navigator.of(context).pushNamed("home");
                                  }).catchError((e) {
                                    print(e);
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        _signIn().then((FirebaseUser user) {
                          Navigator.of(context).pushNamed("home");
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  User getData() {
    User user = new User(
      email: _email.text,
      phone: _phone.text,
      name: _name.text,
      gender: gender,
      role: role,
    );
    return user;
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
    };
    final PhoneVerificationCompleted verificationCompleted = (user) {
      print("verified");
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException exception) {
      print("${exception.message}");
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: '+2 ${_phone.text} ',
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                color: Colors.red,
                onPressed: () async {
                  FirebaseAuth.instance.currentUser().then((user) async {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('home');
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('no complet', true);
                      Navigator.of(context).pop();
                      signIn();
                      // Navigator.of(context).pushNamed('info');
                      //userId=user.uid;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreInfo(
                                  user: getData(),
                                )),
                      );
                    }
                  });
                },
              )
            ],
          );
        });
  }

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }

  signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      UserUpdateInfo userUpdateInfo=new UserUpdateInfo();
      userUpdateInfo.displayName=role;
      _auth
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((user) async {
        user.linkWithCredential(credential).then((user){
          user.updateProfile(userUpdateInfo);
        });
      });
    } catch (e) {
      print(e);
    }

    /*final FirebaseUser user = await _auth.signInWithCredential(credential);
  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  setState(() {
  if (user != null) {
  print('Successfully signed in, uid: ' + user.uid);

  } else {
  print( 'Sign in failed');
  }
  });*/
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
