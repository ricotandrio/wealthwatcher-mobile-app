import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists');
      }
      
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
}

class LoginRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn({required String email, required String password }) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch(e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  } 
}