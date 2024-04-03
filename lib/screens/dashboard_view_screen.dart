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
import 'package:wealthwatcher/screens/dashboard_add_screen.dart';
import 'package:wealthwatcher/screens/expenses_view_list.dart';
import 'package:wealthwatcher/screens/incomes_view.dart';

bool expenses = true;

class DashboardViewScreen extends StatefulWidget {
  const DashboardViewScreen({Key? key}) : super(key: key);

  @override
  State<DashboardViewScreen> createState() => _DashboardViewScreenState();
}

class _DashboardViewScreenState extends State<DashboardViewScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController? _tabController = TabController(length: 2, vsync: this);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ExpenseRepository>(
          create: (context) => ExpenseRepository(),
        ),
        RepositoryProvider<IncomeRepository>(
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
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardAddScreen(),
                  ),
                );

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MultiBlocProvider(
                //       providers: [
                //         BlocProvider.value(
                //           value: BlocProvider.of<GetAllExpensesBloc>(context),
                //         ),
                //         BlocProvider.value(
                //           value: BlocProvider.of<GetAllIncomesBloc>(context),
                //         ),
                //       ],
                //       child: DashboardAddScreen(),
                //     ),
                //   ),
                // );
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
            body: SingleChildScrollView(
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
                                BlocBuilder<TotalBalanceBloc,
                                    TotalBalanceState>(
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
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
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
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
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
                                          if (state
                                              is LoadingGetTotalExpenses) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (state
                                              is AuthenticatedGetAllExpenses) {
                                            return ExpensesViewList(
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
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (state
                                              is AuthenticatedGetAllIncomes) {
                                            return IncomesViewList(
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
      ),
    );
  }
}
