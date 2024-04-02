import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/utils/date_format.dart';

class IncomesView extends StatelessWidget {
  final List<Incomes> incomes;

  IncomesView({required this.incomes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (BuildContext context, int index) {
          final income = incomes[index];
          return Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.green,
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.category),
              title: Text(
                income.name,
                style: GoogleFonts.poppins(),
              ),
              subtitle: Text(
                income.amount.toString(),
                style: GoogleFonts.poppins(),
              ),
              trailing: Text(
                DateFormat.format(DateTime.parse(income.date)),
                style: GoogleFonts.poppins(),
              ),
            ),
          );
        },
      ),
    );
  }
}
