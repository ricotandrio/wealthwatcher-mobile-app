import 'package:equatable/equatable.dart';

// Add Income event
abstract class AddIncomeEvent extends Equatable {}

class AddIncome extends AddIncomeEvent {
  final String id;
  final String category;
  final String name;
  final double amount;
  final String date;
  final String? description;
  final String paidMethod;

  AddIncome({
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

// Get all incomes event
abstract class GetAllIncomesEvent extends Equatable {}

class GetAllIncomes extends GetAllIncomesEvent {
  @override
  List<Object> get props => [];
}

// Delete income event
abstract class DeleteIncomeEvent extends Equatable {}

class DeleteIncome extends DeleteIncomeEvent {
  final String id;

  DeleteIncome({required this.id});

  @override
  List<Object> get props => [];
}

// Update income event
abstract class UpdateIncomeEvent extends Equatable {}

class UpdateIncome extends UpdateIncomeEvent {
  final String id;
  final String category;
  final String name;
  final double amount;
  final String date;
  final String? description;
  final String paidMethod;

  UpdateIncome({
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
