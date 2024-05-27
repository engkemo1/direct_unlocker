import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direct_unlocker/logic/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logic {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(

      SnackBar(
        backgroundColor: Colors.white,
        content: Text(message),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
  Future<UserCredential> createUser(String email, String password,
      String userName, String phoneNumber,BuildContext context) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((onValue) {
        firestore.collection('Users').add({
          "id": onValue.user !.uid,
          'credits': "0",
          'email': email,
          'password': password,
          'userName': userName,
          'phoneNumber': phoneNumber,

          // Add other fields as necessary
        });
        showToast(context, "Email created successfully ");

        Navigator.pop(context);
        return onValue;
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(context, "The password provided is too weak");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(context, "The account already exists for that email.");

        print('The account already exists for that email.');
      }
      showToast(context, e.message!);

      rethrow;
    } catch (e) {
      print(e);
      showToast(context, e.toString());

      rethrow;
    }
  }

  Future<UserCredential> signIn(String email, String password,BuildContext context) async {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((onValue) {
        showToast(context, "Login Success");


        return onValue;
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      showToast(context, e.message.toString());

      if (e.code == 'user-not-found') {
        showToast(context, "No user found for that email.");

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showToast(context, "Wrong password provided for that user.");

      }
      rethrow;
    }
  }
}
