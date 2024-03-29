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
