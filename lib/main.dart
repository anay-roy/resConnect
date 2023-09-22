import 'package:flutter/material.dart';
import 'package:loginuicolors/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: MyAppRoute().router,
  ));
}
