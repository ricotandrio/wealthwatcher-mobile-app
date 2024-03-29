// Expenses state
import 'package:equatable/equatable.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/models/database/incomes.dart';

class AddExpensesState extends Equatable {
  const AddExpensesState();
  @override
  List<Object> get props => [];
}

class LoadingAddExpenses extends AddExpensesState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedAddExpenses extends AddExpensesState {
  final String message;
  const UnauthenticatedAddExpenses({ required this.message });
  @override
  List<Object> get props => [message];
}

class AuthenticatedAddExpenses extends AddExpensesState {
  final Expenses expenses;
  const AuthenticatedAddExpenses({ required this.expenses });
  @override
  List<Object> get props => [expenses];
}

// Incomes state
class AddIncomesState extends Equatable {
  const AddIncomesState();
  @override
  List<Object> get props => [];
}

class LoadingAddIncomes extends AddIncomesState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedAddIncomes extends AddIncomesState {
  final String message;
  const UnauthenticatedAddIncomes({ required this.message });
  @override
  List<Object> get props => [message];
}

class AuthenticatedAddIncomes extends AddIncomesState {
  final Incomes incomes;
  const AuthenticatedAddIncomes({ required this.incomes });
  @override
  List<Object> get props => [incomes];
}
