import 'package:equatable/equatable.dart';

// Add Expenses event
abstract class AddExpenseEvent extends Equatable {}

class AddExpense extends AddExpenseEvent {
  final String category;
  final String name;
  final double amount;
  final String date;
  final String? description;
  final String paidMethod;

  AddExpense({
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

// Get all expenses event
abstract class GetAllExpensesEvent extends Equatable {}

class GetAllExpenses extends GetAllExpensesEvent {
  @override
  List<Object> get props => [];
}

// Delete expense event
abstract class DeleteExpenseEvent extends Equatable {}

class DeleteExpense extends DeleteExpenseEvent {
  final String id;

  DeleteExpense({required this.id});

  @override
  List<Object> get props => [];
}

// Update expense event
abstract class UpdateExpenseEvent extends Equatable {}

class UpdateExpense extends UpdateExpenseEvent {
  final String id;
  final String category;
  final String name;
  final double amount;
  final String date;
  final String? description;
  final String paidMethod;

  UpdateExpense({
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

// Get total expenses event
abstract class GetTotalExpensesEvent extends Equatable {}

class GetTotalExpenses extends GetTotalExpensesEvent {
  @override
  List<Object> get props => [];
}
