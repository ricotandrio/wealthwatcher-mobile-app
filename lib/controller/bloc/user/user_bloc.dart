import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/user/user_state.dart';
import 'package:wealthwatcher/controller/bloc/user/user_event.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';

// Register Bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository}) : super(UnauthenticatedRegister()){
    on<RegisterRequested>((event, emit) async {
      emit(LoadingRegister());
      try {
        await registerRepository.signUp(email: event.email, password: event.password);
        
        emit(AuthenticatedRegister());
      } catch (e) {
        emit(UnauthenticatedRegister());
      }
    });
  }
}

// Login Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(UnauthenticatedLogin()){
    on<LoginRequested>((event, emit) async {
      emit(LoadingLogin());
      try {
        await loginRepository.signIn(email: event.email, password: event.password);
        emit(AuthenticatedLogin());
      } catch (e) {
        emit(UnauthenticatedLogin());
      }
    });
  }
}