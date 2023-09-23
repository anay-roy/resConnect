import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loginuicolors/auth_repo.dart';
import 'package:loginuicolors/map_page/profile.dart';
import 'dart:async';
import 'package:loginuicolors/screen_controller.dart';

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
  List<Marker> _marker = [];
  @override
  Widget build(BuildContext context) {
    print('builing........');
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
                  Get.to(Profile());
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
        child: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(20.5937, 81.9629), zoom: 4.3),
          onMapCreated: (GoogleMapController controller) async {
            getLocation().then((value) async {
              currLat = value.latitude;
              currLon = value.longitude;
              controller = await _controller.future;

              //getting address
              List<Placemark> placemarks =
                  await placemarkFromCoordinates(currLat, currLon);
              address = placemarks.reversed.last.name.toString() +
                  '\n' +
                  placemarks.reversed.last.locality.toString() +
                  '\n' +
                  placemarks.reversed.last.street.toString();
              setState(() {
                _marker.add(Marker(
                    markerId: MarkerId('2'),
                    position: LatLng(currLat, currLon),
                    infoWindow: InfoWindow(title: 'My Location'),
                    onTap: (() {
                      showModalBottomSheet<void>(
                        constraints: BoxConstraints.loose(Size(
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height * 0.75)),
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(45))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 700,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Agency Type',
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    address,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Description',
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blue),
                                        foregroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    onPressed: () => AuthRepo().logout(),
                                    child: Text('Logout'),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })));
              });
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(currLat, currLon), zoom: 10)));
            });
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          markers: Set.of(_marker),
        ),
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
