import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/resources/strings.dart';

class IncomeView extends StatelessWidget {
  final Incomes income;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _paymentController = TextEditingController();

  IncomeView({required this.income}) {
    _nameController.text = income.name;
    _amountController.text = income.amount.toString();
    _dateController.text = income.date;
    _descriptionController.text = income.description!;
    _categoryController.text = income.category;
    _paymentController.text = income.paidMethod;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          title: Text(Strings.income),
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
                      child: BlocConsumer<DeleteIncomeBloc, DeleteIncomeState>(
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

                            BlocProvider.of<GetAllIncomesBloc>(context)
                                .add(GetAllIncomes());
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
                                  .add(DeleteIncome(id: income.id));
                            },
                            child: Text(
                              Strings.deleteIncome,
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
                      ),
                    ),
                    Container(
                      child: BlocConsumer<UpdateIncomeBloc, UpdateIncomeState>(
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

                            BlocProvider.of<GetAllIncomesBloc>(context)
                                .add(GetAllIncomes());
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
                              BlocProvider.of<UpdateIncomeBloc>(context).add(
                                UpdateIncome(
                                  id: income.id,
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
                              Strings.updateIncome,
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
                      ),
                    ),
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
