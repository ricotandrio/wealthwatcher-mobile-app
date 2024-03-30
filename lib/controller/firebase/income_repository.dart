import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wealthwatcher/models/database/incomes.dart';
import 'package:wealthwatcher/models/outputs/base_output.dart';

// Incomes service repository
class IncomeRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Incomes> addIncome(
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

      String id = Uuid().v4();

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('incomes')
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

      return Incomes(
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
      throw Exception('Failed to add incomes: ${e.toString()}');
    }
  }

  Future<List<Incomes>> getAllIncomes() async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(code: '500', message: 'User not logged in');
      }

      final response = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('incomes')
          .get();

      final List<Incomes> incomes = response.docs.isNotEmpty
          ? response.docs.map((e) => Incomes.fromMap(e.data())).toList()
          : [];

      return incomes;
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get incomes: ${e.toString()}');
    }
  }

  Future<BaseOutput> deleteIncome({required String id}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(code: '500', message: 'User not logged in');
      }

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('incomes')
          .doc(id)
          .delete();

      return BaseOutput(code: 200, message: "Income deleted successfully");

    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete incomes: ${e.toString()}');
    }
  }

  Future<Incomes> updateIncome(
      {required String id,
      required String category,
      required String name,
      required double amount,
      required String date,
      required String paidMethod,
      String? description}) async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(code: '500', message: 'User not logged in');
      }

      await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('incomes')
          .doc(id)
          .update({
        'category': category,
        'name': name,
        'amount': amount,
        'date': date,
        'description': description,
        'paidMethod': paidMethod,
      });

      return Incomes(
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
      throw Exception('Failed to update incomes: ${e.toString()}');
    }
  }

  Future<double> getTotalIncomes() async {
    try {
      if (_firebaseAuth.currentUser == null) {
        throw FirebaseAuthException(code: '500', message: 'User not logged in');
      }

      final response = await _firestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('incomes')
          .get();

      final List<Incomes> incomes = response.docs.isNotEmpty
          ? response.docs.map((e) => Incomes.fromMap(e.data())).toList()
          : [];

      double totalIncomes = 0.0;

      incomes.forEach((element) {
        totalIncomes += element.amount;
      });

      return totalIncomes;
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get total incomes: ${e.toString()}');
    }
  }
}
