
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';

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
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: BlocConsumer<LogoutBloc, LogoutState>(
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
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5), 
                                side: BorderSide(color: Colors.blue), 
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.fromLTRB(25, 20, 25, 20)),
                          ),
                          icon: Icon(Icons.logout, color: Colors.white),
                          label: Text(Strings.logout, style: GoogleFonts.poppins(color: Colors.white)),
                        );
                      },
                    ),
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
