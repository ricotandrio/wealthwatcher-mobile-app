import 'package:wealthwatcher/models/database/management.dart';
import 'dart:convert';

class Incomes extends Management {
  Incomes({
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

  factory Incomes.toJson(Map<String, dynamic> data) {
    return Incomes(
      id: data['id'] ?? '',
      category: data['category'] ?? '',
      name: data['name'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: data['date'] ?? '',
      description: data['description'] ?? '',
      paidMethod: data['paidMethod'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Incomes.fromJson(String str) =>
    Incomes.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Incomes.fromMap(Map<String, dynamic> data) {
    return Incomes(
      id: data['id'],
      category: data['category'],
      name: data['name'],
      amount: data['amount'],
      date: data['date'],
      description: data['description'],
      paidMethod: data['paidMethod'],
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
    return 'Incomes{id: $id, category: $category, name: $name, amount: $amount, date: $date, description: $description, paidMethod: $paidMethod}';
  }
}
