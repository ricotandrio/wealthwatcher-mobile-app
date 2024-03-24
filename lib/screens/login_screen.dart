import 'package:flutter/material.dart';
import 'package:wealthwatcher/resources/strings.dart';
import 'package:wealthwatcher/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: Strings.email,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: Strings.password,
                contentPadding: EdgeInsets.all(10),
              ),
              obscureText: true,
            ),
            SizedBox(height: 15,),
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
                // TODO: Implement login logic
              },
              child: Text(Strings.login, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
            ),
          ],
        ),
      ),
    );
  }
}
