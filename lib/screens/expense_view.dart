import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/resources/strings.dart';

class ExpenseView extends StatelessWidget {
  final Expenses expense;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _paymentController = TextEditingController();

  ExpenseView({required this.expense}) {
    _nameController.text = expense.name;
    _amountController.text = expense.amount.toString();
    _dateController.text = expense.date;
    _descriptionController.text = expense.description!;
    _categoryController.text = expense.category;
    _paymentController.text = expense.paidMethod;
  }

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
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.expense),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child:
                            BlocConsumer<DeleteExpenseBloc, DeleteExpenseState>(
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

                          BlocProvider.of<GetAllExpensesBloc>(context).add(
                            GetAllExpenses(),
                          );
                        } else if (state is UnauthenticatedDeleteExpense) {
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
                                .add(DeleteExpense(id: expense.id));
                          },
                          child: Text(
                            Strings.deleteExpense,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                    )),
                    Container(
                        child:
                            BlocConsumer<UpdateExpenseBloc, UpdateExpenseState>(
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

                          BlocProvider.of<GetAllExpensesBloc>(context).add(
                            GetAllExpenses(),
                          );
                        } else if (state is UnauthenticatedUpdateExpense) {
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
                            BlocProvider.of<UpdateExpenseBloc>(context).add(
                              UpdateExpense(
                                id: expense.id,
                                name: _nameController.text,
                                amount: double.parse(_amountController.text),
                                date: _dateController.text,
                                description: _descriptionController.text,
                                category: _categoryController.text,
                                paidMethod: _paymentController.text,
                              ),
                            );
                          },
                          child: Text(
                            Strings.updateExpense,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
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
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: Strings.amount,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: Strings.date,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: Strings.description,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _categoryController,
                        decoration: InputDecoration(
                          labelText: Strings.category,
                        ),
                      ),
                      SizedBox(height: 20),
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
