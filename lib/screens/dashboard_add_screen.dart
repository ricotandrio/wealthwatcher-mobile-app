import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/expense_form.dart';
import 'package:wealthwatcher/screens/income_form.dart';

class DashboardAddScreen extends StatefulWidget {
  @override
  State<DashboardAddScreen> createState() => _DashboardAddScreenState();
}

class _DashboardAddScreenState extends State<DashboardAddScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController? _tabController = TabController(length: 2, vsync: this);
    final _getAllExpenses = BlocProvider.of<GetAllExpensesBloc>(context);
    final _getAllIncomes = BlocProvider.of<GetAllIncomesBloc>(context);

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
                    key: UniqueKey(),
                    text: Strings.expense,
                  ),
                  Tab(
                    key: UniqueKey(),
                    text: Strings.income,
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                          child: BlocProvider.value(
                            value: _getAllExpenses,
                            child: ExpenseForm(),
                          ),
                        ),
                        Center(
                          child: BlocProvider.value(
                            value: _getAllIncomes,
                            child: IncomeForm(),
                          ),
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
