import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Info extends StatelessWidget {
  final String address;
  const Info({required this.address});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: Container(
        alignment: Alignment.topLeft,
        // padding: EdgeInsets.all(50),
        child: ListView(
          padding: EdgeInsets.all(50),
          children: [
            Text(
              'Agency Name',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
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
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () => null,
              child: Text('Contact'),
            )
          ],
        ),
      ),
    );
  }
}
