import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wealthwatcher/firebase_options.dart';
import 'package:wealthwatcher/screens/dashboard_add_screen.dart';
import 'package:wealthwatcher/screens/dashboard_view_screen.dart';
import 'package:wealthwatcher/screens/home_screen.dart';
import 'package:wealthwatcher/screens/login_screen.dart';
import 'package:wealthwatcher/screens/register_screen.dart';
import 'package:wealthwatcher/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthwatcher/screens/welcome_screen.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      initialLocation: '/dashboard',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SplashScreen(),
          routes: [
            GoRoute(
              path: 'home',
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => RegisterScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
