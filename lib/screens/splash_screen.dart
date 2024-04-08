import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/resources/images.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/home_screen.dart';
import 'package:wealthwatcher/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if (state is AuthenticatedUserAuth) {
          return HomeScreen();
        } else if (state is UnauthenticatedAuth) {
          return WelcomeScreen();
        } else {
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
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
