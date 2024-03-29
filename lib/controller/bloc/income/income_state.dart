import 'package:equatable/equatable.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/models/outputs/base_output.dart';

// Income state
class AddIncomeState extends Equatable {
  const AddIncomeState();
  @override
  List<Object> get props => [];
}

class LoadingAddIncome extends AddIncomeState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedAddIncome extends AddIncomeState {
  final String message;
  const UnauthenticatedAddIncome({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedAddIncome extends AddIncomeState {
  final Incomes income;
  const AuthenticatedAddIncome({required this.income});
  @override
  List<Object> get props => [income];
}

// Get all incomes state
class GetAllIncomesState extends Equatable {
  const GetAllIncomesState();
  @override
  List<Object> get props => [];
}

class LoadingGetAllIncomes extends GetAllIncomesState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedGetAllIncomes extends GetAllIncomesState {
  final String message;
  const UnauthenticatedGetAllIncomes({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedGetAllIncomes extends GetAllIncomesState {
  final List<Incomes> incomes;
  const AuthenticatedGetAllIncomes({required this.incomes});
  @override
  List<Object> get props => [incomes];
}

// Delete income state
class DeleteIncomeState extends Equatable {
  const DeleteIncomeState();
  @override
  List<Object> get props => [];
}

class LoadingDeleteIncome extends DeleteIncomeState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedDeleteIncome extends DeleteIncomeState {
  final String message;
  const UnauthenticatedDeleteIncome({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedDeleteIncome extends DeleteIncomeState {
  final BaseOutput baseOutput;
  const AuthenticatedDeleteIncome({required this.baseOutput});
  @override
  List<Object> get props => [baseOutput];
}

// Update income state
class UpdateIncomeState extends Equatable {
  const UpdateIncomeState();
  @override
  List<Object> get props => [];
}

class LoadingUpdateIncome extends UpdateIncomeState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedUpdateIncome extends UpdateIncomeState {
  final String message;
  const UnauthenticatedUpdateIncome({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedUpdateIncome extends UpdateIncomeState {
  final Incomes income;
  const AuthenticatedUpdateIncome({required this.income});
  @override
  List<Object> get props => [income];
}
