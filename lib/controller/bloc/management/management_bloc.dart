// Expenses bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/management/management_event.dart';
import 'package:wealthwatcher/controller/bloc/management/management_state.dart';
import 'package:wealthwatcher/controller/firebase/management_repository.dart';

// Add expenses bloc
class AddExpenseBloc extends Bloc<AddExpensesEvent, AddExpensesState> {
  final ExpensesRepository expensesRepository;

  AddExpenseBloc({required this.expensesRepository})
      : super(UnauthenticatedAddExpenses(message: '')) {
    on<AddExpenses>((event, emit) async {
      emit(LoadingAddExpenses());
      try {
        final response = await expensesRepository.addExpenses(
          category: event.category,
          name: event.name,
          amount: event.amount,
          date: event.date,
          description: event.description,
          paidMethod: event.paidMethod,
        );
        emit(AuthenticatedAddExpenses(expenses: response));
      } catch (e) {
        emit(UnauthenticatedAddExpenses(message: e.toString()));
      }
    });
  }
}

// Incomes bloc
class AddIncomeBloc extends Bloc<AddIncomesEvent, AddIncomesState> {
  final IncomesRepository incomesRepository;

  AddIncomeBloc({required this.incomesRepository})
      : super(UnauthenticatedAddIncomes(message: '')) {
    on<AddIncomes>((event, emit) async {
      emit(LoadingAddIncomes());
      try {
        final response = await incomesRepository.addIncomes(
          category: event.category,
          name: event.name,
          amount: event.amount,
          date: event.date,
          description: event.description,
          paidMethod: event.paidMethod,
        );
        emit(AuthenticatedAddIncomes(incomes: response));
      } catch (e) {
        emit(UnauthenticatedAddIncomes(message: e.toString()));
      }
    });
  }
}