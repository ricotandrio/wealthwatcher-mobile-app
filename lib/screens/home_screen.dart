import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/dashboard_view_screen.dart';
import 'package:wealthwatcher/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<String> _menuTitles = [
    Strings.dashboard,
    Strings.settings,
  ];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _menuTitles[_selectedIndex],
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => ExpenseRepository(),
              ),
              RepositoryProvider(
                create: (context) => IncomeRepository(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<GetTotalExpensesBloc>(
                  create: (context) => GetTotalExpensesBloc(
                      expensesRepository:
                          RepositoryProvider.of<ExpenseRepository>(context))
                    ..add(GetTotalExpenses()),
                ),
                BlocProvider<GetTotalIncomesBloc>(
                  create: (context) => GetTotalIncomesBloc(
                      incomeRepository:
                          RepositoryProvider.of<IncomeRepository>(context))
                    ..add(GetTotalIncomes()),
                ),
                BlocProvider<TotalBalanceBloc>(
                  create: (context) => TotalBalanceBloc(
                    expenseRepository:
                        RepositoryProvider.of<ExpenseRepository>(context),
                    incomeRepository:
                        RepositoryProvider.of<IncomeRepository>(context),
                  )..add(GetTotalBalance()),
                ),
                BlocProvider<GetAllExpensesBloc>(
                  create: (context) => GetAllExpensesBloc(
                      expensesRepository:
                          RepositoryProvider.of<ExpenseRepository>(context))
                    ..add(GetAllExpenses()),
                ),
                BlocProvider<GetAllIncomesBloc>(
                  create: (context) => GetAllIncomesBloc(
                      incomeRepository:
                          RepositoryProvider.of<IncomeRepository>(context))
                    ..add(GetAllIncomes()),
                ),
              ],
              child: DashboardViewScreen(),
            ),
          ),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: Strings.dashboard,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Strings.settings,
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
