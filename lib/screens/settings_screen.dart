import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/bloc/income/income_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/add_expense_screen.dart';
import 'package:wealthwatcher/screens/expenses_screen.dart';
import 'package:wealthwatcher/screens/incomes_screen.dart';
import 'package:wealthwatcher/screens/login_screen.dart';
import 'package:wealthwatcher/utils/date_format.dart';
import 'package:wealthwatcher/utils/icon_category.dart';

bool expenses = true;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => LogoutBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocConsumer<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      if (state is LoadingLogout) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      } else if (state is AuthenticatedLogout) {
                        Navigator.of(context).pop();
                        context.go('/login');
                      } else if (state is UnauthenticatedLogout) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(Strings.logoutFailed),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        onPressed: () => {
                          BlocProvider.of<LogoutBloc>(context)
                              .add(LogoutRequested())
                        },
                        icon: Icon(Icons.logout),
                        label: Text(Strings.logout),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
