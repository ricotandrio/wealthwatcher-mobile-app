import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/resources/strings.dart';

bool expenses = true;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (BuildContext context, AuthState state) {
                    if (state is LoadingAuth) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Strings.loading),
                        ),
                      );
                    } else if (state is AuthenticatedAuth) {

                      _authBloc.add(GetCurrentAuthUserRequested());

                      Navigator.of(context).popUntil(
                        ModalRoute.withName('/'),
                      );
                      
                    } else if (state is UnauthenticatedAuth) {
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
                        _authBloc.add(LogoutAuthRequested()),
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.blue),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(25, 20, 25, 20)),
                      ),
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text(Strings.logout,
                          style: GoogleFonts.poppins(color: Colors.white)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
