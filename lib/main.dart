import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:wealthwatcher/controller/services/expenses_service.dart';
import 'package:wealthwatcher/firebase_options.dart';
import 'package:wealthwatcher/screens/add_expense_screen.dart';
import 'package:wealthwatcher/screens/dashboard_screen.dart';
import 'package:wealthwatcher/screens/home_screen.dart';
import 'package:wealthwatcher/screens/login_screen.dart';
import 'package:wealthwatcher/screens/register_screen.dart';
import 'package:wealthwatcher/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (snapshot.hasData) {
            return SplashScreen();
          }
          return LoginScreen();
        },
      ),
    );
  }
}
