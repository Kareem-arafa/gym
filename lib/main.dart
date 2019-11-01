import 'package:flutter/material.dart';
import "package:gym/ui/screens/walk_screen.dart";
import 'package:gym/ui/screens/root_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym/ui/screens/login_screen.dart';
import 'package:gym/ui/screens/signup_screen.dart';
import 'package:gym/ui/screens/profile_screen.dart';
import 'package:gym/ui/screens/more_info.dart';
import 'package:gym/ui/screens/home_screen.dart';
import 'package:gym/ui/screens/folowing.dart';

import 'models/user.dart';

void main() {
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatefulWidget {

  final SharedPreferences prefs;

  MyApp({this.prefs});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
      //  '/':(BuildContext context) => new WalkthroughScreen(prefs: widget.prefs),
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(prefs: widget.prefs),
        '/root': (BuildContext context) => new RootScreen(),
        /*'login': (BuildContext context) => new LoginScreen(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/back.png'),
              primaryColor: Color.fromRGBO(212, 20, 15, 1.0),
            ),*/
        'signup': (BuildContext context) => new SignUpScreen (
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/back.png'),
          primaryColor: Color.fromRGBO(212, 20, 15, 1.0),
        ),
        'profile': (BuildContext context) => new Profile(),
        'info': (BuildContext context) => new MoreInfo(),
        'home': (BuildContext context) => new MyHomePage(),
        'flow': (BuildContext context) => new Flowing(),
      },
      theme: ThemeData(
        accentColor: Colors.white,
        primaryColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      home:// WalkthroughScreen(prefs: prefs,),
        _handleCurrentScreen(),
    );
  }

 /* Future<FirebaseUser> getUser(){
    setState(() {
      user=_auth.currentUser();
    });
  }*/
  Widget _handleCurrentScreen(){

    bool seen = (widget.prefs.getBool('seen') ?? false);
    String user=widget.prefs.get('user')??"";

    if(user.isNotEmpty){
    return MyHomePage();
    } else if (seen) {
      return new RootScreen();
    }else {
      return new WalkthroughScreen(prefs: widget.prefs);
    }
  }
}
