import 'package:flutter_test/flutter_test.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wealthwatcher/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  loginUserTest();
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

void logoutUserTest() {
  group('Logout User Test', () {
    test('Logout Repository - Correct Credentials', () async {
      UserRepository logoutRepository = UserRepository();
      final user = await logoutRepository.signOut();

      expect(user, isNotNull);
    });
  });
}