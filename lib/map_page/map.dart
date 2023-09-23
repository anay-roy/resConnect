import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loginuicolors/auth_repo.dart';
import 'package:loginuicolors/map_page/profile.dart';
import 'package:loginuicolors/map_page/user.dart';
import 'package:loginuicolors/profile_controller.dart';
import 'dart:async';
import 'package:loginuicolors/screen_controller.dart';
import 'package:loginuicolors/user_repo.dart';
import 'package:loginuicolors/usermodel.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  //variables
  Completer<GoogleMapController> _controller = Completer();
  late double currLat = 0;
  late double currLon = 0;
  String address = '';

  //get location
  Future<Position> getLocation() async {
    bool serviceLocation = await Geolocator.isLocationServiceEnabled();
    if (!serviceLocation) {
      return Future.error('Service not enabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {}
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return Geolocator.getCurrentPosition();
  }

  //for markers

  @override
  Widget build(BuildContext context) {
    final profilecont = Get.put(Pcontroller());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('ResConnect', style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Get.to(Profile());
                },
              ))
        ],
      ),

      //drawer
      drawer: Drawer(
          shadowColor: Colors.black,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text('Agency Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Agency type',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('NearBy Agencies'),
                onTap: () {
                  context.pushNamed('nearby');
                },
              ),
              ListTile(
                leading: Icon(Icons.near_me),
                title: Text('Request Resource'),
                onTap: () {
                  context.pushNamed('resources');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.sos,
                  color: Colors.white,
                ),
                title: Text('EMERGENCY'),
                textColor: Colors.white,
                tileColor: Colors.red,
                onLongPress: () {
                  context.pushNamed('nearby');
                },
              ),
            ],
          )),

      //body
      body: SafeArea(
        child: FutureBuilder<usermodel>(
            future: profilecont.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  usermodel userData = snapshot.data!;
                  List<Marker> _marker = [];
                  return FutureBuilder<List<usermodel>>(
                    future: UserRepo().allUser(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.done) {
                        if (snap.hasData) {
                          if (snap.connectionState == ConnectionState.done) {
                            if (snap.hasData) {
                              snap.data!.forEach((data) {
                                snap.data!.forEach((data) {
                                  if (data.lattitude != null &&
                                      data.longitude != null) {
                                    _marker.add(
                                      Marker(
                                        markerId: MarkerId(data.id ?? ''),
                                        position: LatLng(
                                            double.parse(data.lattitude!),
                                            double.parse(data.longitude!)),
                                        infoWindow:
                                            InfoWindow(title: data.name),
                                        onTap: () {
                                          Get.to(Profile(
                                            userData: data,
                                          ));
                                        },
                                      ),
                                    );
                                  }
                                });
                              });
                            }
                          }

                          return GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: LatLng(20.5937, 81.9629), zoom: 4.3),
                            onMapCreated: (GoogleMapController controller) {
                              currLat = double.parse(userData.lattitude!);
                              currLon = double.parse(userData.longitude!);

                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(currLat, currLon),
                                      zoom: 10)));
                              // });
                              _controller.complete(controller);
                            },
                            mapType: MapType.normal,
                            markers: Set.of(_marker),
                          );
                        }
                      }
                      return CircularProgressIndicator();
                    },
                  );
                }
                ;
              }
              return CircularProgressIndicator();
            }),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          child: Icon(Icons.navigation, color: Colors.black),
          backgroundColor: Colors.white,
          onPressed: () {
            getLocation().then((value) async {
              currLat = value.latitude;
              currLon = value.longitude;
              GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(currLat, currLon), zoom: 10)));
            });
          },
        ),
      ),
    );
  }
}
