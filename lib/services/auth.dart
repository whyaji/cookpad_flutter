import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  getEmail() {
    final User? user = _firebaseAuth.currentUser;
    final email = user?.email;
    return email;
  }

  getUUID() {
    final User? user = _firebaseAuth.currentUser;
    String? uid = user?.uid.toString();
    return uid;
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }

  Future<bool> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.uid)
            .set({
          'email': email,
          'name': name,
        });
      });
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message ?? "Unknown Error");
      return false;
    }
  }
}
