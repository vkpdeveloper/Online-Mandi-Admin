import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user;
    try {
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = _result.user;
      return user;
    } on PlatformException catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "Wrong Password");
      return null;
    }
  }

  Future<bool> isLogged() async {
    FirebaseUser user = await _auth.currentUser();
    return user != null;
  }

  Future<DocumentSnapshot> getItems() async {
    return await Firestore.instance.collection('admin').document('items').get();
  }
}
