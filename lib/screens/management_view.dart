import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/resources/strings.dart';

class ManagementView extends StatelessWidget {
  final String typeManagement;
  final Expenses? expenses;
  final Incomes? income;

  ManagementView({required this.typeManagement, this.expenses, this.income});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _typeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeleteExpenseBloc>(
          create: (context) =>
              DeleteExpenseBloc(expensesRepository: ExpenseRepository()),
        ),
        BlocProvider(
          create: (context) =>
              UpdateExpenseBloc(expensesRepository: ExpenseRepository()),
        ),
        BlocProvider(
          create: (context) =>
              DeleteIncomeBloc(incomeRepository: IncomeRepository()),
        ),
        BlocProvider(
          create: (context) =>
              UpdateIncomeBloc(incomeRepository: IncomeRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(typeManagement),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    child: typeManagement == Strings.expense
                        ? BlocConsumer<DeleteExpenseBloc, DeleteExpenseState>(
                            listener: (context, state) {
                              if (state is LoadingDeleteExpense) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                              } else if (state is AuthenticatedDeleteExpense) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.deleteExpenseSuccess),
                                  ),
                                );
                              } else if (state
                                  is UnauthenticatedDeleteExpense) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.deleteExpenseFailed),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<DeleteExpenseBloc>(context)
                                      .add(DeleteExpense(id: expenses!.id));
                                },
                                child: Text(Strings.deleteExpense),
                              );
                            },
                          )
                        : BlocConsumer<DeleteIncomeBloc, DeleteIncomeState>(
                            listener: (context, state) {
                              if (state is LoadingDeleteIncome) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                              } else if (state is AuthenticatedDeleteIncome) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.deleteIncomeSuccess),
                                  ),
                                );
                              } else if (state is UnauthenticatedDeleteIncome) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.deleteIncomeFailed),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<DeleteIncomeBloc>(context)
                                      .add(DeleteIncome(id: income!.id));
                                },
                                child: Text(Strings.deleteIncome),
                              );
                            },
                          ),
                  ),
                  Container(
                    child: typeManagement == Strings.expense
                        ? BlocConsumer<UpdateExpenseBloc, UpdateExpenseState>(
                            listener: (context, state) {
                              if (state is LoadingUpdateExpense) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                              } else if (state is AuthenticatedUpdateExpense) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.updateExpenseSuccess),
                                  ),
                                );
                              } else if (state
                                  is UnauthenticatedUpdateExpense) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.updateExpenseFailed),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<UpdateExpenseBloc>(context)
                                      .add(
                                    UpdateExpense(
                                      id: expenses!.id,
                                      name: _nameController.text,
                                      amount: _amountController.text as double,
                                      date: _dateController.text,
                                      description: _descriptionController.text,
                                      category: _categoryController.text,
                                      paidMethod: _paymentController.text,
                                    ),
                                  );
                                },
                                child: Text(Strings.updateExpense),
                              );
                            },
                          )
                        : BlocConsumer<UpdateIncomeBloc, UpdateIncomeState>(
                            listener: (context, state) {
                              if (state is LoadingUpdateIncome) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                              } else if (state is AuthenticatedUpdateIncome) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.updateIncomeSuccess),
                                  ),
                                );
                              } else if (state is UnauthenticatedUpdateIncome) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(Strings.updateIncomeFailed),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<UpdateIncomeBloc>(context)
                                      .add(
                                    UpdateIncome(
                                      id: income!.id,
                                      name: _nameController.text,
                                      amount: _amountController.text as double,
                                      date: _dateController.text,
                                      description: _descriptionController.text,
                                      category: _categoryController.text,
                                      paidMethod: _paymentController.text,
                                    ),
                                  );
                                },
                                child: Text(Strings.updateIncome),
                              );
                            },
                          ),
                  ),
                ],
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: Strings.name,
                        ),
                      ),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: Strings.amount,
                        ),
                      ),
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: Strings.date,
                        ),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: Strings.description,
                        ),
                      ),
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          labelText: Strings.category,
                        ),
                      ),
                      TextFormField(
                        controller: _paymentController,
                        decoration: InputDecoration(
                          labelText: Strings.paidMethod,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
