import 'dart:async';
import 'dart:io';

import 'package:fireball/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj base in Firebase's User
  // User == FirebaseUser
  //Users != User
  /*Users? _userFromFireBase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Users(uid: user.uid) : null;
  }*/
  Users? _userFromFireBase(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  /*Stream<Users> get user {
    return _auth
        .authStateChanges()
        .map(_userFromFireBase as Users Function(User? event));
  }*/

  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFireBase);
  }


  Future<void> sendEmailVerify() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
    }
  }

  //resigter
  Future resigterwithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? userss = result.user;
      // await DatabaseService(uid: userss!.uid)
      //     .updateUserData('0', 'new cus', 100);
      return _userFromFireBase(userss);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in by email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in ano
  Future signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFireBase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // log out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
