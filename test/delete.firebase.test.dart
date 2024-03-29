import 'package:flutter_test/flutter_test.dart';
import 'package:wealthwatcher/controller/firebase/expense_repository.dart';
import 'package:wealthwatcher/controller/firebase/income_repository.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wealthwatcher/firebase_options.dart';
import 'package:wealthwatcher/models/outputs/base_output.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  loginUserTest();
  deleteExpenseTest();
  deleteIncomeTest();
}

void loginUserTest() {
  group('Login User Test Delete', () {
    test('Login Repository Delete - Correct Credentials', () async {
      LoginRepository loginRepository = LoginRepository();
      final user = await loginRepository.signIn(
        email: 'testunit@mail.com',
        password: 'testunit',
      );

      expect(user, isNotNull);
    });
  });
}

void deleteExpenseTest() {
  group('Delete Expense Test', () {
    test('Delete Expense Repository - Existing Expense', () async {
      ExpenseRepository deleteExpenseRepository = ExpenseRepository();
      final expense = await deleteExpenseRepository.deleteExpense(
        id: '4d51d88c-9618-4f88-9223-51ad84b6ad67',
      );

      expect(expense.toString(), BaseOutput(
        code: 200,
        message: 'Expense deleted successfully',
      ).toString());
    });
  });
}

void deleteIncomeTest() {
  group('Delete Income Test', () {
    test('Delete Income Repository - Existing Income', () async {
      IncomeRepository deleteIncomeRepository = IncomeRepository();
      final income = await deleteIncomeRepository.deleteIncome(
        id: '2b766e3b-a021-488f-8ac6-37f19f0aa531',
      );

      expect(income.toString(), BaseOutput(
        code: 200,
        message: 'Expense deleted successfully',
      ).toString());
    });
  });
}
