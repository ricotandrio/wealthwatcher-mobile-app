import 'package:flutter/material.dart';
import 'package:wealthwatcher/controller/services/user_service.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscureText = true;

  void handleFormSubmit() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    UserService userService = UserService();
    try {
      final response = await userService.loginUser(username, password);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User logged in successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login user'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.loginBanner,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 100.0),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: Strings.username,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
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
              ),
              SizedBox(
                height: 15,
              ),
              Row(children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    Strings.noAccount, // Text to display on the button
                    style: TextStyle(
                      fontSize: 16, // Font size of the text
                      color: Colors.blue, // Color of the text
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 80.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), // Rounded corners
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    handleFormSubmit();
                  }
                },
                child: Text(
                  Strings.login,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
