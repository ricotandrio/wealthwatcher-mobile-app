import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/income/income_event.dart';
import 'package:wealthwatcher/controller/bloc/income/income_state.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';

// Incomes bloc
class AddIncomeBloc extends Bloc<AddIncomeEvent, AddIncomeState> {
  final IncomeRepository incomeRepository;

  AddIncomeBloc({required this.incomeRepository})
      : super(UnauthenticatedAddIncome(message: '')) {
    on<AddIncome>((event, emit) async {
      emit(LoadingAddIncome());
      try {
        final response = await incomeRepository.addIncome(
          category: event.category,
          name: event.name,
          amount: event.amount,
          date: event.date,
          description: event.description,
          paidMethod: event.paidMethod,
        );
        emit(AuthenticatedAddIncome(income: response));
      } catch (e) {
        emit(UnauthenticatedAddIncome(message: e.toString()));
      }
    });

  }
}

// Get all incomes bloc
class GetAllIncomesBloc extends Bloc<GetAllIncomesEvent, GetAllIncomesState> {
  final IncomeRepository incomeRepository;

  GetAllIncomesBloc({required this.incomeRepository})
      : super(UnauthenticatedGetAllIncomes(message: '')) {
    on<GetAllIncomes>((event, emit) async {
      emit(LoadingGetAllIncomes());
      try {
        final response = await incomeRepository.getAllIncomes();
        emit(AuthenticatedGetAllIncomes(incomes: response));
      } catch (e) {
        emit(UnauthenticatedGetAllIncomes(message: e.toString()));
      }
    });
  }
}

// Delete income bloc
class DeleteIncomeBloc extends Bloc<DeleteIncomeEvent, DeleteIncomeState> {
  final IncomeRepository incomeRepository;

  DeleteIncomeBloc({required this.incomeRepository})
      : super(UnauthenticatedDeleteIncome(message: '')) {
    on<DeleteIncome>((event, emit) async {
      try {
        final response = await incomeRepository.deleteIncome(id: event.id);
        emit(AuthenticatedDeleteIncome(baseOutput: response));
      } catch (e) {
        emit(UnauthenticatedDeleteIncome(message: e.toString()));
      }
    });
  }
}

// Update income bloc
class UpdateIncomeBloc extends Bloc<UpdateIncomeEvent, UpdateIncomeState> {
  final IncomeRepository incomeRepository;

  UpdateIncomeBloc({required this.incomeRepository})
      : super(UnauthenticatedUpdateIncome(message: '')) {
    on<UpdateIncome>((event, emit) async {
      emit(LoadingUpdateIncome());
      try {
        final response = await incomeRepository.updateIncome(
          id: event.id,
          category: event.category,
          name: event.name,
          amount: event.amount,
          date: event.date,
          description: event.description,
          paidMethod: event.paidMethod,
        );
        emit(AuthenticatedUpdateIncome(income: response));
      } catch (e) {
        emit(UnauthenticatedUpdateIncome(message: e.toString()));
      }
    });
  }
}