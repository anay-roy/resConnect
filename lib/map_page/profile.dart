import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginuicolors/auth_repo.dart';
import 'package:loginuicolors/profile_controller.dart';
import 'package:loginuicolors/usermodel.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Pcontroller());

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('ResConnect', style: TextStyle(color: Colors.black)),
      ),
      body: FutureBuilder<usermodel>(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // print(snapshot.data);
            if (snapshot.hasData) {
              usermodel userData = snapshot.data!; // Non-null assertion

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      userData.name!,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Address: ${userData.email}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      userData.expertise!,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () => AuthRepo().logout(),
                      child: Text('Logout'),
                    ),
                  ],
                ),
              );
            } else {
              return Text("No data available.");
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
