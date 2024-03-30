import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wealthwatcher/firebase_options.dart';
import 'package:wealthwatcher/screens/add_expense_screen.dart';
import 'package:wealthwatcher/screens/dashboard_screen.dart';
import 'package:wealthwatcher/screens/home_screen.dart';
import 'package:wealthwatcher/screens/login_screen.dart';
import 'package:wealthwatcher/screens/register_screen.dart';
import 'package:wealthwatcher/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      initialLocation: '/',
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
            GoRoute(
              path: 'dashboard',
              builder: (context, state) => DashboardScreen(),
            ),
            GoRoute(
              path: 'add-expense',
              builder: (context, state) => AddExpenseScreen(),
            ),
          ],
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
