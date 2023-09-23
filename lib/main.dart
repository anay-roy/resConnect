import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginuicolors/Animation/login.dart';
import 'package:loginuicolors/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_repo.dart';
import 'map_page/map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthRepo()));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLogin(),
    );
  }
}


// class App extends StatelessWidget {  
// Widget build(BuildContext context) {
//   runApp(GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Map(),
//   ));
// }
// }
