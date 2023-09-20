import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loginuicolors/Animation/register.dart';
import 'package:loginuicolors/map_page/select_loc.dart';
import 'map_page/info.dart';
import 'map_page/map.dart';
import 'Animation/login.dart';
import 'map_page/nearby.dart';
import 'map_page/select_loc.dart';
import 'firebase_auth_method.dart';

class MyAppRoute {
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => Map(),
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => MyLogin(),
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (context, state) => MyRegister(),
      ),
      GoRoute(
        name: 'info',
        path: '/info',
        builder: (context, state) {
          return Info(address: state.extra as String);
        },
      ),
      GoRoute(
        name: 'nearby',
        path: '/nearby',
        builder: (context, state) => NearbyAgencies(),
      ),
      GoRoute(
        name: 'selectlocation',
        path: '/selectlocation',
        builder: (context, state) => SelectLocation(),
      ),
    ],
  );
}