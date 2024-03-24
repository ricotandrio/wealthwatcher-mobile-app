import 'package:wealthwatcher/models/responses/account_response.dart';

class RegisterUserOutput {
  final int code;
  final String message;
  UserResponse data;

  RegisterUserOutput({
    required this.code,
    required this.message,
    required this.data,
  });

  factory RegisterUserOutput.fromJson(Map<String, dynamic> json) {
    return RegisterUserOutput(
      code: json['code'],
      message: json['message'],
      data: UserResponse.fromJson(json['data']),
    );
  }
}
