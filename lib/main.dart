import 'package:flutter/material.dart';
import 'package:loginuicolors/firebase_options.dart';
import 'Animation/login.dart';
import 'Animation/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginuicolors/map_page/info.dart';
import 'Animation/login.dart';
import 'Animation/register.dart';
import 'map_page/map.dart';
import 'routes.dart';
import 'package:go_router/go_router.dart';
import 'package:loginuicolors/Animation/login.dart';
import 'map_page/map.dart';

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
