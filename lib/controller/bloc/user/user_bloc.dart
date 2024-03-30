import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';

// Register Bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  final UserRepository userRepository;

  RegisterBloc({required this.registerRepository, required this.userRepository}) : super(UnauthenticatedRegister(message: '')){
    on<RegisterRequested>((event, emit) async {
      emit(LoadingRegister());
      try {
        await registerRepository.signUp(email: event.email, password: event.password);
        
        emit(AuthenticatedRegister(user: userRepository.getCurrentUser()));
      } catch (e) {
        emit(UnauthenticatedRegister(message: e.toString()));
      }
    });
  }
}

// Login Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final UserRepository userRepository;

  LoginBloc({required this.loginRepository, required this.userRepository}) : super(UnauthenticatedLogin(message: '')){
    on<LoginRequested>((event, emit) async {
      emit(LoadingLogin());
      try {
        await loginRepository.signIn(email: event.email, password: event.password);
        emit(AuthenticatedLogin(user: userRepository.getCurrentUser()));
      } catch (e) {
        emit(UnauthenticatedLogin(message: e.toString()));
      }
    });
  }
}

// Logout Bloc
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final UserRepository userRepository;

  LogoutBloc({required this.userRepository}) : super(UnauthenticatedLogout(message: '')){
    on<LogoutRequested>((event, emit) async {
      emit(LoadingLogout());
      try {
        final response = await userRepository.signOut();
        emit(AuthenticatedLogout(message: response));
      } catch (e) {
        emit(UnauthenticatedLogout(message: e.toString()));
      }
    });
  }
}

// Total balance Bloc
class TotalBalanceBloc extends Bloc<TotalBalanceEvent, TotalBalanceState> {
  final ExpenseRepository expenseRepository;
  final IncomeRepository incomeRepository;

  TotalBalanceBloc({required this.expenseRepository, required this.incomeRepository}) : super(UnauthenticatedTotalBalance(message: '')){
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
