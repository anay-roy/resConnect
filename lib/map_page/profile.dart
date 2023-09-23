import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginuicolors/auth_repo.dart';
import 'package:loginuicolors/profile_controller.dart';
import 'package:loginuicolors/usermodel.dart';

class Profile extends StatelessWidget {
  final userData;

  const Profile({required this.userData});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: height * 0.2,
                  child: Image.asset('Assets/logo.png'),
                ),
              ),
              Container(
                width: width * 1,
                height: height * 0.1,
                child: Card(
                  child: Center(
                    child: Text(
                      'Name : ${userData.name!}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: width * 1,
                height: height * 0.1,
                child: Card(
                  child: Center(
                    child: Text(
                      'Email: ${userData.email}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: width * 1,
                height: height * 0.1,
                child: Card(
                  child: Center(
                    child: Text(
                      'Expertise : ${userData.expertise!}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () => AuthRepo().logout(),
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ));
  }
}
