import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_event.dart';
import 'package:wealthwatcher/controller/bloc/expense/expense_state.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';

// Add expense bloc
class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final ExpenseRepository expensesRepository;

  AddExpenseBloc({required this.expensesRepository})
      : super(UnauthenticatedAddExpense(message: '')) {
    on<AddExpense>((event, emit) async {
      emit(LoadingAddExpense());
      try {
        final response = await expensesRepository.addExpense(
          category: event.category,
          name: event.name,
          amount: event.amount,
          date: event.date,
          description: event.description,
          paidMethod: event.paidMethod,
        );
        emit(AuthenticatedAddExpense(expense: response));
      } catch (e) {
        emit(UnauthenticatedAddExpense(message: e.toString()));
      }
    });
  }
}

// Get all expenses bloc
class GetAllExpensesBloc
    extends Bloc<GetAllExpensesEvent, GetAllExpensesState> {
  final ExpenseRepository expensesRepository;

  GetAllExpensesBloc({required this.expensesRepository})
      : super(UnauthenticatedGetAllExpenses(message: '')) {
    on<GetAllExpenses>((event, emit) async {
      emit(LoadingGetAllExpenses());
      try {
        final response = await expensesRepository.getAllExpenses();
        emit(AuthenticatedGetAllExpenses(expenses: response));
      } catch (e) {
        emit(UnauthenticatedGetAllExpenses(message: e.toString()));
      }
    });
  }
}

// Delete expense bloc
class DeleteExpenseBloc extends Bloc<DeleteExpenseEvent, DeleteExpenseState> {
  final ExpenseRepository expensesRepository;

  DeleteExpenseBloc({required this.expensesRepository})
      : super(UnauthenticatedDeleteExpense(message: '')) {
    on<DeleteExpense>((event, emit) async {
      try {
        final response = await expensesRepository.deleteExpense(id: event.id);
        emit(AuthenticatedDeleteExpense(baseOutput: response));
      } catch (e) {
        emit(UnauthenticatedDeleteExpense(message: e.toString()));
      }
    });
  }
}

// Update expense bloc
class UpdateExpenseBloc extends Bloc<UpdateExpenseEvent, UpdateExpenseState> {
  final ExpenseRepository expensesRepository;

  UpdateExpenseBloc({required this.expensesRepository})
      : super(UnauthenticatedUpdateExpense(message: '')) {
    on<UpdateExpense>((event, emit) async {
      emit(LoadingUpdateExpense());
      try {
        final response = await expensesRepository.updateExpense(
          id: event.id,
          category: event.category,
          name: event.name,
          amount: event.amount,
          date: event.date,
          description: event.description,
          paidMethod: event.paidMethod,
        );
        emit(AuthenticatedUpdateExpense(expense: response));
      } catch (e) {
        emit(UnauthenticatedUpdateExpense(message: e.toString()));
      }
    });
  }
}

// Get total expenses bloc
class GetTotalExpensesBloc
    extends Bloc<GetTotalExpensesEvent, GetTotalExpensesState> {
  final ExpenseRepository expensesRepository;

  GetTotalExpensesBloc({required this.expensesRepository})
      : super(UnauthenticatedGetTotalExpenses(message: '')) {
    on<GetTotalExpenses>((event, emit) async {
      emit(LoadingGetTotalExpenses());
      try {
        final response = await expensesRepository.getTotalExpenses();
        emit(AuthenticatedGetTotalExpenses(totalExpenses: response));
      } catch (e) {
        emit(UnauthenticatedGetTotalExpenses(message: e.toString()));
      }
    });
  }
}
