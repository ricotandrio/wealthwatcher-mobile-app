import 'package:flutter_test/flutter_test.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wealthwatcher/firebase_options.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:wealthwatcher/models/database/incomes.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  loginUserTest();
  updateExpenseTest();
  updateIncomeTest();
}

void loginUserTest() {
  group('Login User Test Update', () {
    test('Login Repository Update - Correct Credentials', () async {
      LoginRepository loginRepository = LoginRepository();
      final user = await loginRepository.signIn(
        email: 'testunit@mail.com',
        password: 'testunit',
      );

      expect(user, isNotNull);
    });
  });
}

void updateExpenseTest() {
  group('Update Expense Test', () {
    test('Update Expense Repository - Correct ID', () async {
      ExpenseRepository expenseRepository = ExpenseRepository();

      final expense = await expenseRepository.updateExpense(
        id: '4d51d88c-9618-4f88-9223-51ad84b6ad67',
        category: 'testcategory',
        name: 'testname',
        amount: 100.0,
        date: '2021-10-10',
        description: 'testdescription',
        paidMethod: 'testpaidmethod',
      );


      expect(expense.toString(), Expenses(
        id: '4d51d88c-9618-4f88-9223-51ad84b6ad67',
        category: 'testcategory',
        name: 'testname',
        amount: 100.0,
        date: '2021-10-10',
        description: 'testdescription',
        paidMethod: 'testpaidmethod',
      ).toString());
    });
  });
}

void updateIncomeTest() {
  group('Update Income Test', () {
    test('Update Income Repository - Correct ID', () async {
      IncomeRepository incomeRepository = IncomeRepository();
      final income = await incomeRepository.updateIncome(
        id: '2b766e3b-a021-488f-8ac6-37f19f0aa531',
        category: 'testcategory',
        name: 'testname',
        amount: 100.0,
        date: '2021-10-10',
        description: 'testdescription',
        paidMethod: 'testpaidmethod',
      );

      expect(income.toString(), Incomes(
        id: '2b766e3b-a021-488f-8ac6-37f19f0aa531',
        category: 'testcategory',
        name: 'testname',
        amount: 100.0,
        date: '2021-10-10',
        description: 'testdescription',
        paidMethod: 'testpaidmethod',
      ).toString());
    });
  });
}