import 'package:flutter/material.dart';

class Resource extends StatelessWidget {
  final List _resourceList = ['1', '2', '3', '4'];

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
            return Text(_resourceList[index]);
          }),
          itemCount: _resourceList.length),
    );
  }
}
