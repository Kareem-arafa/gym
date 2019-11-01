import 'package:flutter/material.dart';
import 'package:gym/ui/widgets/custom_flat_button.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Hero(
              tag: 'logo',
              child: Image(
                image: AssetImage('assets/logo.png'),
                color: Color.fromRGBO(212, 20, 15, 1.0),
                height: 200.0,
                width: 200.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Thor GYM",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(212, 20, 15, 1.0),
                decoration: TextDecoration.none,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: "Courgette",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "With us you will be different",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                fontFamily: "Courgette",
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "Log In",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/back.png'),
                        primaryColor: Color.fromRGBO(212, 20, 15, 1.0),
                        isNew: false,
                      )),
                );
              },
              splashColor: Colors.black12,
              borderColor: Color.fromRGBO(212, 20, 15, 1.0),
              borderWidth: 0,
              color: Color.fromRGBO(212, 20, 15, 1.0),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "Sign Up",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.black54,
              onPressed: () {
                Navigator.pushNamed(context, 'signup');
              },
              splashColor: Colors.black12,
              borderColor: Colors.black12,
              borderWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
