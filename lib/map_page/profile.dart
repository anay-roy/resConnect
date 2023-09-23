import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginuicolors/Animation/register.dart';
import 'package:loginuicolors/auth_repo.dart';
import 'package:loginuicolors/map_page/map.dart';
import 'package:loginuicolors/screen_controller.dart';

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
            return Container(
                child: TextButton(
              child: Text('LogOut'),
              onPressed: () {},
            ));
          }),
          itemCount: _ProfileList.length),
    );
  }
}
