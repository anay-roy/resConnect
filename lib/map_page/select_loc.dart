import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  Completer<GoogleMapController> _controller = Completer();
  late double currLat = 0;
  late double currLon = 0;
  String address = '';
  String city = '';
  String state = '';
  String postal = '';
  LatLng dest = LatLng(0, 0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),

      //body
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(20.5937, 81.9629), zoom: 4.3),
          onMapCreated: (GoogleMapController controller) async {
            getLocation().then((value) async {
              currLat = value.latitude;
              currLon = value.longitude;
              controller = await _controller.future;

              //getting address

              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(currLat, currLon), zoom: 10)));
            });
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          onCameraMove: (position) {
            dest = position.target;
          },
          onCameraIdle: () async {
            List<Placemark> placemarks =
                await placemarkFromCoordinates(dest.latitude, dest.longitude);
            setState(() {
              address = placemarks.reversed.last.street.toString();
              city = placemarks.first.locality.toString();
              state = placemarks.first.administrativeArea.toString();
              postal = placemarks.first.postalCode.toString();
            });
          },
        ),
        Align(
          child: Center(
            child: Icon(Icons.location_on_sharp),
          ),
        ),
        Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              padding: EdgeInsets.all(20),
              child: Text(
                  address == ''
                      ? ' '
                      : address + ' ,' + city + ' ,' + postal + ' ,' + state,
                  overflow: TextOverflow.visible,
                  softWrap: true),
            ))
      ]),
      floatingActionButton: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.bottomLeft,
        child: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () {
            //push modified address to database here

            context.goNamed('home');
          },
        ),
      ),
    );
  }
}
