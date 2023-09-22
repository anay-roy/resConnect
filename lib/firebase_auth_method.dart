import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ShowSnackbar.dart';

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
      final user = FirebaseAuth.instance.currentUser;
      Future(() async {
        if (user != null) {
          _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
            await user.reload();
            if (user.emailVerified) {
              timer.cancel();
              context.push('/home');
            }
          });
        }
      });
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
  if (FirebaseAuth.instance != null) {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (FirebaseAuth.instance.currentUser != null) {
        FirebaseAuth.instance.currentUser!.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          isverified = true;
        }
      }
    });
  }
}
