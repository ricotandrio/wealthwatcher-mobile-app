import 'package:flutter/material.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<dynamic> listofExpenses;

  const HomeScreen({Key? key, required this.listofExpenses}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _menuTitles = [Strings.menu1, Strings.menu2, Strings.menu3, Strings.menu4];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_menuTitles[_selectedIndex]),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          DashboardScreen(listofExpenses: widget.listofExpenses),
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
          Container(
            child: Center(
              child: Text('Settings Page'),
            ),
          ),
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
