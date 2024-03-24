import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExpenseService {
  Future<List<dynamic>> getAllExpense() async {
    await dotenv.load(fileName: ".env");
    final apiUrl = dotenv.env['API_URL'];

    final response = await http.get(Uri.parse('$apiUrl'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['expense'];
    } else {
      throw Exception('Failed to fetch expenses: ${response.statusCode}');
    }
  }
}
