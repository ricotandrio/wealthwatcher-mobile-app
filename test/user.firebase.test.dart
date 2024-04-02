import 'package:flutter_test/flutter_test.dart';
import 'package:wealthwatcher/controller/firebase/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wealthwatcher/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // registerUserTest();
  loginUserTest();
}

void registerUserTest() {
  group('Register User Test', () {
    test('Register Repository - New Account', () async {
      RegisterRepository registerRepository = RegisterRepository();
      final user = await registerRepository.signUp(
        email: 'testunit@mail.com',
        password: 'testunit',
      );

      expect(user, isNotNull);
    });

    test('Register Repository - Already Exists', () async {
      RegisterRepository registerRepository = RegisterRepository();

      try {
        await registerRepository.signUp(
          email: 'testunit@mail.com',
          password: 'testunit',
        );
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
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

  test('Login Repository - Failed', () async {
    try {
      LoginRepository loginRepository = LoginRepository();
      await loginRepository.signIn(
        email: 'testunit@mail.com',
        password: 'password',
      );
    } catch (e) {
      expect(e, isA<Exception>());
    }
  });
}
