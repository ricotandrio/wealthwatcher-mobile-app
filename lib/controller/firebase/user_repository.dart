import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wealthwatcher/models/database/users.dart';

// Register service repository
class RegisterRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Users> signUp(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final Users user = Users(
        firebaseid: userCredential.user!.uid,
        email: email,
        username: email.split('@').first,
        expenses: [],
        incomes: [],
      );

      await _firestore
          .collection('users')
          .doc(user.firebaseid)
          .set(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists');
      } else {
        throw Exception('FirebaseAuthException: ${e.message}');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
}

// Login service repository
class LoginRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<dynamic> signIn(
      {required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final id = user.user!.uid;

      // user collection
      final userDoc = await _firestore.collection('users').doc(id).get();

      if (!userDoc.exists) {
        throw FirebaseAuthException(
          code: '404',
          message: 'User document not found in Firestore',
        );
      }

      final userData = userDoc.data() as Map<String, dynamic>;

      return Users(
        firebaseid: id,
        email: userData['email'],
        username: userData['username'],
        expenses: [],
        incomes: [],
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('Failed to retrieve user data: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }
}

class UserRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Users getCurrentUser() {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: '404',
        message: 'User not found',
      );
    }

    return Users(
      firebaseid: user.uid,
      email: user.email!,
      username: user.email!.split('@').first,
      expenses: [],
      incomes: [],
    );
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return 'Sign out successfully';
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign out: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }
}

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Users> signIn(
      {required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final id = user.user!.uid;

      // user collection
      final userDoc = await _firestore.collection('users').doc(id).get();

      if (!userDoc.exists) {
        throw FirebaseAuthException(
          code: '404',
          message: 'User document not found in Firestore',
        );
      }

      final userData = userDoc.data() as Map<String, dynamic>;

      return Users(
        firebaseid: id,
        email: userData['email'],
        username: userData['username'],
        expenses: [],
        incomes: [],
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('Failed to retrieve user data: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

    Future<Users> signUp(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final Users user = Users(
        firebaseid: userCredential.user!.uid,
        email: email,
        username: email.split('@').first,
        expenses: [],
        incomes: [],
      );

      await _firestore
          .collection('users')
          .doc(user.firebaseid)
          .set(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists');
      } else {
        throw Exception('FirebaseAuthException: ${e.message}');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  Users getCurrentUser() {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: '404',
        message: 'User not found',
      );
    }

    return Users(
      firebaseid: user.uid,
      email: user.email!,
      username: user.email!.split('@').first,
      expenses: [],
      incomes: [],
    );
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return 'Sign out successfully';
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign out: ${e.message}');
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

}