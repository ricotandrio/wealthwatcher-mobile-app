import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/management_form.dart';

class AddManagementsScreen extends StatefulWidget {
  @override
  State<AddManagementsScreen> createState() => _AddManagementsScreenState();
}

class _AddManagementsScreenState extends State<AddManagementsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController? _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.management),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: 50,
              width: double.maxFinite,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 0, right: 0),
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: Strings.expense,
                  ),
                  Tab(
                    text: Strings.income,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 110,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child:
                              ManagementForm(typeManagement: Strings.expense),
                        ),
                        Center(
                          child: ManagementForm(typeManagement: Strings.income),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
