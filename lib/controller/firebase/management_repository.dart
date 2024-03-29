import 'package:firebase_auth/firebase_auth.dart';
import 'package:wealthwatcher/models/database/expenses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wealthwatcher/models/database/incomes.dart';

// Expenses service repository
class ExpensesRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Expenses> addExpenses(
      {required String category,
      required String name,
      required double amount,
      required String date,
      required String paidMethod,
      String? description}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(code: '500', message: 'User not logged in');
      }

      DocumentReference doc = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('expenses')
          .add({
        'category': category,
        'name': name,
        'amount': amount,
        'date': date,
        'description': description,
        'paidMethod': paidMethod,
      });

      return Expenses(
        id: doc.id,
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
}

// Incomes service repository
class IncomesRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Incomes> addIncomes(
      {required String category,
      required String name,
      required double amount,
      required String date,
      required String paidMethod,
      String? description}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(code: '500', message: 'User not logged in');
      }

      DocumentReference doc = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('incomes')
          .add({
        'category': category,
        'name': name,
        'amount': amount,
        'date': date,
        'description': description,
        'paidMethod': paidMethod,
      });

      return Incomes(
        id: doc.id,
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
      throw Exception('Failed to add incomes: ${e.toString()}');
    }
  }
}
