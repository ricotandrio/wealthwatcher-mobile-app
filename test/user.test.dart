import 'package:flutter_test/flutter_test.dart';
import 'package:wealthwatcher/controller/services/user_service.dart';
import 'package:wealthwatcher/models/outputs/register_output.dart';

void main() {
  registerUserTest();
}

void registerUserTest() async {
  group('Register User', () {
    test('Register User - Success[200]', () async {
      UserService userService = UserService();
      final response = await userService.registerUser('test', 'test');

      print(response);
      expect(response.code, 200);
    });
  });
}

void loginUserTest () async {
  group('Login User', () {
    test('Login User - Success[200]', () async {
      UserService userService = UserService();
      final response = await userService.loginUser('test', 'test');
      print(response);
      expect(response.code, 200);
    });
  });
}