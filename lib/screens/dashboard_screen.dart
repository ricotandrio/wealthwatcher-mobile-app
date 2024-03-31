import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/add_managements_screen.dart';
import 'package:wealthwatcher/screens/expenses_screen.dart';
import 'package:wealthwatcher/screens/incomes_screen.dart';

bool expenses = true;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push('/add-expense');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<GetTotalExpensesBloc>(
              create: (context) =>
                  GetTotalExpensesBloc(expensesRepository: ExpenseRepository())
                    ..add(GetTotalExpenses()),
            ),
            BlocProvider<GetTotalIncomesBloc>(
              create: (context) =>
                  GetTotalIncomesBloc(incomeRepository: IncomeRepository())
                    ..add(GetTotalIncomes()),
            ),
            BlocProvider<TotalBalanceBloc>(
              create: (context) => TotalBalanceBloc(
                expenseRepository: ExpenseRepository(),
                incomeRepository: IncomeRepository(),
              )..add(GetTotalBalance()),
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Strings.balanceTotal,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              BlocBuilder<TotalBalanceBloc, TotalBalanceState>(
                                builder: (BuildContext context,
                                    TotalBalanceState state) {
                                  if (state is LoadingTotalBalance) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is AuthenticatedTotalBalance) {
                                    return Text(
                                      'Rp. ${state.totalBalance},-',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  } else if (state
                                      is UnauthenticatedTotalBalance) {
                                    return Text(
                                      state.message,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Strings.expenseTotal,
                                style: TextStyle(color: Colors.white),
                              ),
                              BlocBuilder<GetTotalExpensesBloc,
                                  GetTotalExpensesState>(
                                builder: (BuildContext context,
                                    GetTotalExpensesState state) {
                                  if (state is LoadingGetTotalExpenses) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is AuthenticatedGetTotalExpenses) {
                                    return Text(
                                      'Rp. ${state.totalExpenses},-',
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else if (state
                                      is UnauthenticatedGetTotalExpenses) {
                                    return Text(
                                      state.message,
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                Strings.incomeTotal,
                                style: TextStyle(color: Colors.white),
                              ),
                              BlocBuilder<GetTotalIncomesBloc,
                                  GetTotalIncomesState>(
                                builder: (BuildContext context,
                                    GetTotalIncomesState state) {
                                  if (state is LoadingGetTotalIncomes) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is AuthenticatedGetTotalIncomes) {
                                    return Text(
                                      'Rp. ${state.totalIncomes},-',
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else if (state
                                      is UnauthenticatedGetTotalIncomes) {
                                    return Text(
                                      state.message,
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      expenses = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        expenses ? Colors.blue : Colors.grey,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(Strings.expense,
                                      style: TextStyle(color: Colors.white)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      expenses = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        expenses ? Colors.grey : Colors.blue,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(Strings.income,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          expenses ? ExpensesScreen() : IncomesScreen(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
