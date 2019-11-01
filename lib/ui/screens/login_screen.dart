import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym/models/validate.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class LoginScreen extends StatefulWidget {
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;
  final bool isNew;

  LoginScreen({this.primaryColor, this.backgroundColor, this.backgroundImage,this.isNew});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  bool passwordState=true;
  bool _autoValidate = false;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
 //IconData icon;
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
                        "Email",
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
                          Expanded(
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
                              controller: _password,
                              obscureText: passwordState,
                              validator: Validator.validatePassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                             passwordState? Icons.visibility_off:Icons.visibility,
                              color: passwordState?Colors.grey : Colors.red
                            ),
                            onPressed: () {
                            setState(() {
                              passwordState=!passwordState;
                            });
                          },
                          )
                        ],
                      ),
                    ),
                  ],
                )),
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
                              "LOGIN",
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
                                onPressed: ()  async{
                                  if(_formKey.currentState.validate()){
                                    SharedPreferences prefs=  await SharedPreferences.getInstance();

                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                    _auth.signInWithEmailAndPassword(email: _email.text, password: _password.text).then((user){
                                      prefs.setString('user', user.uid);
                                      prefs.setString('role', user.displayName);
                                    });
                                    /*if(widget.isNew==false){
                                      Navigator.of(context).pushNamed('home');
                                    }else{
                                      Navigator.of(context).pushNamed('flow');
                                    }*/
                                    widget.isNew==true? Navigator.of(context).pushNamed('flow'): Navigator.of(context).pushNamed('home');
                                   // print(widget.isNew);
                                  }else{
                                    setState(() {
                                      _autoValidate=true;
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: ()  async{
                        if(_formKey.currentState.validate()){
                          SharedPreferences prefs=  await SharedPreferences.getInstance();
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          _auth.signInWithEmailAndPassword(email: _email.text, password: _password.text).then((user){
                            prefs.setString('user', user.uid);
                            prefs.setString('role', user.displayName);
                          });
                          widget.isNew==true? Navigator.of(context).pushNamed('flow'): Navigator.of(context).pushNamed('home');
                        }else{
                          setState(() {
                            _autoValidate=true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                  const IconData(0xea90, fontFamily: 'Comfortaa'),
                                  color: Color(0xff3b5998),
                                ),
                                onPressed: () {
                                  _signIn().then((FirebaseUser user) {
                                    Navigator.of(context)
                                        .pushNamed("home");
                                  }).catchError((e) {
                                    print(e);
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: ()  {
                        _signIn().then((FirebaseUser user) {
                          Navigator.of(context)
                              .pushNamed("home");
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        alignment: Alignment.center,
                        child: Text(
                          "DON'T HAVE AN ACCOUNT?",
                          style: TextStyle(
                              color: this.widget.primaryColor, fontFamily: ''),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'signup');
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
