import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loginuicolors/usermodel.dart';

class Agency extends GetxController {
  static Agency get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createUser(usermodel user) async {
    await _db.collection("Users").add(user.toJason()).whenComplete(() =>
        Get.snackbar("Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM));
  }
}
