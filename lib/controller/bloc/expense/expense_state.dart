import 'package:equatable/equatable.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/models/outputs/base_output.dart';

// Expense state
class AddExpenseState extends Equatable {
  const AddExpenseState();
  @override
  List<Object> get props => [];
}

class LoadingAddExpense extends AddExpenseState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedAddExpense extends AddExpenseState {
  final String message;
  const UnauthenticatedAddExpense({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedAddExpense extends AddExpenseState {
  final Expenses expense;
  const AuthenticatedAddExpense({required this.expense});
  @override
  List<Object> get props => [expense];
}

// Get all expenses state
class GetAllExpensesState extends Equatable {
  const GetAllExpensesState();
  @override
  List<Object> get props => [];
}

class LoadingGetAllExpenses extends GetAllExpensesState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedGetAllExpenses extends GetAllExpensesState {
  final String message;
  const UnauthenticatedGetAllExpenses({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedGetAllExpenses extends GetAllExpensesState {
  final List<Expenses> expenses;
  const AuthenticatedGetAllExpenses({required this.expenses});
  @override
  List<Object> get props => [expenses];
}

// Delete expense state
class DeleteExpenseState extends Equatable {
  const DeleteExpenseState();
  @override
  List<Object> get props => [];
}

class LoadingDeleteExpense extends DeleteExpenseState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedDeleteExpense extends DeleteExpenseState {
  final String message;
  const UnauthenticatedDeleteExpense({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedDeleteExpense extends DeleteExpenseState {
  final BaseOutput baseOutput;
  const AuthenticatedDeleteExpense({required this.baseOutput});
  @override
  List<Object> get props => [baseOutput];
}

// Update expense state
class UpdateExpenseState extends Equatable {
  const UpdateExpenseState();
  @override
  List<Object> get props => [];
}

class LoadingUpdateExpense extends UpdateExpenseState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedUpdateExpense extends UpdateExpenseState {
  final String message;
  const UnauthenticatedUpdateExpense({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedUpdateExpense extends UpdateExpenseState {
  final Expenses expense;
  const AuthenticatedUpdateExpense({required this.expense});
  @override
  List<Object> get props => [expense];
}
