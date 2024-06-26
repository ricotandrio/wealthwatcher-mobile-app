import 'package:equatable/equatable.dart';
import 'package:wealthwatcher/models/database/users.dart';

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
