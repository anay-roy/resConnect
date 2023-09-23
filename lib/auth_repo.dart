import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loginuicolors/Animation/register.dart';
import 'package:loginuicolors/ShowSnackbar.dart';
import 'package:loginuicolors/map_page/map.dart';
import 'package:loginuicolors/map_page/nearby.dart';
import 'package:loginuicolors/map_page/profile.dart';
import 'package:loginuicolors/screen_controller.dart';
import 'Animation/login.dart';

class AuthRepo extends GetxController {
  late Timer _timer;
  static AuthRepo get instance => Get.find();
  //variable
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    // TODO: implement onReady
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    print(user);
    user == null ? Get.offAll(() => MyLogin()) : Get.offAll(() => MapPage());
  }

  Future<void> signUpwithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) Get.offAll(() => MyLogin());
      await sendEmailVerification(context);
      final user = FirebaseAuth.instance.currentUser;
      Future(() async {
        if (user != null) {
          _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
            await user.reload();
            if (user.emailVerified) {
              timer.cancel();
              Get.back();
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

  final screen = Get.put(ScreenController());
  Future<void> loginwithemail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    print(_auth.currentUser);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(MapPage());
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, 'invalid Credentials');
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
