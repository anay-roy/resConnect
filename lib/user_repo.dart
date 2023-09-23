import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loginuicolors/usermodel.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<usermodel> getUserDetails(String email) async {
    try {
      final snapshot =
          await _db.collection("Users").where("email", isEqualTo: email).get();

      if (snapshot.docs.isEmpty) {
        // Handle the case where no documents match the query.
        return usermodel(
            name: 'Not Found',
            email: '',
            phoneNumber: '',
            lattitude: '',
            longitude: '',
            expertise: '',
            password: '');
      }

      final userData =
          snapshot.docs.map((e) => usermodel.fromSnapshot(e)).single;
      return userData;
    } catch (error) {
      // Handle any errors that occur during the Firestore operation.
      print("Error fetching user details: $error");
      throw error; // Optionally, you can rethrow the error.
    }
  }

  Future<List<usermodel>> allUser() async {
    try {
      final snapshot = await _db.collection("Users").get();
      final userData =
          snapshot.docs.map((e) => usermodel.fromSnapshot(e)).toList();
      return userData;
    } catch (error) {
      // Handle any errors that occur during the Firestore operation.
      print("Error fetching all users: $error");
      throw error; // Optionally, you can rethrow the error.
    }
  }
}
