import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/utils/date_format.dart';
import 'package:wealthwatcher/utils/icon_category.dart';

class IncomesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GetAllIncomesBloc>(
            create: (context) =>
                GetAllIncomesBloc(incomeRepository: IncomeRepository())
                  ..add(GetAllIncomes()),
          ),
        ],
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // create list of expenses
                BlocBuilder<GetAllIncomesBloc, GetAllIncomesState>(
                  builder: (BuildContext context, GetAllIncomesState state) {
                    if (state is LoadingGetAllIncomes) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AuthenticatedGetAllIncomes) {
                      return Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.incomes.length,
                            itemBuilder: (BuildContext context, int index) {
                              final income = state.incomes[index];
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors
                                          .green), // Set the border color to red
                                ),
                                child: ListTile(
                                  leading: Icon(IconCategory.getCategoryIcon(
                                      income.category)),
                                  title: Text(income.name),
                                  subtitle: Text(income.amount.toString()),
                                  trailing: Text(DateFormat.format(
                                      DateTime.parse(income.date))),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else if (state is UnauthenticatedGetAllIncomes) {
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
