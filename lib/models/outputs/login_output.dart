import 'package:wealthwatcher/models/responses/user_response.dart';

class LoginUserOutput {
  final int code;
  final String message;
  UserResponse data;

  LoginUserOutput({
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginUserOutput.fromJson(Map<String, dynamic> json) {
    return LoginUserOutput(
      code: json['code'],
      message: json['message'],
      data: UserResponse.fromJson(json['data']),
    );
  }
}
