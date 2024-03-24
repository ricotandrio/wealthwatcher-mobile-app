import 'package:flutter/material.dart';
import 'package:wealthwatcher/resources/images.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(Images.splashImage,
                  width: 200), // Adjust width as needed
              SizedBox(height: 20), // Add spacing between image and text
              Text(
                'Wealth Watcher',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
