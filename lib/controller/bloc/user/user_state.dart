import 'package:equatable/equatable.dart';

// Register State
abstract class RegisterState extends Equatable {}

class LoadingRegister extends RegisterState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedRegister extends RegisterState {
  @override
  List<Object> get props => [];
}

class AuthenticatedRegister extends RegisterState {
  @override
  List<Object> get props => [];
}

// Login State
abstract class LoginState extends Equatable {}

class LoadingLogin extends LoginState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedLogin extends LoginState {
  @override
  List<Object> get props => [];
}

class AuthenticatedLogin extends LoginState {
  @override
  List<Object> get props => [];
}

