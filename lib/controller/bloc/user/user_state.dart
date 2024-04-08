import 'package:equatable/equatable.dart';
import 'package:wealthwatcher/models/database/users.dart';

// Register State
abstract class RegisterState extends Equatable {
  const RegisterState();
  @override 
  List<Object> get props => [];
}

class LoadingRegister extends RegisterState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedRegister extends RegisterState {
  final String message;
  const UnauthenticatedRegister({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedRegister extends RegisterState {
  final Users user;
  const AuthenticatedRegister({required this.user});
  @override
  List<Object> get props => [user];
}

// Login State
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoadingLogin extends LoginState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedLogin extends LoginState {
  final String message;
  const UnauthenticatedLogin({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedLogin extends LoginState {
  final Users user;
  const AuthenticatedLogin({required this.user});
  @override
  List<Object> get props => [user];
}

// Logout state
abstract class LogoutState extends Equatable {
  const LogoutState();
  @override
  List<Object> get props => [];
}

class LoadingLogout extends LogoutState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedLogout extends LogoutState {
  final String message;
  const UnauthenticatedLogout({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedLogout extends LogoutState {
  final String message;
  const AuthenticatedLogout({required this.message});
  @override
  List<Object> get props => [message];
}

// Total balance state
abstract class TotalBalanceState extends Equatable {
  const TotalBalanceState();
  @override
  List<Object> get props => [];
}

class LoadingTotalBalance extends TotalBalanceState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedTotalBalance extends TotalBalanceState {
  final String message;
  const UnauthenticatedTotalBalance({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedTotalBalance extends TotalBalanceState {
  final double totalBalance;
  const AuthenticatedTotalBalance({required this.totalBalance});
  @override
  List<Object> get props => [totalBalance];
}

// Auth state
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class LoadingAuth extends AuthState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedAuth extends AuthState {
  final String message;
  const UnauthenticatedAuth({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedUserAuth extends AuthState {
  final Users user;
  const AuthenticatedUserAuth({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticatedAuth extends AuthState {
  final String message;
  const AuthenticatedAuth({required this.message});
  @override
  List<Object> get props => [message];
}
