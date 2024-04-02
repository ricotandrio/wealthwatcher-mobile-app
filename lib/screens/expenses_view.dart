import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/utils/date_format.dart';

class ExpensesView extends StatelessWidget {
  final List<Expenses> expenses;

  ExpensesView({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          final expense = expenses[index];
          return Column(
            children: [
              Card(
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
            ],
          );
        },
      ),
    );
  }
}
