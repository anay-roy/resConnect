import 'package:flutter/material.dart';

class NearbyAgencies extends StatelessWidget {
  final List _agencies = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: ListView.builder(
          itemBuilder: ((context, index) {
            return Text(_agencies[index]);
          }),
          itemCount: _agencies.length),
    );
  }
}
