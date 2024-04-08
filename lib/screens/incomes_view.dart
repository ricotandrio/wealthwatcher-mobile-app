import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/screens/income_view.dart';
import 'package:wealthwatcher/utils/date_format.dart';

class IncomesViewList extends StatelessWidget {
  final List<Incomes> incomes;

  IncomesViewList({required this.incomes});

  @override
  Widget build(BuildContext context) {
    final getAllIncomesBloc = BlocProvider.of<GetAllIncomesBloc>(context);

    return Container(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        itemCount: incomes.length,
        itemBuilder: (BuildContext context, int index) {
          final income = incomes[index];
          return Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return BlocProvider.value(
                          value: getAllIncomesBloc,
                          child: IncomeView(
                            income: income,
                          ),
                        );
                      }),
                    );
                  },
                  child: Card(
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
