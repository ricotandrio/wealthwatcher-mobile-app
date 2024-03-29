import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/models/outputs/base_output.dart';

// Expenses service repository
class ExpenseRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _unauthErrorCode = '500';
  final _unauthErrorMessage = 'User not logged in';

  Future<Expenses> addExpense(
      {required String category,
      required String name,
      required double amount,
      required String date,
      required String paidMethod,
      String? description}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(
            code: _unauthErrorCode, message: _unauthErrorMessage);
      }

      String id = Uuid().v4();

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .doc(id)
          .set({
        'id': id,
        'category': category,
        'name': name,
        'amount': amount,
        'date': date,
        'description': description,
        'paidMethod': paidMethod,
      });

      return Expenses(
        id: id,
        category: category,
        name: name,
        amount: amount,
        date: date,
        description: description,
        paidMethod: paidMethod,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add expenses: ${e.toString()}');
    }
  }

  Future<List<Expenses>> getAllExpenses() async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(
            code: _unauthErrorCode, message: _unauthErrorMessage);
      }

      final response = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .get();

      final List<Expenses> expenses = response.docs.isNotEmpty
          ? response.docs.map((e) => Expenses.fromMap(e.data())).toList()
          : [];

      return expenses;
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get expenses: ${e.toString()}');
    }
  }

  Future<BaseOutput> deleteExpense({required String id}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(
            code: _unauthErrorCode, message: _unauthErrorMessage);
      }

      final response = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .doc(id)
          .get();

      if (!response.exists) {
        throw Exception('Expense not found');
      }

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .doc(id)
          .delete();

      return BaseOutput(code: 200, message: "Expense deleted successfully");
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove expenses: ${e.toString()}');
    }
  }

  Future<Expenses> updateExpense(
      {required String id,
      required String category,
      required String name,
      required double amount,
      required String date,
      required String paidMethod,
      String? description}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(
            code: _unauthErrorCode, message: _unauthErrorMessage);
      }

      final response = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .doc(id)
          .get();

      if (!response.exists) {
        throw Exception('Expense not found');
      }

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .doc(id)
          .update({
        'category': category,
        'name': name,
        'amount': amount,
        'date': date,
        'description': description,
        'paidMethod': paidMethod,
      });

      return Expenses(
        id: id,
        category: category,
        name: name,
        amount: amount,
        date: date,
        description: description,
        paidMethod: paidMethod,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update expenses: ${e.toString()}');
    }
  }
}
