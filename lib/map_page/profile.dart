import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final List _ProfileList = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('ResConnect', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
          itemBuilder: ((context, index) {
            return Text(_ProfileList[index]);
          }),
          itemCount: _ProfileList.length),
    );
  }
}
