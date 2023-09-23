import 'package:flutter/material.dart';

class Resource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('ResConnect', style: TextStyle(color: Colors.black)),
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
                    'Under Development',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ])),
    );
  }
}
