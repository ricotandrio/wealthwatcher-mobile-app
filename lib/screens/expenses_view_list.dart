import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/expense_view.dart';
import 'package:wealthwatcher/utils/date_format.dart';

class ExpensesViewList extends StatelessWidget {
  final List<Expenses> expenses;

  ExpensesViewList({required this.expenses});

  @override
  Widget build(BuildContext context) {
    final getAllExpensesBloc = BlocProvider.of<GetAllExpensesBloc>(context);

    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          final expense = expenses[index];
          return Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider.value(
                            value: getAllExpensesBloc,
                            child: ExpenseView(
                              expense: expense,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.category),
                      title: Text(
                        expense.name,
                        style: GoogleFonts.poppins(),
                      ),
                      subtitle: Text(
                        expense.amount.toString(),
                        style: GoogleFonts.poppins(),
                      ),
                      trailing: Text(
                        DateFormat.format(DateTime.parse(expense.date)),
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
