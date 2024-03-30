import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/utils/date_format.dart';
import 'package:wealthwatcher/utils/icon_category.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GetAllExpensesBloc>(
            create: (context) =>
                GetAllExpensesBloc(expensesRepository: ExpenseRepository())
                  ..add(GetAllExpenses()),
          ),
        ],
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // create list of expenses
                BlocBuilder<GetAllExpensesBloc, GetAllExpensesState>(
                  builder: (BuildContext context, GetAllExpensesState state) {
                    if (state is LoadingGetAllExpenses) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AuthenticatedGetAllExpenses) {
                      return Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.expenses.length,
                            itemBuilder: (BuildContext context, int index) {
                              final expense = state.expenses[index];
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors
                                          .red), // Set the border color to red
                                ),
                                child: ListTile(
                                  leading: Icon(IconCategory.getCategoryIcon(
                                      expense.category)),
                                  title: Text(expense.name),
                                  subtitle: Text(expense.amount.toString()),
                                  trailing: Text(DateFormat.format(
                                      DateTime.parse(expense.date))),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else if (state is UnauthenticatedGetAllExpenses) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return SizedBox();
                    }
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
