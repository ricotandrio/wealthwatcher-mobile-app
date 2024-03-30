import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/utils/select_date_time.dart';

List<String> _typesList = [
  'food',
  'transportation',
  'entertainment',
  'clothing',
  'bills',
  'shopping',
  'education',
  'other',
];

String management = Strings.expense;
String typeCategory = 'food';

class AddManagementScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _amount = TextEditingController();
  final _description = TextEditingController();
  final _paidmethod = TextEditingController();

  final SelectDateTime _selectDateTime = SelectDateTime();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ExpenseRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AddExpenseBloc(expensesRepository: ExpenseRepository()),
          ),
          BlocProvider(
            create: (context) => AddIncomeBloc(
              incomeRepository: IncomeRepository(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(Strings.management),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20),
                        // date button
                        ElevatedButton(
                            onPressed: () {
                              _selectDateTime.dateTimeModal(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                              ),
                            ),
                            child: Text(
                              Strings.date,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                        SizedBox(height: 20),

                        // name
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(labelText: Strings.name),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.nameEmpty;
                            }
                            return null;
                          },
                          controller: _name,
                        ),

                        // amount
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: Strings.amount),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.amountEmpty;
                            }
                            return null;
                          },
                          controller: _amount,
                        ),

                        // desription
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: Strings.description),
                          controller: _description,
                        ),

                        // category
                        SizedBox(height: 20),
                        Text(Strings.category, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButton<String>(
                              value: typeCategory,
                              onChanged: (String? newValue) {
                                setState(() {
                                  typeCategory = newValue!;
                                });
                              },
                              items: _typesList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          },
                        ),

                        // paid method
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: Strings.paidMethod),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Strings.paidMethodEmpty;
                            }
                            return null;
                          },
                          controller: _paidmethod,
                        ),

                        // add button
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 20, 8, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        print(Strings.expense);
                                        management = Strings.expense;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          management == Strings.expense
                                              ? Colors.blue
                                              : Colors.grey,
                                    ),
                                    child: Text(Strings.addExpense,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        print(Strings.income);
                                        management = Strings.income;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          management == Strings.income
                                              ? Colors.blue
                                              : Colors.grey,
                                    ),
                                    child: Text(Strings.addIncome,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      management == Strings.expense
                                          ? BlocConsumer<AddExpenseBloc,
                                              AddExpenseState>(
                                              listener: (context, state) {
                                                if (state
                                                    is AuthenticatedAddExpense) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(Strings
                                                          .addExpenseSuccess),
                                                    ),
                                                  );
                                                } else if (state
                                                    is UnauthenticatedAddExpense) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(Strings
                                                          .addExpenseFailed),
                                                    ),
                                                  );
                                                } else if (state
                                                    is LoadingAddExpense) {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      BlocProvider.of<
                                                                  AddExpenseBloc>(
                                                              context)
                                                          .add(AddExpense(
                                                        category: typeCategory,
                                                        name: _name.text,
                                                        amount: double.parse(
                                                            _amount.text),
                                                        date: _selectDateTime
                                                            .getDateTime(),
                                                        description:
                                                            _description.text,
                                                        paidMethod:
                                                            _paidmethod.text,
                                                      ));
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            25, 20, 25, 20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0), // Rounded corners
                                                    ),
                                                  ),
                                                  child: Text(
                                                    Strings.addExpense,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              },
                                            )
                                          : BlocConsumer<AddIncomeBloc,
                                              AddIncomeState>(
                                              listener: (context, state) {
                                                if (state
                                                    is AuthenticatedAddIncome) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(Strings
                                                          .addIncomeSuccess),
                                                    ),
                                                  );
                                                } else if (state
                                                    is UnauthenticatedAddIncome) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(Strings
                                                          .addIncomeFailed),
                                                    ),
                                                  );
                                                } else if (state
                                                    is LoadingAddIncome) {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      BlocProvider.of<
                                                                  AddIncomeBloc>(
                                                              context)
                                                          .add(AddIncome(
                                                        category: typeCategory,
                                                        name: _name.text,
                                                        amount: double.parse(
                                                            _amount.text),
                                                        date: _selectDateTime
                                                            .getDateTime(),
                                                        description:
                                                            _description.text,
                                                        paidMethod:
                                                            _paidmethod.text,
                                                      ));
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            25, 20, 25, 20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0), // Rounded corners
                                                    ),
                                                  ),
                                                  child: Text(
                                                    Strings.addIncome,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              },
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
