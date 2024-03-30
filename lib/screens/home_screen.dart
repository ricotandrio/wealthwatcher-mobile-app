import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/dashboard_screen.dart';
import 'package:wealthwatcher/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _menuTitles = [
    Strings.menu1,
    Strings.menu2,
    Strings.menu3,
    Strings.menu4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_menuTitles[_selectedIndex]),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          DashboardScreen(),
          Container(
            child: Center(
              child: Text('Analytics Page'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Balance Page'),
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
            label: Strings.menu1,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: Strings.menu2,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: Strings.menu3,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Strings.menu4,
          ),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
