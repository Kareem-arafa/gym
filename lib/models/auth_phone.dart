import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class auth extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthState();
  }
}
class AuthState extends State<auth>{
  String phoneNo;
  String smsCode;
  String verificationId;


  Future<void> verifyPhone()async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve=(String verId){
      this.verificationId=verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId,[int forceCodeResend]){
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });

    };
    final PhoneVerificationCompleted verificationCompleted=(user){
      print("verified");
    };
    final PhoneVerificationFailed verificationFailed=(AuthException exception){
      print("${exception.message}");
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: this.phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("PhoneAuth"),
      ),
      body: new Container(
        padding: EdgeInsets.all(25.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Phone number'
              ),
              onChanged: (value){
                this.phoneNo=value;
              },
            ),
            SizedBox(height: 10.0,),
            RaisedButton(
              onPressed: verifyPhone,
              child: Text("Verify"),
              textColor: Colors.white,
              elevation: 7.0,
              color: Colors.blue,

            )
          ],
        ),
      ),
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
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed('/HomePage');
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                      Navigator.of(context).pushNamed('/HomePage');
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async{
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        print('Successfully signed in, uid: ' + user.uid);
      } else {
        print( 'Sign in failed');
      }
    });
  }
}