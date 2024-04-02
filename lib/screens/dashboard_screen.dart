import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:wealthwatcher/screens/expenses_view.dart';
import 'package:wealthwatcher/screens/incomes_view.dart';

bool expenses = true;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController? _tabController = TabController(length: 2, vsync: this);
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
            BlocProvider<GetAllExpensesBloc>(
              create: (context) =>
                  GetAllExpensesBloc(expensesRepository: ExpenseRepository())
                    ..add(GetAllExpenses()),
            ),
            BlocProvider<GetAllIncomesBloc>(
              create: (context) =>
                  GetAllIncomesBloc(incomeRepository: IncomeRepository())
                    ..add(GetAllIncomes()),
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
                                style: GoogleFonts.poppins(
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
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  } else if (state
                                      is UnauthenticatedTotalBalance) {
                                    return Text(
                                      state.message,
                                      style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(color: Colors.white),
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
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    );
                                  } else if (state
                                      is UnauthenticatedGetTotalExpenses) {
                                    return Text(
                                      state.message,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
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
                                style: GoogleFonts.poppins(color: Colors.white),
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
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    );
                                  } else if (state
                                      is UnauthenticatedGetTotalIncomes) {
                                    return Text(
                                      state.message,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
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
                Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: double.maxFinite,
                      child: TabBar(
                        labelPadding: EdgeInsets.only(left: 0, right: 0),
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
                                  child: Container(
                                    child: BlocBuilder<GetAllExpensesBloc,
                                        GetAllExpensesState>(
                                      builder: (BuildContext context,
                                          GetAllExpensesState state) {
                                        if (state is LoadingGetTotalExpenses) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is AuthenticatedGetAllExpenses) {
                                          return ExpensesView(
                                            expenses: state.expenses,
                                          );
                                        } else if (state
                                            is UnauthenticatedGetAllExpenses) {
                                          return Text(state.message);
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    child: BlocBuilder<GetAllIncomesBloc,
                                        GetAllIncomesState>(
                                      builder: (BuildContext context,
                                          GetAllIncomesState state) {
                                        if (state is LoadingGetAllIncomes) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is AuthenticatedGetAllIncomes) {
                                          return IncomesView(
                                            incomes: state.incomes,
                                          );
                                        } else if (state
                                            is UnauthenticatedGetAllIncomes) {
                                          return Text(state.message);
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
