import 'package:equatable/equatable.dart';
import 'package:wealthwatcher/models/database/users.dart';

// Total balance event 
abstract class TotalBalanceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTotalBalance extends TotalBalanceEvent {}

// Auth event
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginAuthRequested extends AuthEvent {
  final String email;
  final String password;

  LoginAuthRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutAuthRequested extends AuthEvent {

  LogoutAuthRequested();

  @override
  List<Object> get props => [];
}

class RegisterAuthRequested extends AuthEvent {
  final String email;
  final String password;

  RegisterAuthRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GetCurrentAuthUserRequested extends AuthEvent {

  @override
  List<Object> get props => [];
} 

