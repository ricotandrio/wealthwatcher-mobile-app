import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';

// Total balance Bloc
class TotalBalanceBloc extends Bloc<TotalBalanceEvent, TotalBalanceState> {
  final ExpenseRepository expenseRepository;
  final IncomeRepository incomeRepository;

  TotalBalanceBloc(
      {required this.expenseRepository, required this.incomeRepository})
      : super(UnauthenticatedTotalBalance(message: '')) {
    on<GetTotalBalance>((event, emit) async {
      emit(LoadingTotalBalance());
      try {
        final totalExpenses = await expenseRepository.getTotalExpenses();
        final totalIncomes = await incomeRepository.getTotalIncomes();
        final totalBalance = totalIncomes - totalExpenses;
        emit(AuthenticatedTotalBalance(totalBalance: totalBalance));
      } catch (e) {
        emit(UnauthenticatedTotalBalance(message: e.toString()));
      }
    });
  }
}

// Auth Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(UnauthenticatedAuth(message: '')) {
    on<LoginAuthRequested>((event, emit) async {
      emit(LoadingAuth());
      try {
        final response = await authRepository.signIn(
            email: event.email, password: event.password);
        emit(AuthenticatedUserAuth(user: response));
      } catch (e) {
        emit(UnauthenticatedAuth(message: e.toString()));
      }
    });

    on<RegisterAuthRequested>((event, emit) async {
      emit(LoadingAuth());
      try {
        final response = await authRepository.signUp(
            email: event.email, password: event.password);
        emit(AuthenticatedUserAuth(user: response));
      } catch (e) {
        emit(UnauthenticatedAuth(message: e.toString()));
      }
    });

    on<LogoutAuthRequested>((event, emit) async {
      emit(LoadingAuth());
      try {
        final response = await authRepository.signOut();
        emit(AuthenticatedAuth(message: response));
      } catch (e) {
        emit(UnauthenticatedAuth(message: e.toString()));
      }
    });

    on<GetCurrentAuthUserRequested>((event, emit) async {
      emit(LoadingAuth());
      try {
        final response = await authRepository.getCurrentUser();
        emit(AuthenticatedUserAuth(user: response));
      } catch (e) {
        emit(UnauthenticatedAuth(message: e.toString()));
      }
    });
  }
}
