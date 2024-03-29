import 'package:flutter_test/flutter_test.dart';
import 'package:wealthwatcher/controller/firebase/management_repository.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wealthwatcher/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  loginUserTest();
  addExpensesTest();
  addIncomesTest();
}

void loginUserTest() {
  group('Login User Test', () {
    test('Login Repository - Correct Credentials', () async {
      LoginRepository loginRepository = LoginRepository();
      final user = await loginRepository.signIn(
        email: 'testunit@mail.com',
        password: 'testunit',
      );

      expect(user, isNotNull);
    });
  });
}

void addExpensesTest() {
  group('Add Expenses Test', () {
    test('Add Expenses Repository - New Expense', () async {
      ExpensesRepository addExpenseRepository = ExpensesRepository();
      final expense = await addExpenseRepository.addExpenses(
        category: 'Food',
        name: 'Lunch',
        amount: 10.0,
        date: '2021-10-10',
        paidMethod: 'Cash',
      );

      expect(expense, isNotNull);
    });
  });
}

void addIncomesTest() {
  group('Add Incomes Test', () {
    test('Add Incomes Repository - New Income', () async {
      IncomesRepository addIncomeRepository = IncomesRepository();
      final income = await addIncomeRepository.addIncomes(
        category: 'Salary',
        name: 'Work',
        amount: 100.0,
        date: '2021-10-10',
        paidMethod: 'Bank Transfer',
      );

      expect(income, isNotNull);
    });
  });
}
