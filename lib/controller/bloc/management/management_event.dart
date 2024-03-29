import 'package:equatable/equatable.dart';

// Add Expenses event
abstract class AddExpensesEvent extends Equatable {}

class AddExpenses extends AddExpensesEvent {
  final String id;
  final String category;
  final String name;
  final double amount;
  final String date;
  final String? description;
  final String paidMethod;

  AddExpenses({
    required this.id,
    required this.category,
    required this.name,
    required this.amount,
    required this.date,
    this.description,
    required this.paidMethod,
  });

  @override
  List<Object> get props => [];
}

// Add Incomes event
abstract class AddIncomesEvent extends Equatable {}

class AddIncomes extends AddIncomesEvent {
  final String id;
  final String category;
  final String name;
  final double amount;
  final String date;
  final String? description;
  final String paidMethod;

  AddIncomes({
    required this.id,
    required this.category,
    required this.name,
    required this.amount,
    required this.date,
    this.description,
    required this.paidMethod,
  });

  @override
  List<Object> get props => [];
}
