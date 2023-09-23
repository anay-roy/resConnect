import 'package:get/get.dart';
import 'package:loginuicolors/auth_repo.dart';
import 'package:loginuicolors/map_page/user.dart';
import 'package:loginuicolors/user_repo.dart';

class Pcontroller extends GetxController {
  static Pcontroller get instance => Get.find();
  final _authRepo = Get.put(AuthRepo());
  final _userRepo = Get.put(UserRepo());
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      print('Halwa.....................................');
      return (_userRepo.getUserDetails(email));
      // print(_userRepo.getUserDetails(email).toString());
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }
}
