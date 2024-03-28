import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/firebase/auth_repository.dart';
import 'package:wealthwatcher/controller/services/expenses_service.dart';
import 'package:wealthwatcher/firebase_options.dart';
import 'package:wealthwatcher/screens/add_expense_screen.dart';
import 'package:wealthwatcher/screens/home_screen.dart';
import 'package:wealthwatcher/screens/login_screen.dart';
import 'package:wealthwatcher/screens/register_screen.dart';
import 'package:wealthwatcher/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> listofExpenses = [];
  bool loading = true;

  void fetchExpenses() async {
    setState(() {
      loading = true;
    });

    ExpenseService expenseService = ExpenseService();

    final response = await expenseService.getAllExpense();

    setState(() {
      listofExpenses = response;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: {
        '/': (context) => loading == true
            ? SplashScreen()
            : HomeScreen(listofExpenses: listofExpenses),
        '/expense': (context) => AddExpenseScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
