import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'dart:convert';

class Users {
  String firebaseid;
  String username;
  String email;
  List<Expenses>? expenses = [];
  List<Incomes>? incomes = [];

  Users({
    required this.firebaseid,
    required this.username,
    required this.email,
    this.expenses,
    this.incomes,
  });

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String str) =>
      Users.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      firebaseid: data['firebaseid'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
      expenses: data['expenses'] != null
          ? (data['expenses'] as List)
              .map((e) => Expenses.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
      incomes: data['incomes'] != null
          ? (data['incomes'] as List)
              .map((e) => Incomes.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firebaseid': firebaseid,
      'username': username,
      'email': email,
      'expenses': expenses,
      'incomes': incomes,
    };
  }

}
