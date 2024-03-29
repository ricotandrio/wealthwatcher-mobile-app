import 'package:wealthwatcher/models/database/management.dart';
import 'dart:convert';

class Expenses extends Management {
  Expenses({
    required String id,
    required String category,
    required String name,
    required double amount,
    required String date,
    String? description,
    required String paidMethod,
  }) : super(
          id: id,
          category: category,
          name: name,
          amount: amount,
          date: date,
          description: description ?? '',
          paidMethod: paidMethod,
        );

  String toJson() => json.encode(toMap());

  factory Expenses.fromJson(String str) =>
      Expenses.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Expenses.fromMap(Map<String, dynamic> data) {
    return Expenses(
      id: data['id'] ?? '',
      category: data['category'] ?? '',
      name: data['name'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(), 
      date: data['date'] ?? '',
      description: data['description'] ?? '',
      paidMethod: data['paidMethod'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'amount': amount,
      'date': date,
      'description': description,
      'paidMethod': paidMethod,
    };
  }

  @override
  String toString() {
    return 'Expenses{id: $id, category: $category, name: $name, amount: $amount, date: $date, description: $description, paidMethod: $paidMethod}';
  }
}
