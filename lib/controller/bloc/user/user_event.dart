import 'package:equatable/equatable.dart';

// Register Event
abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterRequested extends RegisterEvent {
  final String email;
  final String password;

  RegisterRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Login Event
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Logout Event
abstract class LogoutEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutRequested extends LogoutEvent {}

// Total balance event 
abstract class TotalBalanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTotalBalance extends TotalBalanceEvent {}
