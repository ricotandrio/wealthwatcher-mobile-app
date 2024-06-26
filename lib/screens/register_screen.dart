import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/home_screen.dart';
import 'package:wealthwatcher/screens/login_screen.dart';

bool obscureText = true;

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  Strings.registerBanner,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 100.0),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: Strings.username,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(height: 16.0),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: Strings.password,
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: IconButton(
                        icon: obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16.0),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: Strings.confirmPassword,
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: IconButton(
                        icon: obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 15,
                ),
                Row(children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      Strings
                          .haveAccountQuestion, // Text to display on the button
                      style: GoogleFonts.poppins(
                        fontSize: 16, // Font size of the text
                        color: Colors.blue, // Color of the text
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 80.0),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (BuildContext context, AuthState state) async {
                    if (state is LoadingAuth) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    } else if (state is UnauthenticatedAuth) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Strings.registerFailed),
                        ),
                      );
                    } else if (state is AuthenticatedUserAuth) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                    ;
                  },
                  builder: (BuildContext context, AuthState state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(Strings.confirmPasswordMismatch),
                            ),
                          );
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          _authBloc.add(
                            RegisterAuthRequested(
                              email: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                        // Implement your registration logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5.0), // Rounded corners
                        ),
                      ),
                      child: Text(
                        Strings.register,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                    );
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
