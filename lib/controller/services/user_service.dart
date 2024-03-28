import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wealthwatcher/models/outputs/login_output.dart';
import 'package:wealthwatcher/models/outputs/register_output.dart';

class UserService {
  Future<RegisterUserOutput> registerUser(
      String username, String password) async {
    
    final apiUrl = dotenv.env['API_REGISTER'];

    final response = await http.post(
      Uri.parse('${apiUrl}'),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register user: ${response.statusCode}');
    }

    return RegisterUserOutput.fromJson(jsonDecode(response.body));
  }

  Future<LoginUserOutput> loginUser(String username, String password) async {
    await dotenv.load(fileName: ".env");
    final apiUrl = dotenv.env['API_LOGIN'];

    final response = await http.post(
      Uri.parse('$apiUrl'),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to login user: ${response.statusCode}');
    }

    return LoginUserOutput.fromJson(jsonDecode(response.body));
  }
}
