import 'package:flutter/material.dart';
import 'package:wealthwatcher/controller/services/user_service.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool obscureText = true;

  void handleFormSubmit() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Strings.confirmPasswordMismatch),
        ),
      );
      return;
    }

    UserService userService = UserService();
    try {
      final response = await userService.registerUser(username, password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User registered successfully'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register user'),
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
              SizedBox(height: 16.0),
              TextFormField(
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
              ),
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
                    Strings.haveAccount, // Text to display on the button
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
                  // Implement your registration logic here
                },
                child: Text(
                  Strings.register,
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
