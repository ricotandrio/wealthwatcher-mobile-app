import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/login_screen.dart';
import 'package:wealthwatcher/screens/splash_screen.dart';

bool obscureText = true;

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RegisterRepository(),
      child: BlocProvider(
        create: (context) => RegisterBloc(
          registerRepository:
              RepositoryProvider.of<RegisterRepository>(context),
          userRepository: UserRepository(),
        ),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.registerBanner,
                    style: TextStyle(
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
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        Strings.haveAccount, // Text to display on the button
                        style: TextStyle(
                          fontSize: 16, // Font size of the text
                          color: Colors.blue, // Color of the text
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 80.0),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener:
                        (BuildContext context, RegisterState state) async {
                      if (state is LoadingRegister) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      } else if (state is UnauthenticatedRegister) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(Strings.registerFailed),
                          ),
                        );
                      } else if (state is AuthenticatedRegister) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(Strings.registerSuccess),
                          ),
                        );

                      };
                    },
                    builder: (context, state) {
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
                            BlocProvider.of<RegisterBloc>(context).add(
                              RegisterRequested(
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
                          style: TextStyle(
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
      ),
    );
  }
}
