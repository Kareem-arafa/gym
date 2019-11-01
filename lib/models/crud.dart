import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class curdMethods {
FirebaseAuth auth =FirebaseAuth.instance;
 bool  isLoggedin()  {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> addData(data) async {
    if (isLoggedin()) {
       /*Firestore.instance.collection("testCrud").add(carData).catchError((e){
        print(e);
      });*/

      Firestore.instance.runTransaction((Transaction crudTransaction) async {
        CollectionReference reference = await Firestore.instance.collection("users");

        reference.add(data);
      });
    } else {
      print("You need to Login");
    }
  }
  
 /* search(String user)async{
    return await Firestore.instance.collection('users').document(user).get();
  }*/

  getCoaches(){
    return  Firestore.instance.collection('Coach').snapshots();
  }

  updateData(selectedDoc, newValue) {
    Firestore.instance
        .collection("data")
        .document(selectedDoc)
        .updateData(newValue)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('users')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

}
