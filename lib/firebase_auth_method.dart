import 'dart:async';
import 'package:go_router/go_router.dart';
import 'Animation/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ShowSnackbar.dart';
import 'routes.dart';

late Timer _timer;
bool isverified = false;

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  Future<void> signUpwithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Email verification sent');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> loginwithemail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      context.goNamed('home');
      // if (_auth.currentUser!.emailVerified) {}
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'invalid Credentials');
    }
  }
}

void setTimer() {
  _timer = Timer.periodic(Duration(seconds: 3), (timer) {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      isverified = true;
    }
  });
}
