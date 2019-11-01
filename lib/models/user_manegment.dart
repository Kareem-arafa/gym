import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:gym/models/user.dart';

class UserManagement {

  StoreNewUser(User user,context,FirebaseUser cUser)async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    //FirebaseUser Currentuser=await _auth.currentUser();
    String collection;
    if(user.getRole()=='Coach'){
      collection='Coach';
    }else{
      collection='Trainee';
    }
    Firestore.instance.collection(collection).document(cUser.uid).setData({
      "email" : user.getEmail(),
      "gender" : user.getGender(),
      'name':user.getName(),
      'phone' : user.getPhone(),
      'role' : user.getRole(),
      'pic':user.getUrl(),
      'uid':cUser.uid,
    }).then((value){
      print("Store Done");
      //Navigator.of(context).pop();
      //Navigator.of(context).pushNamed("home");
    }).catchError((e){
      print(e);
    });
  }
}