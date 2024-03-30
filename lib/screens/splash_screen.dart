import 'package:flutter/material.dart';
import 'package:wealthwatcher/resources/images.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(Images.splashImage, width: 200),
              SizedBox(height: 20),
              Text(
                Strings.app,
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
